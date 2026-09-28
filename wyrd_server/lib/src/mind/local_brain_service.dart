import 'dart:math';

import '../generated/protocol.dart';
import 'library_knowledge.dart';
import 'library_search.dart';
import 'library_service.dart';
import 'memory_recall_service.dart';
import 'page_reader_service.dart';
import 'thread_service.dart';
import 'wordnet_service.dart';
import 'world_countries_data.dart';
import 'package:serverpod/serverpod.dart';

/// Whether WYRD may call outside AI services (Claude for talking, Voyage for meaning search).
/// Set with `scloud password set wyrdLlmMode off` to run on its own brain alone; the default,
/// 'fallback', answers without an API first and only calls Claude when it can't.
class LlmMode {
  static bool off(Session session) => (session.passwords['wyrdLlmMode'] ?? '').trim().toLowerCase() == 'off';
}

/// A reply WYRD worked out on its own.
class LocalAnswer {
  LocalAnswer(this.text, {this.action, this.read, this.item, this.kind = 'local'});
  final String text;
  final ChatAction? action;

  /// The slice read for it, if any (goes to the thread and My Library).
  final PageSlice? read;

  /// The My Library item it was read from, if any.
  final ReadingItem? item;

  /// What handled it ('reading', 'definition', 'memory', 'map', 'library', 'recall'), for logs.
  final String kind;
}

/// WYRD's own brain: everything it can do well without calling an AI. It handles reading
/// (find a book, read a page, continue where you stopped), dictionary meanings from its own
/// WordNet, what it knows about you, where a country is, and what's in your library. [answer]
/// returns null when the message needs real conversation, and [fromMemory] composes a reply from
/// what WYRD recalled when no AI is available.
class LocalBrainService {
  static final _continue = RegExp(
    r"^\s*(?:please\s+)?(?:continue|keep (?:reading|going)|go on|carry on|read on|read more|next(?: page| part| bit| section| chapter)?|more please)(?:\s+reading)?(?:\s+(.+?))?\s*[.!?]*\s*$",
    caseSensitive: false,
  );
  static final _book = RegExp(
    r"""^\s*(?:can you |could you |please |let'?s |i want to |i'?d like to )?(?:find|get|read|open|pull up|fetch|start)(?: me| us)?(?: the)? (?:book|novel)s?\s+["“']?(.+?)["”']?(?:\s+by\s+(.+?))?\s*[.!?]*\s*$""",
    caseSensitive: false,
  );
  static final _readBy = RegExp(
    r"""^\s*(?:can you |could you |please |let'?s )?(?:read|find)(?: me)?\s+["“']?(.+?)["”']?\s+by\s+(.+?)\s*[.!?]*\s*$""",
    caseSensitive: false,
  );
  // "find me a physics book", "recommend a book about volcanoes"
  static final _topicBook = RegExp(
    r"""^\s*(?:can you |could you |please |i need |i want )?(?:find|get|recommend|suggest|show|give|open|pull up)(?: me| us)?\s+(?:a |an |some |the )?(?:good |free |nice )?(?:(?:text)?books?\s+(?:on|about|for)\s+(.+?)|(.+?)\s+(?:text)?books?)\s*[.!?]*\s*$""",
    caseSensitive: false,
  );
  static final _summary = RegExp(r"\b(summari[sz]e|sum (?:it|this|that) up|summary|tl;?dr|main (?:idea|point)s?|what (?:happened|happens)|gist)\b", caseSensitive: false);
  static final _whoWhat = RegExp(r"""^\s*(?:who|what)(?:'s| is| are| was| were| does)\s+["']?(.+?)["']?(?:\s+mean)?\s*[?.!]*\s*$""", caseSensitive: false);
  static final _inLanguage = RegExp(
    r"^\s*(?:please |can you |could you )?(?:find|read|open|get|fetch)(?: me)?\s+(.+\s+(?:in|en)\s+[A-Za-zÀ-ÿ]+)\s*[.!?]*\s*$",
    caseSensitive: false,
  );
  static final _readUrl = RegExp(r"\b(?:read|open|summari[sz]e)\b.*?(https?://\S+)", caseSensitive: false);
  static final _define = RegExp(
    r"""^\s*(?:what does|what's the meaning of|what is the meaning of|what's the definition of|what is the definition of|define|meaning of|definition of|what is an?|what's an?|what are|what is|what's)\s+["']?([a-z][a-z' -]{1,40}?)["']?(?:\s+mean)?\s*[?.!]*\s*$""",
    caseSensitive: false,
  );
  static final _aboutMe = RegExp(r"\bwhat (?:do you know|have you learned|do you remember) about me\b", caseSensitive: false);
  static final _myName = RegExp(r"\bwhat(?:'s| is) my name\b|\bdo you know my name\b|\bwho am i\b", caseSensitive: false);
  static final _where = RegExp(
    r"^\s*(?:where is|where's|show me|locate)\s+(.+?)(?:\s+on (?:the|a) (?:map|globe))?\s*[?.!]*\s*$",
    caseSensitive: false,
  );
  static final _capital = RegExp(r"^\s*(?:what(?:'s| is) the )?capital (?:city )?of\s+(.+?)\s*[?.!]*\s*$", caseSensitive: false);
  static final _library = RegExp(r"\b(?:my library|what am i reading|what (?:books|pages) (?:am i|are we) reading|my books)\b", caseSensitive: false);

