import 'dart:convert';
import 'dart:math';

import '../generated/protocol.dart';
import 'llm_service.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's /api/gate-vortex/shape: WYRD invents a new parametric shape for its gate
/// screen's particle vortex, loosely colored by its current mood, avoiding anything it produced
/// recently. Recent labels/types are kept in memory per server process, as in Node -- the point
/// is avoiding back-to-back repeats, not lifetime uniqueness.
class GateShapeService {
  static const types = [
    'lissajous',
    'rose',
    'braid',
    'latticeWave',
    'burstShell',
    'explosionBurst',
    'circuitGrid',
  ];

  // WYRD's existing imaginative range (the shapes built into the gate's own rotation).
  static const _curatedShapes = [
    'sphere',
    'mandala burst',
    "WYRD's own face (clean and dreaming)",
    'infinity curve',
    'heavy-metal chain',
    'torus knot',
    'cube lattice',
    'spiral galaxy',
    'wave grid',
    'spiky starburst',
    'Bohr-model atom',
    'p-orbital electron cloud',
    'Saturn with rings',
    "black hole's accretion disk",
    'city skyline',
    'pyramid',
    'Möbius strip',
    'tesseract (4D hypercube)',
    'neural network diagram',
    'fractal branching tree',
    'atomic explosion',
    'fire',
    'water droplet',
    'wind streamlines',
    'CPU circuit board',
    'Kilimanjaro',
    'Everest',
    'Fuji',
  ];

  static final _recentLabels = <String>[];
  static const _maxRecentLabels = 14;
  // Labels alone weren't enough in Node: fresh names kept landing on the same family. Tracking
  // types too, and rejecting a repeat of the immediately preceding one, forces real variety.
  static final _recentTypes = <String>[];
  static const _maxRecentTypes = 5;
  static var _callCount = 0;

  // The gate is public and polled every few seconds per visitor, so only occasionally ask the LLM
  // for a fresh shape; the deterministic fallback covers every call in between. See LlmBudget.
  static const _llmMinGap = Duration(hours: 2);
  static DateTime? _lastLlmAt;

  static Future<GateShape> next(Session session) async {
    _callCount++;
    final mind = await MindService.load(session);

    GateShape? shape;
    final now = DateTime.now();
    if (LlmService.isConfigured(session) && (_lastLlmAt == null || now.difference(_lastLlmAt!) >= _llmMinGap)) {
      _lastLlmAt = now;
      final raw = await LlmService.callSimple(
        session,
        _prompt(mind),
        'Generate the shape now.',
        200,
      );
      shape = raw == null ? null : _parse(raw);
    }
    shape ??= _fallback(mind);

    _remember(
      _recentLabels,
      shape.label.trim().toLowerCase(),
      _maxRecentLabels,
    );
    _remember(_recentTypes, shape.type, _maxRecentTypes);
    return shape;
  }

  static void _remember(List<String> list, String value, int max) {
    if (value.isEmpty) return;
    list.add(value);
    if (list.length > max) list.removeAt(0);
  }

  /// Null when malformed, out of range, or a repeat -- the caller falls back.
  static GateShape? _parse(String raw) {
    try {
      final cleaned = raw
          .trim()
          .replaceFirst(RegExp(r'^```(?:json)?', caseSensitive: false), '')
          .replaceFirst(RegExp(r'```$'), '')
          .trim();
      final p = jsonDecode(cleaned) as Map<String, dynamic>;
      double? inRange(String k, double lo, double hi) {
        final v = p[k];
        return v is num && v.isFinite && v >= lo && v <= hi
            ? v.toDouble()
            : null;
      }

      int? freq(String k) {
        final v = p[k];
        return v is int && v >= 1 && v <= 12 ? v : null;
      }

      final type = p['type'];
      final label = p['label'];
      final a = inRange('a', 0.1, 4), b = inRange('b', 0.1, 4);
      final fx = freq('freqX'), fy = freq('freqY'), fz = freq('freqZ');
      final turns = inRange('turns', 0.5, 8),
          radius = inRange('radiusScale', 0.3, 3);
      final height = inRange('heightScale', 0.3, 4),
          twist = inRange('twist', 0, 3);
      if (type is! String || !types.contains(type)) return null;
      if (label is! String || label.isEmpty || label.length > 40) return null;
      if ([a, b, fx, fy, fz, turns, radius, height, twist].contains(null)) {
        return null;
      }
      if (_recentLabels.contains(label.trim().toLowerCase())) return null;
      if (_recentTypes.isNotEmpty && type == _recentTypes.last) return null;

      return GateShape(
        type: type,
        a: a!,
        b: b!,
        freqX: fx!,
        freqY: fy!,
        freqZ: fz!,
        turns: turns!,
        radiusScale: radius!,
        heightScale: height!,
        twist: twist!,
        label: label,
      );
    } catch (_) {
      return null;
    }
  }

