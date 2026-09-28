import '../generated/protocol.dart';
import 'library_knowledge.dart';
import 'page_reader_service.dart';
import 'thread_service.dart';
import 'works_service.dart';
import 'package:serverpod/serverpod.dart';

/// My Library: every book, textbook and page a person reads with WYRD, and how far they've got.
/// Reading on is a plain fetch of the next slice -- no AI call.
///
/// Single texts (Gutenberg books, web pages) are one long text read by offset. Works in parts
/// (OpenStax textbook sections, Wikisource chapters) are read part by part: [ReadingItem.partIndex]
/// is the part, [ReadingItem.nextOffset] the place within it (null once that part is done).
class LibraryService {
  static String kindOf(String url) => url.contains('gutenberg.org') ? 'book' : 'page';

  static bool inParts(ReadingItem item) => item.source == 'openstax' || item.source == 'wikisource';

  static String _workId(ReadingItem item) => item.url.substring(item.url.indexOf(':') + 1);

  /// True when the whole item has been read.
  static bool finished(ReadingItem item) =>
      item.nextOffset == null && (!inParts(item) || (item.partIndex ?? 0) >= (item.partCount ?? 1) - 1);

  static double progress(ReadingItem item) {
    final within = item.total == 0 ? 1.0 : ((item.nextOffset ?? item.total) / item.total).clamp(0.0, 1.0);
    if (!inParts(item)) return within;
    final count = item.partCount ?? 1;
    return (((item.partIndex ?? 0) + within) / count).clamp(0.0, 1.0);
  }