  static const _notAWord = {'up', 'new', 'happening', 'going on', 'wrong', 'next', 'good', 'right', 'there', 'here', 'now', 'today', 'going'};

  static const _passageChars = 2400; // what fits comfortably in a chat bubble

  static Future<LocalAnswer?> answer(
    Session session, {
    required UuidValue authUserId,
    required String text,
    required ChatThread? thread,
    required List<String> facts,
    bool followUp = false,
  }) async {
    final t = text.trim();
    if (t.isEmpty || t.length > 300) return null;

    // reading
    final cont = _continue.firstMatch(t);
    if (cont != null) return _continueReading(session, authUserId, thread, cont.group(1));
    final url = _readUrl.firstMatch(t)?.group(1);
    if (url != null) return _read(session, authUserId, url.replaceAll(RegExp(r'[).,!?]+$'), ''));
    final book = _book.firstMatch(t) ?? _readBy.firstMatch(t);
    if (book != null) return _findBook(session, authUserId, book.group(1)!, book.group(2));
    // "find Les Misérables in French": that language's Wikisource
    final inLang = _inLanguage.firstMatch(t);
    if (inLang != null && LibrarySearch.splitLanguage(inLang.group(1)!).$2 != null) {
      return _findBook(session, authUserId, inLang.group(1)!, null);
    }
    final topic = _topicBook.firstMatch(t);
    if (topic != null && _words(topic.group(1) ?? topic.group(2)!).isNotEmpty) return _findBook(session, authUserId, (topic.group(1) ?? topic.group(2))!, null, topic: true);
    if (_library.hasMatch(t)) return _libraryList(session, authUserId);

    // what they're reading
    if (ThreadService.aboutReading(thread, t, followUp: followUp)) {
      final a = await _aboutPassage(session, thread!, t);
      if (a != null) return a;
    }

    // you
    if (_myName.hasMatch(t)) {
      final name = facts.firstWhere((f) => f.toLowerCase().startsWith('name:'), orElse: () => '');
      return LocalAnswer(
        name.isEmpty ? "You haven't told me your name yet. What should I call you?" : "You're ${name.substring(5).trim()}.",
        kind: 'memory',
      );
    }
    if (_aboutMe.hasMatch(t)) {
      return LocalAnswer(
        facts.isEmpty
            ? "Not much yet — tell me about yourself and I'll remember it."
            : "Here's what I remember about you: ${facts.take(12).join('; ')}.",
        kind: 'memory',
      );
    }

    // places
    final where = _where.firstMatch(t);
    if (where != null) {
      final country = _country(where.group(1)!);
      if (country != null) {
        final area = country.subregion.isNotEmpty ? country.subregion : country.region;
        return LocalAnswer(
          "${country.name} is in $area, around ${_deg(country.lat, 'N', 'S')}, ${_deg(country.lng, 'E', 'W')}. ${_countryFacts(country)} I've opened the map on it.",
          action: ChatAction(type: 'open_world_map', country: country.name),
          kind: 'map',
        );
      }
    }
    final capital = _capital.firstMatch(t);
    if (capital != null) {
      final country = _country(capital.group(1)!);
      if (country != null && country.capital != null) {
        return LocalAnswer(
          'The capital of ${country.name} is ${country.capital}.',
          action: ChatAction(type: 'open_world_map', country: country.name),
          kind: 'map',
        );
      }
    }

    // words
    final def = _define.firstMatch(t);
    if (def != null) {
      final a = await _definition(session, def.group(1)!.trim().toLowerCase());
      if (a != null) return a;
    }
    return null;
  }

