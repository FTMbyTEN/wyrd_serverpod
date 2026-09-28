import '../generated/protocol.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// What the filter decided about one incoming item.
class IngestVerdict {
  IngestVerdict({required this.keep, required this.duplicate, required this.score, required this.reasons, required this.category});
  final bool keep;
  final bool duplicate;
  final double score;
  final List<String> reasons;
  final String category;
}

/// Filter + sort: the first stage of WYRD's pipeline. Every item from the outside (feeds) is
/// checked before it can become memory:
///  - **filter** -- duplicates are skipped; the rest get a 0..1 quality score, and anything under
///    [_keepAt] (spam, boilerplate, garbled text, no real ideas) is quarantined with its
///    reasons instead of being stored as knowledge;
///  - **sort** -- what's kept gets a topic category, and its score travels with it so later
///    learning can weigh it (low-quality items don't wire neural connections).
/// People's own chats and camera looks never pass through here: they're theirs, not "data".
class IngestFilter {
  static const _keepAt = 0.5;
  static const _keepQuarantined = 500;

  static final _spam = RegExp(
    r'\b(subscribe (now|today)|sign up (now|today)|click here|buy now|limited offer|free trial|sponsored|advertisement|promo code|discount code|casino|betting odds|crypto giveaway|earn \$\d+|work from home and earn)\b',
    caseSensitive: false,
  );
  static final _boilerplate = RegExp(
    r'\b(accept (all )?cookies|cookie (policy|settings)|enable javascript|page not found|404 not found|access denied|log in to continue|verify you are human|captcha)\b',
    caseSensitive: false,
  );
  static final _clickbait = RegExp(
    r"\b(you won'?t believe|shocking|jaw[- ]dropping|this one (weird )?trick|will blow your mind|number \d+ will|what happened next|doctors hate)\b",
    caseSensitive: false,
  );

  static const _categories = <String, Set<String>>{
    'tech': {'software', 'code', 'coding', 'programming', 'developer', 'developers', 'rust', 'python', 'javascript', 'typescript', 'linux', 'windows', 'apple', 'google', 'microsoft', 'llm', 'llms', 'model', 'models', 'agent', 'agents', 'gpu', 'chip', 'chips', 'cpu', 'compiler', 'database', 'server', 'cloud', 'security', 'vulnerability', 'browser', 'api', 'open-source', 'github', 'app', 'apps', 'web', 'network', 'kernel', 'robot', 'robots', 'token', 'tokens', 'inference', 'openai', 'anthropic', 'claude'},
    'science': {'physics', 'biology', 'chemistry', 'quantum', 'space', 'nasa', 'planet', 'planets', 'star', 'stars', 'galaxy', 'climate', 'research', 'researchers', 'study', 'scientists', 'math', 'mathematics', 'theorem', 'brain', 'cells', 'dna', 'genes', 'evolution', 'species', 'medicine', 'medical', 'disease', 'vaccine', 'energy', 'fusion', 'ocean'},
    'business': {'startup', 'startups', 'company', 'companies', 'market', 'markets', 'funding', 'investors', 'revenue', 'profit', 'economy', 'economic', 'price', 'prices', 'stock', 'bank', 'banks', 'layoffs', 'acquisition', 'ceo', 'billion', 'million'},
    'world': {'government', 'election', 'elections', 'war', 'law', 'laws', 'court', 'policy', 'president', 'minister', 'country', 'countries', 'city', 'cities', 'military', 'police', 'rights', 'europe', 'china', 'russia', 'africa', 'nigeria', 'america'},
    'culture': {'art', 'music', 'film', 'films', 'movie', 'book', 'books', 'novel', 'history', 'game', 'games', 'design', 'writing', 'language', 'languages', 'culture', 'museum', 'photography', 'philosophy'},
  };

  static String _normTitle(String t) => t.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

  /// The category whose words overlap the item's topics most ('general' when none do).
  static String categoryOf(List<String> topics) {
    final t = topics.map((x) => x.toLowerCase()).toSet();
    var best = 'general', bestHits = 0;
    _categories.forEach((name, words) {
      final hits = t.intersection(words).length;
      if (hits > bestHits) {
        best = name;
        bestHits = hits;
      }
    });
    return best;
  }