  /// Remembers that [authUserId] read [slice] of a single text.
  static Future<ReadingItem> record(Session session, UuidValue authUserId, PageSlice slice) async {
    final now = DateTime.now().toUtc();
    final existing = await ReadingItem.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.url.equals(slice.url),
    );
    if (existing == null) {
      return ReadingItem.db.insertRow(
        session,
        ReadingItem(
          authUserId: authUserId,
          url: slice.url,
          title: slice.title,
          kind: kindOf(slice.url),
          source: kindOf(slice.url) == 'book' ? 'gutenberg' : 'page',
          nextOffset: slice.nextOffset,
          lastOffset: slice.offset,
          total: slice.total,
          startedAt: now,
          updatedAt: now,
        ),
      );
    }
    return ReadingItem.db.updateRow(
      session,
      existing.copyWith(
        title: inParts(existing) ? existing.title : slice.title,
        nextOffset: slice.nextOffset,
        lastOffset: slice.offset,
        total: slice.total,
        updatedAt: now,
      ),
    );
  }

  static Future<List<ReadingItem>> list(Session session, UuidValue authUserId, {int limit = 60}) =>
      ReadingItem.db.find(
        session,
        where: (t) => t.authUserId.equals(authUserId),
        orderBy: (t) => t.updatedAt.desc(),
        limit: limit,
      );

  /// Trims [s] to at most [max] characters at a sentence break, so a chat bubble shows a passage
  /// and the place recorded is exactly where it stopped.
  static PageSlice trim(PageSlice s, int max) {
    if (s.text.length <= max) return s;
    final cut = s.text.lastIndexOf(RegExp(r'[.!?]\s'), max);
    final body = s.text.substring(0, cut > max * 0.6 ? cut + 1 : max).trimRight();
    return PageSlice(url: s.url, title: s.title, text: body, offset: s.offset, total: s.total);
  }

  /// The next slice of [item] (or its start again with [restart], or the start of part
  /// [jumpToPart]), recorded as read. Null when it's all been read. [maxChars] trims the slice
  /// (chat); the Academy reads full slices.
  static Future<(ReadingItem, PageSlice)?> readOn(
    Session session,
    UuidValue authUserId,
    ReadingItem item, {
    bool restart = false,
    int? jumpToPart,
    int? maxChars,
  }) async {
    if (!inParts(item)) {
      final offset = restart ? 0 : item.nextOffset;
      if (offset == null) return null; // finished
      var slice = await PageReaderService.read(item.url, offset: offset);
      if (maxChars != null) slice = trim(slice, maxChars);
      return _after(session, authUserId, await record(session, authUserId, slice), slice);
    }

    final parts = await WorksService.parts(item.source!, _workId(item));
    var index = restart ? 0 : (jumpToPart ?? item.partIndex ?? 0);
    int? offset = restart || jumpToPart != null ? 0 : item.nextOffset;
    if (offset == null) {
      // that part is done: on to the next
      index++;
      offset = 0;
    }
    if (index >= parts.length) return null;
    index = index.clamp(0, parts.length - 1);
    final part = parts[index];
    final text = await WorksService.text(item.source!, part);
    var slice = PageReaderService.sliceText(url: part.url, title: part.title, text: text, offset: offset);
    if (maxChars != null) slice = trim(slice, maxChars);
    final updated = await ReadingItem.db.updateRow(
      session,
      item.copyWith(
        partIndex: index,
        partCount: parts.length,
        partTitle: part.title,
        partUrl: part.url,
        nextOffset: slice.nextOffset,
        lastOffset: slice.offset,
        total: slice.total,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    return _after(session, authUserId, updated, slice);
  }

  /// After every read from the library: the passage becomes WYRD's knowledge, and the chat
  /// thread learns what this person is reading, so Dialogue Link can talk about it.
  static Future<(ReadingItem, PageSlice)> _after(Session session, UuidValue authUserId, ReadingItem item, PageSlice slice) async {
    try {
      await LibraryKnowledge.absorb(session, item, slice);
    } catch (e) {
      session.log('[library] could not keep the passage as knowledge: $e', level: LogLevel.warning);
    }
    await ThreadService.update(session, authUserId, subject: const [], lastRead: slice, item: item);
    return (item, slice);
  }

  /// The passage shown last for [item], again, without moving on (to reopen it in the Academy).
  static Future<(ReadingItem, PageSlice)?> current(Session session, UuidValue authUserId, ReadingItem item) async {
    final at = item.lastOffset ?? 0;
    if (!inParts(item)) {
      final slice = await PageReaderService.read(item.url, offset: at);
      return (item, slice);
    }
    final parts = await WorksService.parts(item.source!, _workId(item));
    final index = (item.partIndex ?? 0).clamp(0, parts.length - 1);
    final text = await WorksService.text(item.source!, parts[index]);
    return (item, PageReaderService.sliceText(url: parts[index].url, title: parts[index].title, text: text, offset: at));
  }

  /// Opens [source]/[id] (an OpenStax textbook, a Wikisource work, or a Gutenberg query) for this
  /// person: where they left off if it's on their desk, otherwise at the start.
  static Future<(ReadingItem, PageSlice)?> openWork(
    Session session,
    UuidValue authUserId,
    String source,
    String id, {
    int? maxChars,
    String? author,
  }) async {
    if (source == 'gutenberg') {
      // a book picked from search results: its own text address; anything else is a title to find
      if (!RegExp(r'^https://www\.gutenberg\.org/cache/epub/\d+/pg\d+\.txt$').hasMatch(id)) {
        return openBook(session, authUserId, id, maxChars: maxChars);
      }
      final mine = await ReadingItem.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId) & t.url.equals(id));
      final start = mine == null || finished(mine) ? 0 : mine.nextOffset ?? 0;
      var slice = await PageReaderService.read(id, offset: start);
      if (maxChars != null) slice = trim(slice, maxChars);
      var item = await record(session, authUserId, slice);
      if (item.author == null && author != null) item = await ReadingItem.db.updateRow(session, item.copyWith(author: author));
      return _after(session, authUserId, item, slice);
    }
    final url = WorksService.key(source, id);
    var item = await ReadingItem.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId) & t.url.equals(url));
    if (item == null) {
      final parts = await WorksService.parts(source, id);
      final (title, author) = await WorksService.describe(source, id);
      final now = DateTime.now().toUtc();
      item = await ReadingItem.db.insertRow(
        session,
        ReadingItem(
          authUserId: authUserId,
          url: url,
          title: title,
          kind: source == 'openstax' ? 'textbook' : 'book',
          source: source,
          author: author,
          partIndex: 0,
          partCount: parts.length,
          partTitle: parts.first.title,
          partUrl: parts.first.url,
          nextOffset: 0,
          total: 0,
          startedAt: now,
          updatedAt: now,
        ),
      );
    }
    return readOn(session, authUserId, item, restart: finished(item), maxChars: maxChars);
  }

  /// The table of contents of a work in parts.
  static Future<List<WorkPartInfo>> contents(ReadingItem item) async {
    if (!inParts(item)) return [];
    final parts = await WorksService.parts(item.source!, _workId(item));
    return [for (var i = 0; i < parts.length; i++) WorkPartInfo(index: i, title: parts[i].title, url: parts[i].url)];
  }

  /// The item whose title best matches [query] (words in common), or null.
  static Future<ReadingItem?> find(Session session, UuidValue authUserId, String query) async {
    final words = _words(query);
    if (words.isEmpty) return null;
    ReadingItem? best;
    var bestScore = 0.0;
    for (final item in await list(session, authUserId)) {
      final t = _words(item.title);
      if (t.isEmpty) continue;
      final score = words.intersection(t).length / words.length;
      if (score > bestScore) {
        best = item;
        bestScore = score;
      }
    }
    return bestScore >= 0.5 ? best : null;
  }

  static Set<String> _words(String s) => RegExp(r'[a-z0-9]{3,}')
      .allMatches(s.toLowerCase())
      .map((m) => m.group(0)!)
      .where((w) => !const {'the', 'and', 'book', 'reading', 'continue', 'read'}.contains(w))
      .toSet();

  /// Finds a public-domain book for [query] on Project Gutenberg and opens it: from where this
  /// person stopped if they've started it, otherwise from the beginning. Null when there's no
  /// such free book.
  static Future<(ReadingItem, PageSlice)?> openBook(Session session, UuidValue authUserId, String query, {int? maxChars}) async {
    final hits = await PageReaderService.findBooks(query);
    final hit = hits.where((h) => h.textUrl != null).firstOrNull;
    if (hit == null) return null;
    final url = hit.textUrl!;
    final mine = await ReadingItem.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId) & t.url.equals(url));
    var slice = await PageReaderService.read(url, offset: mine == null || finished(mine) ? 0 : mine.nextOffset ?? 0);
    if (maxChars != null) slice = trim(slice, maxChars);
    var item = await record(session, authUserId, slice);
    if (item.author == null && hit.authors.isNotEmpty) {
      item = await ReadingItem.db.updateRow(session, item.copyWith(author: hit.authors.join(', ')));
    }
    return _after(session, authUserId, item, slice);
  }
}