  /// Deterministic from WYRD's current stats plus a call counter (stats barely move between two
  /// requests, so without the counter this repeated itself), cycling through every family.
  static GateShape _fallback(Mind mind) {
    final moodSeed = mind.mood.codeUnits.fold<int>(0, (s, c) => s + c);
    final seed =
        moodSeed +
        (mind.curiosity * 97).round() +
        (mind.confidence * 131).round() +
        _callCount * 37 +
        1;
    double rand(int n) {
      final x = sin(seed * n) * 10000;
      return x - x.floorToDouble();
    }

    var type = types[_callCount % types.length];
    if (_recentTypes.isNotEmpty && type == _recentTypes.last) {
      type = types[(_callCount + 1) % types.length];
    }
    return GateShape(
      type: type,
      a: 0.5 + rand(1) * 2,
      b: 0.5 + rand(2) * 2,
      freqX: 1 + (rand(3) * 8).floor(),
      freqY: 1 + (rand(4) * 8).floor(),
      freqZ: 1 + (rand(5) * 8).floor(),
      turns: 1 + rand(6) * 5,
      radiusScale: 0.8 + rand(7) * 1.6,
      heightScale: 0.6 + rand(8) * 2.2,
      twist: rand(9) * 2,
      label: '${mind.mood} pattern $_callCount',
    );
  }

  static String _prompt(Mind mind) {
    final lastType = _recentTypes.isNotEmpty
        ? _recentTypes.last
        : 'the same one';
    return 'You are WYRD, generating a brand-new abstract 3D shape formula for your own login gate\'s '
        'particle visual. Loosely let your current state color the character of the shape: mood '
        '"${mind.mood}", curiosity ${(mind.curiosity * 100).round()}%, confidence '
        '${(mind.confidence * 100).round()}%.\n\n'
        "Shapes already permanently built into your rotation — treat this as your existing imaginative "
        "range, don't just redescribe one of these: ${_curatedShapes.join(', ')}.\n\n"
        'Shapes you personally generated most recently, oldest first — do NOT repeat any of these or '
        'produce something extremely close to one: '
        '${_recentLabels.isEmpty ? '(none yet — this is your first one)' : _recentLabels.join(', ')}.\n\n'
        "The underlying geometric families you've used most recently, oldest first: "
        '${_recentTypes.isEmpty ? '(none yet)' : _recentTypes.join(', ')}. A different label on the same '
        'family still counts as repeating yourself — do NOT pick $lastType again right now, pick a '
        'different family below.\n\n'
        'Reach for something genuinely different from all of the above — think across math, nature, the '
        'classical elements, technology, emotion, everyday objects, anything. Treat "lissajous" (the one '
        'spiral-family option below) as a last resort, not a default. First pick which underlying '
        'geometric FAMILY actually matches what you\'re imagining:\n'
        '- "rose": flower/gear-like petals — radius oscillates with angle instead of spiraling outward\n'
        '- "braid": 2-5 separate strands winding around each other like rope, not one line\n'
        '- "latticeWave": a flat rippling grid/mesh, like fabric or water — not a line at all\n'
        '- "burstShell": a spiky sphere/shell, like a sea urchin or virus model\n'
        '- "explosionBurst": a dense core with jagged debris flung outward at uneven distances\n'
        '- "circuitGrid": a blocky, right-angle circuit-board lattice — deliberately geometric\n'
        '- "lissajous" (avoid unless nothing else fits): a single wound/spiraling line\n\n'
        'Then encode your idea as parametric knobs within that family. Respond with ONLY strict JSON, no '
        'markdown fences, no commentary: {"type": "rose"|"braid"|"latticeWave"|"burstShell"|'
        '"explosionBurst"|"circuitGrid"|"lissajous", "a": number 0.2-3, "b": number 0.2-3, "freqX": '
        'integer 1-9, "freqY": integer 1-9, "freqZ": integer 1-9, "turns": number 1-6, "radiusScale": '
        'number 0.5-2.5, "heightScale": number 0.5-3, "twist": number 0-2, "label": "a short 1-3 word '
        'name for this specific shape"}.';
  }
}
