import '../generated/protocol.dart';
import 'page_reader_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// The Academy as WYRD's knowledge base: every passage read from a free library (Gutenberg,
/// OpenStax, Wikisource) is kept as shared memory, in paragraph-sized pieces with their topics,
/// so WYRD can recall it later for anyone -- by topic, and by meaning once the nightly embedding
/// pass reaches it. The texts are public; who read them isn't recorded (no owner), so nothing
/// about the reader leaks. Re-reading a passage never stores it twice.
class LibraryKnowledge {
  static const _chunkChars = 900;
  static const sources = {'gutenberg', 'openstax', 'wikisource'};

  static String _clean(String t) => t.replaceAll(RegExp(r'\s*\|.*$'), '').trim();

  /// Paragraph-sized pieces of [text], each under about [_chunkChars].
  static List<String> chunks(String text) {
    final paras = text.split(RegExp(r'\n\s*\n|\n')).map((p) => p.trim()).where((p) => p.length > 1);
    final out = <String>[];
    var buf = StringBuffer();
    for (final p in paras) {
      if (buf.length > 0 && buf.length + p.length > _chunkChars) {
        out.add(buf.toString());
        buf = StringBuffer();
      }
      if (buf.length > 0) buf.write('\n');
      buf.write(p.length > _chunkChars * 2 ? p.substring(0, _chunkChars * 2) : p);
    }
    if (buf.length > 0) out.add(buf.toString());
    // pieces too short to mean anything on their own (headings, page numbers) aren't worth keeping
    return out.where((c) => c.length >= 120).toList();
  }

  /// Keeps [slice] of [item] as knowledge. Returns how many new pieces were stored.
  static Future<int> absorb(Session session, ReadingItem item, PageSlice slice) async {
    final source = item.source;
    if (source == null || !sources.contains(source) || slice.text.trim().isEmpty) return 0;
    final key = 'lib:${slice.url}#${slice.offset}';
    final seen = await MemoryBlock.db.findFirstRow(session, where: (t) => t.legacyId.equals('$key/0'));
    if (seen != null) return 0;
    final title = item.partTitle != null && item.partTitle != item.title
        ? '${_clean(item.title)} — ${item.partTitle}'
        : _clean(item.title);
    final now = DateTime.now().toUtc();
    final pieces = chunks(slice.text);
    final rows = <MemoryBlock>[];
    for (var i = 0; i < pieces.length; i++) {
      final topics = TopicService.extractTopics(pieces[i]).where(TopicService.isIdea).take(12).toList();
      if (topics.isEmpty) continue;
      rows.add(MemoryBlock(
        legacyId: '$key/$i',
        timestamp: now,
        source: 'library',
        feedSource: source,
        title: title,
        extract: pieces[i],
        url: slice.url,
        topics: topics,
        quality: 0.9, // edited, published texts
        category: source == 'openstax' ? 'textbook' : 'literature',
      ));
    }
    if (rows.isEmpty) return 0;
    await MemoryBlock.db.insert(session, rows);
    return rows.length;
  }

  /// Plain-text sentences of [text].
  static List<String> sentences(String text) => text
      .replaceAll(RegExp(r'\s+'), ' ')
      // after . ! ? (and a closing quote or bracket), but not after "Mr." / "Mrs." / "Dr." / "St."
      .split(RegExp(r'(?<![A-Z][a-z]\.)(?<![A-Z][a-z][a-z]\.)(?<!\b[A-Z]\.)(?<=[.!?。！？]["”’)\]]?)\s+'))
      .map((s) => s.trim())
      .where((s) => s.length > 20)
      .toList();

  static final _stop = RegExp(r'^(the|and|that|this|with|from|have|what|which|when|where|there|their|about|would|could|should|into|them|they|were|been|does|mean|explain|passage|chapter|book|tell|please)$');

  static Set<String> _words(String s) => RegExp(r"[\p{L}\p{N}']{3,}", unicode: true)
      .allMatches(s.toLowerCase())
      .map((m) => m.group(0)!)
      .where((w) => !_stop.hasMatch(w))
      .toSet();

  /// The sentences of [text] that best answer [question] (most words in common), in their
  /// original order. Empty when nothing matches.
  static List<String> relevant(String text, String question, {int max = 3}) {
    final q = _words(question);
    if (q.isEmpty) return [];
    final all = sentences(text);
    final scored = <(int, double)>[];
    for (var i = 0; i < all.length; i++) {
      final w = _words(all[i]);
      final hits = q.where(w.contains).length;
      if (hits > 0) scored.add((i, hits + hits / (w.length + 4)));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    final pick = scored.take(max).map((e) => e.$1).toList()..sort();
    return [for (final i in pick) all[i]];
  }

  /// A short extractive summary of [text]: the sentences that carry its most frequent ideas.
  static List<String> summary(String text, {int max = 3}) {
    final all = sentences(text);
    if (all.length <= max) return all;
    final freq = <String, int>{};
    for (final s in all) {
      for (final w in _words(s)) {
        freq[w] = (freq[w] ?? 0) + 1;
      }
    }
    final scored = <(int, double)>[];
    for (var i = 0; i < all.length; i++) {
      final w = _words(all[i]);
      if (w.isEmpty) continue;
      final score = w.fold<int>(0, (n, x) => n + (freq[x] ?? 0)) / (w.length + 3) + (i == 0 ? 0.5 : 0);
      scored.add((i, score));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    final pick = scored.take(max).map((e) => e.$1).toList()..sort();
    return [for (final i in pick) all[i]];
  }
}
