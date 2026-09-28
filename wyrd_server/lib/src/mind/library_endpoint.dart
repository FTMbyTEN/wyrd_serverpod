import '../generated/protocol.dart';
import 'library_service.dart';
import 'page_reader_service.dart';
import 'rate_limiter.dart';
import 'works_service.dart';
import 'package:serverpod/serverpod.dart';

/// The Academy and My Library: free books (Project Gutenberg), open textbooks (OpenStax) and
/// Wikisource's library in many languages, with each person's place kept. Nothing here calls an AI.
class LibraryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  UuidValue _me(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  void _pace(Session session, String what, {int limit = 30}) {
    if (RateLimiter.isLimited('library:$what:${_me(session).uuid}', limit, const Duration(minutes: 5))) {
      throw Exception('slow down — try again in a few minutes');
    }
  }

  ReadingSlice _slice((ReadingItem, PageSlice) r) => ReadingSlice(
        item: r.$1,
        text: r.$2.text,
        offset: r.$2.offset,
        finished: LibraryService.finished(r.$1),
      );

  Future<List<ReadingItem>> list(Session session) => LibraryService.list(session, _me(session));

  /// The next part of item [id] (or its start with [restart], or the start of section [part]).
  Future<ReadingSlice> readOn(Session session, int id, {bool restart = false, int? part}) async {
    _pace(session, 'read');
    final me = _me(session);
    final item = await ReadingItem.db.findById(session, id);
    if (item == null || item.authUserId != me) throw Exception('not in your library');
    final r = await LibraryService.readOn(session, me, item, restart: restart, jumpToPart: part);
    if (r == null) {
      return ReadingSlice(item: item, text: '', offset: item.total, finished: true);
    }
    return _slice(r);
  }

  /// The passage shown last for item [id], again, without moving on (Dialogue Link's "open in
  /// the Academy").
  Future<ReadingSlice> current(Session session, int id) async {
    _pace(session, 'read');
    final me = _me(session);
    final item = await ReadingItem.db.findById(session, id);
    if (item == null || item.authUserId != me) throw Exception('not in your library');
    final r = await LibraryService.current(session, me, item);
    return ReadingSlice(item: item, text: r?.$2.text ?? '', offset: r?.$2.offset ?? 0, finished: LibraryService.finished(item));
  }

  /// A work's table of contents (sections of a textbook, chapters on Wikisource).
  Future<List<WorkPartInfo>> contents(Session session, int id) async {
    final item = await ReadingItem.db.findById(session, id);
    if (item == null || item.authUserId != _me(session)) throw Exception('not in your library');
    return LibraryService.contents(item);
  }

  /// Opens a free public-domain book by title/author (Project Gutenberg), picking up where you
  /// stopped if you've started it. Null when no free copy exists.
  Future<ReadingSlice?> openBook(Session session, String query) async {
    final q = query.trim();
    if (q.isEmpty || q.length > 120) throw Exception('name a book (and author, if you like)');
    _pace(session, 'open', limit: 20);
    final r = await LibraryService.openBook(session, _me(session), q);
    return r == null ? null : _slice(r);
  }

  /// Opens a work found through [textbooks], [searchWikisource] or [searchBooks].
  Future<ReadingSlice?> openWork(Session session, String source, String id) async {
    if (!const {'openstax', 'wikisource', 'gutenberg'}.contains(source) || id.isEmpty || id.length > 300) {
      throw Exception('unknown work');
    }
    _pace(session, 'open', limit: 20);
    final r = await LibraryService.openWork(session, _me(session), source, id);
    return r == null ? null : _slice(r);
  }

  /// Every OpenStax open textbook (free, CC BY 4.0), with subjects and covers.
  Future<List<WorkHit>> textbooks(Session session) => WorksService.textbooks();

  /// Wikisource works in [lang] matching [query].
  Future<List<WorkHit>> searchWikisource(Session session, String lang, String query) async {
    final q = query.trim();
    if (q.isEmpty || q.length > 120) return [];
    _pace(session, 'search');
    return WorksService.searchWikisource(lang, q);
  }

  /// The Wikisource languages on offer, as "code|name in its own script".
  Future<List<String>> wikisourceLanguages(Session session) async =>
      [for (final (code, name) in WorksService.wikisourceLanguages) '$code|$name'];

  /// Free books on Project Gutenberg matching [query].
  Future<List<WorkHit>> searchBooks(Session session, String query) async {
    final q = query.trim();
    if (q.isEmpty || q.length > 120) return [];
    _pace(session, 'search');
    final hits = await PageReaderService.findBooks(q);
    return [
      for (final h in hits.where((h) => h.textUrl != null))
        WorkHit(source: 'gutenberg', id: h.textUrl!, title: h.title, author: h.authors.isEmpty ? null : h.authors.join(', '), subjects: const []),
    ];
  }

  Future<void> remove(Session session, int id) async {
    final item = await ReadingItem.db.findById(session, id);
    if (item == null || item.authUserId != _me(session)) return;
    await ReadingItem.db.deleteRow(session, item);
  }
}