  /// A reply built from what WYRD recalled, for when no AI can be called.
  static String? fromMemory(RecallContext recall) {
    String clip(String s) => s.length > 500 ? '${s.substring(0, 500).trimRight()}…' : s;
    if (recall.digested.isNotEmpty) return "Here's what I've worked out about that: ${clip(recall.digested.first)}";
    if (recall.knowledge.isNotEmpty) return "Here's what I've read on that: ${clip(recall.knowledge.first)}";
    if (recall.definitions.isNotEmpty) return 'What I know of the words: ${clip(recall.definitions.take(2).join(' | '))}';
    if (recall.pastChats.isNotEmpty) return 'We talked about this before: ${clip(recall.pastChats.first)}';
    return null;
  }

  // ---- reading

  static String _passage(PageSlice s) {
    var body = s.text;
    if (body.length > _passageChars) {
      final cut = body.lastIndexOf(RegExp(r'[.!?]\s'), _passageChars);
      body = body.substring(0, cut > _passageChars * 0.6 ? cut + 1 : _passageChars).trimRight();
    }
    return body;
  }

  /// Reads from [offset] but hands back only a chat-sized passage, and records where that stopped.
  static Future<LocalAnswer> _slice(Session session, UuidValue me, String url, int offset, {required String intro}) async {
    final full = await PageReaderService.read(url, offset: offset);
    final body = _passage(full);
    final shown = PageSlice(url: full.url, title: full.title, text: body, offset: full.offset, total: full.total);
    await LibraryService.record(session, me, shown);
    final pct = full.total == 0 ? 100 : (((shown.nextOffset ?? full.total) / full.total) * 100).round();
    final tail = shown.nextOffset == null ? "\n\n(That's the end.)" : '\n\n— $pct% through. Say "continue" for more.';
    return LocalAnswer('$intro\n\n${_forChat(body)}$tail', read: shown, kind: 'reading');
  }

  static Future<LocalAnswer> _continueReading(Session session, UuidValue me, ChatThread? thread, String? what) async {
    ReadingItem? item;
    if (what != null && what.trim().isNotEmpty) item = await LibraryService.find(session, me, what);
    if (item == null && (what == null || what.trim().isEmpty) && thread?.lastReadItemId != null) {
      final last = await ReadingItem.db.findById(session, thread!.lastReadItemId!);
      if (last != null && last.authUserId == me) item = last;
    }
    String? url = item?.url ?? thread?.lastReadUrl;
    int? offset = item != null ? item.nextOffset : thread?.nextOffset;
    if (url == null) {
      final recent = await LibraryService.list(session, me, limit: 1);
      if (recent.isEmpty) return LocalAnswer("We haven't started reading anything yet. Name a book and I'll find it.", kind: 'reading');
      item = recent.first;
      url = item.url;
      offset = item.nextOffset;
    }
    final u = url;
    item ??= await ReadingItem.db.findFirstRow(session, where: (t) => t.authUserId.equals(me) & t.url.equals(u));
    final title = item?.title ?? thread?.lastReadTitle ?? u;
    // the library is the most accurate record of where they stopped, and knows works in parts
    if (item != null) {
      if (LibraryService.finished(item)) {
        return LocalAnswer('We reached the end of "$title". Want to start it again or pick something new?', kind: 'reading');
      }
      try {
        final r = await LibraryService.readOn(session, me, item, maxChars: _passageChars);
        if (r == null) return LocalAnswer('We reached the end of "$title".', kind: 'reading');
        final (updated, slice) = r;
        final pct = (LibraryService.progress(updated) * 100).round();
        final where = LibraryService.inParts(updated) && updated.partTitle != null ? ' — ${updated.partTitle}' : '';
        final tail = LibraryService.finished(updated) ? "\n\n(That's the end.)" : '\n\n— $pct% through. Say "continue" for more.';
        return LocalAnswer('Picking up "$title"$where:\n\n${_forChat(slice.text)}$tail', read: slice, item: updated, action: _openBook(updated), kind: 'reading');
      } catch (e) {
        return LocalAnswer("I couldn't reach \"$title\" just now (${_why(e)}). Try again in a moment?", kind: 'reading');
      }
    }
    if (offset == null) return LocalAnswer('We reached the end of "$title". Want to start it again or pick something new?', kind: 'reading');
    try {
      return await _slice(session, me, u, offset, intro: 'Picking up "$title":');
    } catch (e) {
      return LocalAnswer("I couldn't reach \"$title\" just now (${_why(e)}). Try again in a moment?", kind: 'reading');
    }
  }

