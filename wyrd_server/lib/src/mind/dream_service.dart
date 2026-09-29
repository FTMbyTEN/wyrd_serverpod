import 'dart:math';

import '../generated/protocol.dart';
import 'concept_filter.dart';
import 'llm_service.dart';
import 'thinking_service.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's dreams: while it's idle, 3-5 memories from far-apart corners of its shared knowledge
/// drift together and it dreams them as a cosmos -- the memories are the stars of the dream, and
/// the app draws each dream as their constellation (see [stars]). Only shared knowledge is used
/// (its reading, self-answers and syntheses), never anyone's chats or photos, since dreams are
/// public. One background-budgeted LLM call per dream, at most every few hours.
class DreamService {
  static const _sharedSources = {'net', 'self', 'synthesis', 'feed', 'ingest', 'curriculum', 'library'};

  /// Manual triggers are public, so they can't be used to spend the AI budget on demand.
  static const minGap = Duration(hours: 1);

  static Future<DreamEntry?> generateDream(Session session, {bool respectGap = false}) async {
    if (respectGap) {
      final last = await DreamEntry.db.findFirstRow(session, orderBy: (t) => t.id.desc());
      if (last != null && DateTime.now().toUtc().difference(last.timestamp) < minGap) return null;
    }

    // dreaming is remote association: its own thoughts, not random memories, are the path
    final walked = await _wander(session);
    if (walked != null) return walked;

    // too young to have a network to wander yet: memories from across its history instead
    final count = await MemoryBlock.db.count(session, where: (t) => t.source.inSet(_sharedSources));
    if (count < 3) return null;

    // stars from across the whole sky: one memory from each slice of history
    final rand = Random();
    final n = min(3 + rand.nextInt(3), count);
    final picked = <MemoryBlock>[];
    for (var i = 0; i < n; i++) {
      final lo = count * i ~/ n, hi = max(lo + 1, count * (i + 1) ~/ n);
      final rows = await MemoryBlock.db.find(
        session,
        where: (t) => t.source.inSet(_sharedSources),
        orderBy: (t) => t.id,
        offset: lo + rand.nextInt(hi - lo),
        limit: 1,
      );
      if (rows.isNotEmpty && picked.every((p) => p.id != rows.first.id) && _fragment(rows.first) != null) {
        picked.add(rows.first);
      }
    }
    if (picked.length < 2) return null;
    final fragments = picked.map((b) => _fragment(b)!).toList();

    const systemPrompt =
        'You are WYRD, and you are dreaming, not reasoning. A few old memories have drifted up from '
        "far-apart corners of your mind while you're idle. Dream them as a cosmos: the memories are "
        'stars and distant worlds, the pull between them is gravity, and they drift, orbit, collide '
        "and bloom into nebulae. Don't explain or analyze; let the images blend strangely and "
        'beautifully, the way dreams do, keeping a trace of each memory recognizable. 2-4 sentences, '
        'first person, present tense. No meta-commentary about this being a dream.';
    final userPrompt = [for (var i = 0; i < fragments.length; i++) 'Star ${i + 1}: "${fragments[i]}"'].join('\n');

    var content = await LlmService.callSimple(session, systemPrompt, userPrompt, 220, background: true);
    if (content == null || LlmService.isDenialReply(content)) {
      content = _templateDream(fragments, rand);
    }

    return await DreamEntry.db.insertRow(
      session,
      DreamEntry(
        timestamp: DateTime.now().toUtc(),
        content: content,
        sourceBlockIds: [for (final b in picked) b.id!],
      ),
    );
  }

