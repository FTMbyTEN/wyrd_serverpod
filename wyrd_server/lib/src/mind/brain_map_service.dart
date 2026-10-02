import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// WYRD's real brain, shaped for drawing: the strongest part of its synapse network -- the
/// concepts with the most and strongest connections, and the synapses among them -- plus the
/// paths its latest thoughts actually took (from the reasoning log's 'firing' notes). The neurons
/// on those paths are always included, so every firing shown runs along real, drawn synapses.
///
/// It's the same for everyone and changes slowly, so it's built at most every 20 seconds and
/// shared: a room full of people watching the brain costs the database three queries a minute.
class BrainMapService {
  static const maxNeurons = 160;
  static const _synapsePool = 900;
  static const _firings = 12;
  static const _ttl = Duration(seconds: 20);

  static BrainMap? _cached;
  static DateTime _at = DateTime.fromMillisecondsSinceEpoch(0);

  static Future<BrainMap> get(Session session) async {
    final hit = _cached;
    if (hit != null && DateTime.now().difference(_at) < _ttl) return hit;
    final map = await build(session);
    _cached = map;
    _at = DateTime.now();
    return map;
  }

  /// For tests: build afresh next time.
  static void forget() => _cached = null;

  static Future<BrainMap> build(Session session) async {
    // the latest thoughts first, so their neurons are guaranteed a place
    final notes = await ReasoningNote.db.find(
      session,
      where: (t) => t.kind.equals('firing'),
      orderBy: (t) => t.id.desc(),
      limit: _firings,
    );
    final firings = <BrainFiring>[];
    for (final n in notes.reversed) {
      try {
        final path = ((jsonDecode(n.content) as Map<String, dynamic>)['path'] as List).cast<String>();
        if (path.isNotEmpty) firings.add(BrainFiring(path: path, at: n.timestamp));
      } catch (_) {/* an unreadable note is skipped */}
    }

    final pool = await Synapse.db.find(session, orderBy: (t) => t.weight.desc(), limit: _synapsePool);
    // the synapses the firings crossed, even if they aren't among the strongest
    final pathPairs = <String>{
      for (final f in firings)
        for (var i = 0; i + 1 < f.path.length; i++) _pair(f.path[i], f.path[i + 1]),
    };
    final missing = pathPairs.where((k) => !pool.any((s) => _pair(s.a, s.b) == k)).toList();
    if (missing.isNotEmpty) {
      final ends = {for (final k in missing) ...k.split('\u0000')};
      final extra = await Synapse.db.find(session, where: (t) => t.a.inSet(ends) & t.b.inSet(ends));
      pool.addAll(extra.where((s) => pathPairs.contains(_pair(s.a, s.b))));
    }

    // neurons: path concepts first, then the most connected
    final strength = <String, double>{};
    for (final s in pool) {
      strength[s.a] = (strength[s.a] ?? 0) + s.weight;
      strength[s.b] = (strength[s.b] ?? 0) + s.weight;
    }
    final chosen = <String>{for (final f in firings) ...f.path};
    final ranked = strength.keys.toList()..sort((x, y) => strength[y]!.compareTo(strength[x]!));
    for (final id in ranked) {
      if (chosen.length >= maxNeurons) break;
      chosen.add(id);
    }

    final synapses = [
      for (final s in pool)
        if (chosen.contains(s.a) && chosen.contains(s.b)) BrainSynapse(a: s.a, b: s.b, weight: s.weight, fires: s.fires),
    ];
    final degree = <String, int>{};
    for (final s in synapses) {
      degree[s.a] = (degree[s.a] ?? 0) + 1;
      degree[s.b] = (degree[s.b] ?? 0) + 1;
    }
    final neurons = [
      for (final id in chosen) BrainNeuron(id: id, weight: strength[id] ?? 0, degree: degree[id] ?? 0),
    ]..sort((x, y) => y.weight.compareTo(x.weight));
    return BrainMap(neurons: neurons, synapses: synapses, firings: firings);
  }

  static String _pair(String a, String b) => a.compareTo(b) < 0 ? '$a\u0000$b' : '$b\u0000$a';
}