  static Future<LocalAnswer> _read(Session session, UuidValue me, String url) async {
    try {
      return await _slice(session, me, url, 0, intro: 'Reading it now:');
    } catch (e) {
      return LocalAnswer("I couldn't read that page (${_why(e)}).", kind: 'reading');
    }
  }

  static ChatAction _openBook(ReadingItem item) => ChatAction(type: 'open_book', readingItemId: item.id);

  static Set<String> _words(String s) => LibrarySearch.words(s);

  /// Finds [title] (or a book on [title] when [topic]) across all the Academy's libraries (see
  /// LibrarySearch: OpenStax textbooks, Wikisource in the reader's language, Gutenberg), opens it
  /// where they left off, adds it to My Library, shows the passage, and asks the app to open it
  /// in the Academy. "… in French" searches that language's Wikisource.
  static Future<LocalAnswer> _findBook(Session session, UuidValue me, String title, String? author, {bool topic = false}) async {
    final q = title.trim().replaceAll(RegExp(r'^the\s+', caseSensitive: false), '');
    (String, String, String?)? pick; // source, id, author
    String? label;
    final List<WorkHit> hits;
    try {
      hits = await LibrarySearch.all(q, author: author, topic: topic, limit: 1);
    } catch (e) {
      return LocalAnswer("I couldn't search the libraries just now (${_why(e)}).", kind: 'reading');
    }
    if (hits.isNotEmpty) {
      final h = hits.first;
      pick = (h.source, h.id, h.source == 'openstax' ? 'OpenStax' : h.author);
      label = switch (h.source) {
        'openstax' => '"${h.title}", a free OpenStax textbook',
        'wikisource' => '"${h.title}" from the Wikisource archive',
        _ => '"${h.title}"${h.author == null ? '' : ' by ${h.author}'}',
      };
    }
    if (pick == null) {
      return LocalAnswer(
        topic
            ? "I couldn't find a free book on \"$q\". Try another subject, or browse the Lecture Hall in the Academy."
            : "I couldn't find \"$q\" in any free library. Books still under copyright can't be there yet — is there another you'd like?",
        kind: 'reading',
      );
    }
    try {
      final opened = await LibraryService.openWork(session, me, pick.$1, pick.$2, maxChars: _passageChars, author: pick.$3);
      if (opened == null) return LocalAnswer("I found ${label ?? 'it'} but there's nothing left to read.", kind: 'reading');
      final (item, slice) = opened;
      final resumed = (item.lastOffset ?? 0) > 0 || (item.partIndex ?? 0) > 0;
      final pct = (LibraryService.progress(item) * 100).round();
      final where = LibraryService.inParts(item) && item.partTitle != null ? ' — ${item.partTitle}' : '';
      final intro = resumed
          ? "We're already reading $label — picking up where you left off$where:"
          : "Found $label. I've put it on your desk in the Academy$where:";
      final tail = LibraryService.finished(item)
          ? "\n\n(That's the end.)"
          : '\n\n— $pct% through. Say "continue" for more, or ask me anything about it.';
      return LocalAnswer('$intro\n\n${_forChat(slice.text)}$tail', read: slice, item: item, action: _openBook(item), kind: 'reading');
    } catch (e) {
      return LocalAnswer("I found ${label ?? 'it'} but couldn't open it just now (${_why(e)}).", kind: 'reading');
    }
  }

  /// Questions about the passage they're reading, answered from the passage itself.
  static Future<LocalAnswer?> _aboutPassage(Session session, ChatThread thread, String question) async {
    final passage = thread.lastPassage!;
    final title = (thread.lastReadTitle ?? 'the book').replaceAll(RegExp(r'\s*\|.*$'), '');
    if (_summary.hasMatch(question)) {
      final s = LibraryKnowledge.summary(passage);
      if (s.isEmpty) return null;
      return LocalAnswer('The gist of the passage from "$title":\n\n${s.map((x) => '• $x').join('\n')}', kind: 'reading');
    }
    final ww = _whoWhat.firstMatch(question);
    if (ww != null) {
      final subject = ww.group(1)!.trim();
      final last = subject.toLowerCase().split(' ').last;
      final hits = LibraryKnowledge.relevant(passage, subject, max: 2).where((x) => x.toLowerCase().contains(last)).toList();
      if (hits.isNotEmpty) {
        final meaning = subject.split(' ').length <= 3 ? await _definition(session, subject.toLowerCase()) : null;
        final quote = hits.map((x) => '"$x"').join(' … ');
        return LocalAnswer(
          'In "$title", the passage says: $quote'
          '${meaning == null ? '' : '\n\nThe dictionary meaning — ${meaning.text}'}',
          kind: 'reading',
        );
      }
    }
    return null; // needs real conversation: the AI gets the passage in its prompt
  }

