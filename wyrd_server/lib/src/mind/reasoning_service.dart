import 'dart:convert';
import 'dart:math';

import '../generated/protocol.dart';
import 'mind_service.dart';
import 'reasoning_log_service.dart';
import 'topic_service.dart';
import 'wordnet_service.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's reasoning as a neural network of ideas -- no AI calls.
///
/// Ideas are neurons and `synapse` rows are the connections between them. Each tick:
///  1. **Learning (Hebbian):** ideas that appear together in new shared memories wire together --
///     their synapse strengthens toward 1 (w += rate * (1 - w)).
///  2. **Firing:** one idea from recent reading fires; the signal spreads along its strongest
///     synapse, and on once more, activation shrinking by each synapse's strength.
///  3. **Potentiation:** the synapses the signal crossed strengthen a little more (LTP).
///  4. **Decay:** about hourly, synapses unused for a day weaken, and the faintest are pruned.
/// Each firing is written to the reasoning log as structured JSON (kind 'firing') with a
/// plain-English summary, which the app draws as neural tissue.
class ReasoningService {
  static const _learnRate = 0.05;
  static const _maxStepsPerBatch = 2; // one popular article re-read ten times isn't ten lessons
  static const _ltpRate = 0.04;
  static const _topicsPerBlock = 6;
  static const _cursorMark = 'neural-cursor';
  static const _decayEvery = Duration(hours: 1);
  static const _decayFactor = 0.97;
  static const _pruneBelow = 0.03;
  static DateTime? _lastDecay;

  static const _sharedSources = {'net', 'self', 'synthesis', 'feed', 'ingest', 'curriculum'};

  /// Returns true if a firing happened (false if there's nothing to reason about yet).
  static Future<bool> tick(Session session) async {
    await _learnFromNewMemories(session);
    await _decayIfDue(session);
    return _fire(session);
  }

  static List<String> _ideas(MemoryBlock b) => b.topics.where(TopicService.isIdea).take(_topicsPerBlock).toList();

  static (String, String) _pair(String x, String y) => x.compareTo(y) < 0 ? (x, y) : (y, x);

  /// Strengthens each of [pairs] toward 1 once per occurrence -- a pair seen k times gets k
  /// Hebbian steps, w -> 1 - (1 - w)(1 - rate)^k -- creating synapses that don't exist yet.
  static Future<void> _strengthen(Session session, Iterable<(String, String)> pairs, double rate) async {
    final counts = <(String, String), int>{};
    for (final p in pairs) {
      counts[p] = min((counts[p] ?? 0) + 1, _maxStepsPerBatch);
    }
    final list = counts.entries.toList();
    for (var start = 0; start < list.length; start += 300) {
      final chunk = list.sublist(start, min(start + 300, list.length));
      final params = <String, Object?>{'t': DateTime.now().toUtc()};
      final values = <String>[];
      for (var i = 0; i < chunk.length; i++) {
        final k = chunk[i].value;
        params['a$i'] = chunk[i].key.$1;
        params['b$i'] = chunk[i].key.$2;
        params['w$i'] = 1 - pow(1 - rate, k).toDouble(); // k steps from zero
        params['k$i'] = k;
        values.add('(@a$i, @b$i, @w$i, @k$i, @t)');
      }
      await session.db.unsafeExecute(
        'INSERT INTO "synapse" ("a", "b", "weight", "fires", "lastFired") VALUES ${values.join(', ')} '
        'ON CONFLICT ("a", "b") DO UPDATE SET "weight" = 1 - (1 - "synapse"."weight") * (1 - EXCLUDED."weight"), '
        '"fires" = "synapse"."fires" + EXCLUDED."fires", "lastFired" = @t',
        parameters: QueryParameters.named(params),
      );
    }
  }