  /// Scores an item's quality from its text alone (no duplicate check). 1.0 = clean.
  static ({double score, List<String> reasons}) quality(String title, String extract, List<String> topics) {
    var score = 1.0;
    final reasons = <String>[];
    final all = '$title $extract';
    void hit(double cost, String why) {
      score -= cost;
      reasons.add(why);
    }

    if (_spam.hasMatch(all)) hit(0.6, 'spam or advertising');
    if (_boilerplate.hasMatch(all)) hit(0.6, 'boilerplate, not content');
    if (_clickbait.hasMatch(title)) hit(0.3, 'clickbait title');
    final letters = RegExp(r'[A-Za-z]').allMatches(title).length;
    final upper = RegExp(r'[A-Z]').allMatches(title).length;
    if (letters >= 12 && upper / letters > 0.6) hit(0.3, 'shouting (all caps)');
    final visible = all.replaceAll(RegExp(r'\s'), '');
    if (visible.isNotEmpty && RegExp(r'[A-Za-z]').allMatches(visible).length / visible.length < 0.5) {
      hit(0.5, 'garbled or not text');
    }
    final ideas = topics.where(TopicService.isIdea).toSet();
    if (ideas.length < 2) hit(0.5, 'no real ideas in it');
    if (extract.trim().length < 40) hit(0.2, 'title only, no content');
    return (score: score.clamp(0.0, 1.0).toDouble(), reasons: reasons);
  }

  /// Is this item already in memory? Same link, or the same title from the same kind of source.
  static Future<bool> isDuplicate(Session session, {required String title, String? url}) async {
    final rows = await session.db.unsafeQuery(
      'SELECT 1 FROM "memory_block" WHERE "source" = \'net\' AND ((@url::text IS NOT NULL AND "url" = @url) '
      'OR lower("title") = @title) LIMIT 1',
      parameters: QueryParameters.named({'url': url, 'title': title.toLowerCase()}),
    );
    if (rows.isNotEmpty) return true;
    // near-identical titles (punctuation, case) among recent items
    final norm = _normTitle(title);
    final recent = await session.db.unsafeQuery(
      'SELECT "title" FROM "memory_block" WHERE "source" = \'net\' AND "title" IS NOT NULL ORDER BY "id" DESC LIMIT 400',
    );
    return recent.any((r) => _normTitle(r[0] as String) == norm);
  }

  /// Judges one incoming item and records the decision (daily counts; quarantine for rejects).
  static Future<IngestVerdict> judge(
    Session session, {
    required String source,
    required String title,
    required String extract,
    String? url,
    required List<String> topics,
  }) async {
    final category = categoryOf(topics);
    if (await isDuplicate(session, title: title, url: url)) {
      await _count(session, duplicate: true);
      return IngestVerdict(keep: false, duplicate: true, score: 0, reasons: ['already in memory'], category: category);
    }
    final q = quality(title, extract, topics);
    final keep = q.score >= _keepAt;
    if (keep) {
      await _count(session, kept: true, category: category);
    } else {
      await QuarantinedItem.db.insertRow(
        session,
        QuarantinedItem(
          timestamp: DateTime.now().toUtc(),
          source: source,
          title: title,
          url: url,
          extract: extract.length > 400 ? '${extract.substring(0, 399)}…' : extract,
          score: q.score,
          reasons: q.reasons,
        ),
      );
      await session.db.unsafeExecute(
        'DELETE FROM "quarantined_item" WHERE "id" < (SELECT "id" FROM "quarantined_item" ORDER BY "id" DESC OFFSET @keep LIMIT 1)',
        parameters: QueryParameters.named({'keep': _keepQuarantined}),
      );
      await _count(session, reasons: q.reasons);
    }
    return IngestVerdict(keep: keep, duplicate: false, score: q.score, reasons: q.reasons, category: category);
  }

  static String _today() => DateTime.now().toUtc().toIso8601String().substring(0, 10);

  static Future<void> _count(Session session, {bool kept = false, bool duplicate = false, String? category, List<String> reasons = const []}) async {
    final day = _today();
    final row = await IngestDay.db.findFirstRow(session, where: (t) => t.day.equals(day)) ??
        await IngestDay.db.insertRow(session, IngestDay(day: day, kept: 0, duplicates: 0, quarantined: 0, reasons: {}, categories: {}));
    final r = Map<String, int>.from(row.reasons);
    for (final why in reasons) {
      r[why] = (r[why] ?? 0) + 1;
    }
    final c = Map<String, int>.from(row.categories);
    if (category != null) c[category] = (c[category] ?? 0) + 1;
    await IngestDay.db.updateRow(
      session,
      row.copyWith(
        kept: row.kept + (kept ? 1 : 0),
        duplicates: row.duplicates + (duplicate ? 1 : 0),
        quarantined: row.quarantined + (!kept && !duplicate ? 1 : 0),
        reasons: r,
        categories: c,
      ),
    );
  }

  static Future<FilterReport> report(Session session) async {
    final day = _today();
    final row = await IngestDay.db.findFirstRow(session, where: (t) => t.day.equals(day));
    final recent = await QuarantinedItem.db.find(session, orderBy: (t) => t.id.desc(), limit: 8);
    return FilterReport(
      day: day,
      kept: row?.kept ?? 0,
      duplicates: row?.duplicates ?? 0,
      quarantined: row?.quarantined ?? 0,
      reasons: row?.reasons ?? {},
      categories: row?.categories ?? {},
      recent: recent,
    );
  }
}