  /// The sentences of what they're reading that bear on [question], for when no AI can answer.
  static String? fromPassage(ChatThread? thread, String question) {
    if (!ThreadService.isReading(thread)) return null;
    final hits = LibraryKnowledge.relevant(thread!.lastPassage!, question);
    if (hits.isEmpty) return null;
    final title = (thread.lastReadTitle ?? 'the book').replaceAll(RegExp(r'\s*\|.*$'), '');
    return 'Here\'s what the passage from "$title" says about that:\n\n${hits.map((x) => '"$x"').join('\n\n')}';
  }

  static Future<LocalAnswer> _libraryList(Session session, UuidValue me) async {
    final items = await LibraryService.list(session, me, limit: 8);
    if (items.isEmpty) return LocalAnswer("Your library's empty so far. Name a book and we'll start it.", kind: 'library');
    final lines = items.map((i) => '"${i.title}" (${(LibraryService.progress(i) * 100).round()}%)').join(', ');
    return LocalAnswer('You\'re reading: $lines. Say "continue" to pick up the latest, or "continue <title>".', kind: 'library');
  }

  /// A passage as plain chat text: no heading marks or italic underscores.
  static String _forChat(String s) => s
      .replaceAll(RegExp(r'^## ', multiLine: true), '')
      .replaceAllMapped(RegExp(r'_([^_\n]+)_'), (m) => m.group(1)!);

  static String _why(Object e) => e.toString().replaceFirst('Exception: ', '');

  // ---- places

  static WorldCountryData? _country(String name) {
    final n = name.trim().toLowerCase().replaceFirst(RegExp(r'^the\s+'), '');
    if (n.isEmpty || n.length > 60) return null;
    return worldCountries.where((c) => c.name.toLowerCase() == n || c.cca3.toLowerCase() == n).firstOrNull;
  }

  static String _countryFacts(WorldCountryData c) => [
        if (c.capital != null) 'Its capital is ${c.capital}.',
        if (c.languages.isNotEmpty) 'People speak ${c.languages.take(3).join(', ')}.',
        if (c.currencies.isNotEmpty) 'The currency is the ${c.currencies.first}.',
      ].join(' ');

  static String _deg(double v, String pos, String neg) => '${v.abs().toStringAsFixed(0)}°${v >= 0 ? pos : neg}';

  // ---- words

  static Future<LocalAnswer?> _definition(Session session, String phrase) async {
    // one word or a known compound ("black hole"); longer questions need real conversation
    if (phrase.split(RegExp(r'\s+')).length > 3) return null;
    // small talk and questions about something specific, not a word ("what's up", "what is your name")
    if (_notAWord.contains(phrase) || RegExp(r'^(?:my|your|our|their|his|her|its|the|this|that|it|you|i|we|they)\b').hasMatch(phrase)) {
      return null;
    }
    final lemma = phrase.replaceAll(' ', '_');
    var senses = await WordSense.db.find(session, where: (t) => t.lemma.equals(lemma), orderBy: (t) => t.rank, limit: 3);
    if (senses.isEmpty && !phrase.contains(' ')) {
      final base = (await WordNetService.known(session, [phrase]))[phrase];
      if (base != null) senses = await WordSense.db.find(session, where: (t) => t.lemma.equals(base), orderBy: (t) => t.rank, limit: 3);
    }
    if (senses.isEmpty) return null;
    final first = senses.first;
    final kind = first.hypernym != null ? ' — a kind of ${first.hypernym!.replaceAll('_', ' ')}' : '';
    final example = first.example != null ? ' For example: "${first.example}".' : '';
    final syn = first.synonyms.where((s) => s != first.lemma).take(3).map((s) => s.replaceAll('_', ' ')).toList();
    final more = senses.skip(1).take(min(2, senses.length - 1)).map((s) => s.definition).toList();
    return LocalAnswer(
      '${_cap(phrase)} (${_pos(first.pos)}): ${first.definition}$kind.$example'
      '${syn.isEmpty ? '' : ' Also called ${syn.join(', ')}.'}'
      '${more.isEmpty ? '' : ' It can also mean: ${more.join('; ')}.'}',
      kind: 'definition',
    );
  }

  static String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  static String _pos(String p) => switch (p) { 'n' => 'noun', 'v' => 'verb', 'a' || 's' => 'adjective', 'r' => 'adverb', _ => p };
}