  /// Hebbian learning over shared memories added since the last tick.
  static Future<void> _learnFromNewMemories(Session session) async {
    final mark = await MaintenanceRun.db.findFirstRow(session, where: (t) => t.name.equals(_cursorMark));
    var cursor = int.tryParse(mark?.note ?? '');
    if (cursor == null) {
      // first run: start from the last ~300 memories rather than all of history
      final start = await MemoryBlock.db.find(session, orderBy: (t) => t.id.desc(), offset: 300, limit: 1);
      cursor = start.isEmpty ? 0 : start.first.id!;
    }
    final from = cursor;
    final fresh = await MemoryBlock.db.find(
      session,
      where: (t) => (t.id > from) & t.source.inSet(_sharedSources),
      orderBy: (t) => t.id,
      limit: 100,
    );
    if (fresh.isEmpty) return;
    final pairs = <(String, String)>[];
    final seenTitles = <String>{};
    for (final b in fresh) {
      if (b.title != null && !seenTitles.add(b.title!)) continue; // the same article again
      if ((b.quality ?? 1) < 0.6) continue; // the ingest filter judged it weak: don't learn from it
      final ideas = _ideas(b).toSet().toList();
      for (var i = 0; i < ideas.length; i++) {
        for (var j = i + 1; j < ideas.length; j++) {
          pairs.add(_pair(ideas[i], ideas[j]));
        }
      }
    }
    await _strengthen(session, pairs, _learnRate);
    await session.db.unsafeExecute(
      'INSERT INTO "maintenance_run" ("name", "ranAt", "note") VALUES (@n, @t, @note) '
      'ON CONFLICT ("name") DO UPDATE SET "note" = @note, "ranAt" = @t',
      parameters: QueryParameters.named({'n': _cursorMark, 't': DateTime.now().toUtc(), 'note': '${fresh.last.id}'}),
    );
  }

  static Future<void> _decayIfDue(Session session) async {
    final now = DateTime.now();
    if (_lastDecay != null && now.difference(_lastDecay!) < _decayEvery) return;
    _lastDecay = now;
    // one-time: links saturated at 1.0 under the old learning rate are scaled back, so strength
    // means something again
    final rescaled = await session.db.unsafeQuery(
      'INSERT INTO "maintenance_run" ("name", "ranAt", "note") VALUES (\'synapse-rescale-1\', @t, \'x0.6\') '
      'ON CONFLICT ("name") DO NOTHING RETURNING "id"',
      parameters: QueryParameters.named({'t': now.toUtc()}),
    );
    if (rescaled.isNotEmpty) await session.db.unsafeExecute('UPDATE "synapse" SET "weight" = "weight" * 0.6');
    await session.db.unsafeExecute(
      'UPDATE "synapse" SET "weight" = "weight" * @f WHERE "lastFired" < @cut',
      parameters: QueryParameters.named({'f': _decayFactor, 'cut': now.toUtc().subtract(const Duration(days: 1))}),
    );
    await session.db.unsafeExecute('DELETE FROM "synapse" WHERE "weight" < @p', parameters: QueryParameters.named({'p': _pruneBelow}));
  }

  static Future<List<Synapse>> _strongestFrom(Session session, String idea, Set<String> skip, int limit) async {
    final rows = await Synapse.db.find(
      session,
      where: (t) => t.a.equals(idea) | t.b.equals(idea),
      orderBy: (t) => t.weight.desc(),
      limit: limit + skip.length,
    );
    return rows.where((s) => !skip.contains(s.a == idea ? s.b : s.a)).take(limit).toList();
  }

  static String _other(Synapse s, String from) => s.a == from ? s.b : s.a;