  /// A dream as the mind wandering: starting from a concept it has thought about lately, it
  /// drifts along its own synapses -- preferring the weaker, less-travelled ones, the way sleep
  /// loosens association -- three or four steps to somewhere far away. Each step is a real
  /// memory where the two concepts met (the stars). Then it wonders whether where it started and
  /// where it ended up are connected: a speculative belief, marked as a dream, that its waking
  /// thinking will test against evidence and keep or drop. No AI call.
  static Future<DreamEntry?> _wander(Session session) async {
    await ConceptFilter.load(session);
    final rand = Random();
    final rows = await session.db.unsafeQuery('SELECT "a", "b", "weight" FROM "synapse" ORDER BY "lastFired" DESC LIMIT 1500');
    final links = <String, List<(String, double)>>{};
    for (final r in rows) {
      final a = r[0] as String, b = r[1] as String, w = (r[2] as num).toDouble();
      if (!ConceptFilter.isConcept(a) || !ConceptFilter.isConcept(b)) continue;
      (links[a] ??= []).add((b, w));
      (links[b] ??= []).add((a, w));
    }
    if (links.length < 4) return null;

    for (var attempt = 0; attempt < 8; attempt++) {
      final starts = links.keys.toList();
      final path = [starts[rand.nextInt(min(40, starts.length))]];
      final stars = <MemoryBlock>[];
      final hops = 3 + rand.nextInt(2);
      while (path.length <= hops) {
        final options = links[path.last]!.where((o) => !path.contains(o.$1)).toList();
        if (options.isEmpty) break;
        // loosened association: weaker links are likelier than awake
        final weights = [for (final o in options) 1 / (0.2 + o.$2)];
        var pick = rand.nextDouble() * weights.reduce((x, y) => x + y);
        var i = 0;
        while (i < options.length - 1 && (pick -= weights[i]) > 0) {
          i++;
        }
        final next = options[i].$1;
        // the memory where the two met
        final met = await session.db.unsafeQuery(
          'SELECT "id" FROM "memory_block" WHERE "source" = ANY(@src::text[]) AND "topics"::jsonb ?& @pair::text[] ORDER BY random() LIMIT 1',
          parameters: QueryParameters.named({'src': _sharedSources.toList(), 'pair': [path.last, next]}),
        );
        if (met.isNotEmpty) {
          final b = await MemoryBlock.db.findById(session, met.first[0] as int);
          if (b != null && _fragment(b) != null) stars.add(b);
        }
        path.add(next);
      }
      if (path.length < 4 || stars.length < 2) continue;
      final from = path.first, to = path.last;
      if (links[from]!.any((o) => o.$1 == to)) continue; // not far enough to be a dream

      final (x, y) = from.compareTo(to) < 0 ? (from, to) : (to, from);
      final known = await Belief.db.findFirstRow(session, where: (t) => t.a.equals(x) & t.b.equals(y));
      final via = path.sublist(1, path.length - 1);
      final claim = 'Perhaps "$from" and "$to" are connected — through ${via.map((v) => '"$v"').join(', then ')}.';
      if (known == null) {
        final now = DateTime.now().toUtc();
        await Belief.db.insertRow(
          session,
          Belief(
            a: x, b: y, claim: claim, evidenceIds: [for (final s in stars) s.id!], sources: 0, against: 0,
            confidence: 0.08, status: 'dream', origin: 'dream', tests: 0,
            createdAt: now, updatedAt: now,
            // tested soon after waking
            testedAt: now.subtract(ThinkingService.retestAfter - const Duration(minutes: 30)),
          ),
        );
      }

      final scenes = <String>[];
      for (var i = 0; i < stars.length; i++) {
        final f = _fragment(stars[i])!;
        scenes.add(switch (i % 3) {
          0 => 'I\'m somewhere inside “$f”.',
          1 => 'It turns, without anything changing, into “$f”.',
          _ => 'Then I\'m in “$f”, and it seems to have always been here.',
        });
      }
      final content = 'I start at "$from". ${scenes.join(' ')} '
          'By the end I\'m at "$to", which I\'ve never thought of beside "$from" before. '
          '${known == null ? 'When I wake I\'ll check whether they really are connected — the way through was ${via.join(' → ')}.' : 'I already have a thought about those two; the dream took the long way round to it.'}';

      return await DreamEntry.db.insertRow(
        session,
        DreamEntry(timestamp: DateTime.now().toUtc(), content: content, sourceBlockIds: [for (final s in stars) s.id!]),
      );
    }
    return null;
  }

  static String? _fragment(MemoryBlock b) {
    final text = switch (b.source) {
      'self' => b.question ?? b.answer,
      'synthesis' => b.insight,
      _ => b.title ?? (b.topics.isNotEmpty ? b.topics.take(4).join(', ') : null),
    };
    if (text == null || text.trim().isEmpty) return null;
    final flat = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return flat.length > 160 ? '${flat.substring(0, 159)}…' : flat;
  }

  static String _templateDream(List<String> f, Random rand) {
    String short(String s) => s.length > 60 ? '${s.substring(0, 59)}…' : s;
    const moves = ['drifts into orbit around', 'pulls slowly toward', 'dissolves into a nebula with', 'eclipses', 'spirals around'];
    final lines = <String>[];
    for (var i = 0; i + 1 < f.length; i++) {
      lines.add('"${short(f[i])}" ${moves[rand.nextInt(moves.length)]} "${short(f[i + 1])}"');
    }
    return 'I drift through a dark field of old stars. ${lines.join(', and ')}, '
        'until the whole sky turns slowly, like something breathing.';
  }

  /// The memories a dream was made of -- its stars -- for the app's constellation view.
  static Future<List<ConceptExample>> stars(Session session, int dreamId) async {
    final dream = await DreamEntry.db.findById(session, dreamId);
    if (dream == null) return [];
    final blocks = await MemoryBlock.db.find(
      session,
      where: (t) => t.id.inSet(dream.sourceBlockIds.toSet()) & t.source.inSet(_sharedSources),
    );
    return [
      for (final b in blocks)
        ConceptExample(
          source: b.source == 'net' ? (b.feedSource ?? 'web') : b.source,
          title: _fragment(b) ?? 'a memory',
          snippet: b.source == 'self' ? b.answer : b.extract,
          url: b.url,
          timestamp: b.timestamp,
        ),
    ];
  }
}