  static Future<bool> _fire(Session session) async {
    final recent = await MemoryBlock.db.find(
      session,
      where: (t) => t.source.inSet(_sharedSources),
      orderBy: (t) => t.id.desc(),
      limit: 30,
    );
    final candidates = recent.expand(_ideas).toSet().toList();
    if (candidates.isEmpty) return false;
    // prefer an idea that already has connections, so the signal has somewhere to go
    candidates.shuffle(Random());
    var seed = candidates.first;
    var first = <Synapse>[];
    for (final c in candidates.take(8)) {
      first = await _strongestFrom(session, c, const {}, 5);
      if (first.isNotEmpty) {
        seed = c;
        break;
      }
    }

    final path = <String>[seed];
    final crossed = <Synapse>[];
    final activated = <String, double>{seed: 1.0};
    for (final s in first) {
      activated[_other(s, seed)] = s.weight;
    }
    if (first.isNotEmpty) {
      final hop1 = first.first;
      final n1 = _other(hop1, seed);
      path.add(n1);
      crossed.add(hop1);
      final second = await _strongestFrom(session, n1, {seed}, 3);
      for (final s in second) {
        activated.putIfAbsent(_other(s, n1), () => hop1.weight * s.weight);
      }
      if (second.isNotEmpty) {
        path.add(_other(second.first, n1));
        crossed.add(second.first);
      }
    }

    // long-term potentiation along the path the signal took
    await _strengthen(session, crossed.map((s) => (s.a, s.b)), _ltpRate);
    final after = crossed.isEmpty
        ? <Synapse>[]
        : await Synapse.db.find(session, where: (t) => t.id.inSet(crossed.map((s) => s.id!).toSet()));
    final byId = {for (final s in after) s.id: s};
    final degree = await Synapse.db.count(session, where: (t) => t.a.equals(seed) | t.b.equals(seed));
    final meaning = await WordNetService.define(session, seed, context: activated.keys);

    final ranked = activated.entries.toList()..sort((x, y) => y.value.compareTo(x.value));
    await ReasoningLogService.record(
      session,
      kind: 'firing',
      content: jsonEncode({
        'seed': seed,
        'path': path,
        'activated': [for (final e in ranked.take(8)) {'id': e.key, 'a': _r(e.value)}],
        'synapses': [
          for (final s in crossed)
            {'a': s.a, 'b': s.b, 'before': _r(s.weight), 'after': _r(byId[s.id]?.weight ?? s.weight)},
        ],
        'degree': degree,
        if (meaning != null) 'meaning': meaning.definition,
        'summary': _summary(seed, path, crossed, byId, degree),
      }),
    );

    final strength = crossed.isEmpty ? 0.0 : crossed.map((s) => s.weight).reduce((a, b) => a + b) / crossed.length;
    await MindService.recordEvent(
      session,
      eventType: 'reasoning',
      recentTopics: path,
      scoreGap: strength * 10,
    );
    return true;
  }

  static double _r(double v) => (v * 100).round() / 100;

  static String _summary(String seed, List<String> path, List<Synapse> crossed, Map<int?, Synapse> after, int degree) {
    if (path.length == 1) {
      return 'WYRD fired "$seed", a new idea with no connections yet. It will start wiring up as it '
          'turns up alongside other ideas.';
    }
    final hops = [
      for (var i = 0; i < crossed.length; i++) '"${path[i + 1]}" (strength ${_r(crossed[i].weight).toStringAsFixed(2)})',
    ];
    final gain = crossed.map((s) => (after[s.id]?.weight ?? s.weight) - s.weight).fold(0.0, (a, b) => a + b) / crossed.length;
    return 'WYRD fired "$seed". The signal crossed its strongest synapse to ${hops.join(' and then on to ')}. '
        'Because these ideas fired together, the links grew stronger (+${_r(gain).toStringAsFixed(2)}). '
        '"$seed" is wired to $degree other idea${degree == 1 ? '' : 's'}.';
  }

  /// The strongest [limit] synapses and the ideas they join, for the REASONING view.
  static Future<NeuralNetwork> network(Session session, int limit) async {
    final synapses = await Synapse.db.find(session, orderBy: (t) => t.weight.desc(), limit: limit);
    final total = await Synapse.db.count(session);
    final strength = <String, double>{};
    for (final s in synapses) {
      strength[s.a] = (strength[s.a] ?? 0) + s.weight;
      strength[s.b] = (strength[s.b] ?? 0) + s.weight;
    }
    final neurons = strength.entries.toList()..sort((x, y) => y.value.compareTo(x.value));
    return NeuralNetwork(
      neurons: [for (final e in neurons) ConceptNode(id: e.key, count: (e.value * 100).round())],
      synapses: synapses,
      totalSynapses: total,
    );
  }
}
