import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class _BrainPoint {
  final double x, y, z, s, ph;
  final String region;
  _BrainPoint(this.x, this.y, this.z, this.s, this.ph, this.region);
}

class _Edge {
  final int a, b;
  final double speed, phase;
  _Edge(this.a, this.b, this.speed, this.phase);
}

class _Burst {
  final int startMs;
  final int nodeIdx;
  _Burst(this.startMs, this.nodeIdx);
}

const double _gap = 0.16; // longitudinal fissure -- the visible split down the middle of a real brain

/// Deformed twin-hemisphere point cloud with a fake sulci/gyri wrinkle pattern and a small
/// cerebellum cluster tucked in at the back-bottom. Ports BrainCanvas.tsx's buildBrain.
List<_BrainPoint> _buildBrain(int nodeCount) {
  final cerebellumCount = max(6, (nodeCount * 0.12).round());
  final hemiCount = max(4, ((nodeCount - cerebellumCount) / 2).round());
  final rand = Random();
  final pts = <_BrainPoint>[];

  double wrinkle(double theta, double phi) =>
      1 + 0.07 * sin(theta * 5 + phi * 2) + 0.045 * sin(phi * 7 - theta * 3) + 0.03 * sin(theta * 11 + phi * 9);

  for (final region in ['left', 'right']) {
    final sign = region == 'left' ? 1.0 : -1.0;
    for (var i = 0; i < hemiCount; i++) {
      final y0 = 1 - (i / (hemiCount - 1)) * 2;
      final rad = sqrt(max(0.0, 1 - y0 * y0));
      final theta = i * pi * (3 - sqrt(5));
      var x = cos(theta) * rad;
      var z = sin(theta) * rad;
      final phi = atan2(z, x);
      final w = wrinkle(theta, phi);

      var y = y0;
      if (y < -0.15) y = -0.15 + (y + 0.15) * 0.45;
      x *= 0.72 * w;
      z *= 1.05 * w;
      y *= 0.62 * w;

      x = sign * (x.abs() + _gap);

      pts.add(_BrainPoint(x, y, z, 0.6 + rand.nextDouble() * 0.8, rand.nextDouble() * 6.28, region));
    }
  }

  for (var i = 0; i < cerebellumCount; i++) {
    final y0 = 1 - (i / max(1, cerebellumCount - 1)) * 2;
    final rad = sqrt(max(0.0, 1 - y0 * y0));
    final theta = i * pi * (3 - sqrt(5)) * 1.3;
    final x = cos(theta) * rad * 0.34;
    final z = sin(theta) * rad * 0.24 - 0.62;
    final y = y0 * 0.22 - 0.42;
    pts.add(_BrainPoint(x, y, z, 0.45 + rand.nextDouble() * 0.5, rand.nextDouble() * 6.28, 'cerebellum'));
  }

  return pts;
}

/// Nearest-2-neighbour mesh instead of arbitrary index pairing. Ports BrainCanvas.tsx's
/// buildEdges. O(n^2), fine at the node counts this runs at (capped well under 400).
List<_Edge> _buildEdges(List<_BrainPoint> points) {
  final seen = <String>{};
  final edges = <_Edge>[];
  const k = 2;
  final rand = Random();

  for (var i = 0; i < points.length; i++) {
    final dists = <(int, double)>[];
    for (var j = 0; j < points.length; j++) {
      if (i == j) continue;
      final dx = points[i].x - points[j].x, dy = points[i].y - points[j].y, dz = points[i].z - points[j].z;
      dists.add((j, dx * dx + dy * dy + dz * dz));
    }
    dists.sort((a, b) => a.$2.compareTo(b.$2));
    for (var n = 0; n < k && n < dists.length; n++) {
      final j = dists[n].$1;
      final key = i < j ? '$i-$j' : '$j-$i';
      if (seen.contains(key)) continue;
      seen.add(key);
      edges.add(_Edge(i, j, 0.35 + rand.nextDouble() * 0.5, rand.nextDouble()));
    }
  }
  return edges;
}

/// The node-brain visualization behind the WYRD home tab. Shaped like an actual (stylized)
/// brain -- two hemispheres split by a fissure, a cerebellum lobe, a wrinkled surface -- with
/// signal packets ("electrons") travelling the connections continuously, and real ingestion/
/// reasoning events (bump [activitySignal]) triggering a bright expanding pulse at a random
/// node. Ports BrainCanvas.tsx.
class BrainCanvas extends StatefulWidget {
  final int nodeCount;
  final int activitySignal;

  const BrainCanvas({super.key, this.nodeCount = 150, this.activitySignal = 0});

  @override
  State<BrainCanvas> createState() => _BrainCanvasState();
}

class _BrainCanvasState extends State<BrainCanvas> with SingleTickerProviderStateMixin {
  late final List<_BrainPoint> _points;
  late final List<_Edge> _edges;
  final List<_Burst> _bursts = [];
  late final Ticker _ticker;
  int _nowMs = 0;
  final _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _points = _buildBrain(widget.nodeCount);
    _edges = _buildEdges(_points);
    _stopwatch.start();
    _ticker = createTicker((_) {
      setState(() => _nowMs = _stopwatch.elapsedMilliseconds);
    })
      ..start();
  }

  @override
  void didUpdateWidget(BrainCanvas old) {
    super.didUpdateWidget(old);
    if (widget.activitySignal != old.activitySignal) {
      _bursts.add(_Burst(_nowMs, Random().nextInt(_points.length)));
      if (_bursts.length > 12) _bursts.removeAt(0);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bursts.removeWhere((b) => _nowMs - b.startMs > 900);
    return CustomPaint(
      painter: _BrainPainter(points: _points, edges: _edges, bursts: List.of(_bursts), nowMs: _nowMs),
      size: Size.infinite,
    );
  }
}

class _ProjectedPoint {
  final double sx, sy, d, ph, s;
  _ProjectedPoint(this.sx, this.sy, this.d, this.ph, this.s);
}

class _BrainPainter extends CustomPainter {
  final List<_BrainPoint> points;
  final List<_Edge> edges;
  final List<_Burst> bursts;
  final int nowMs;

  _BrainPainter({required this.points, required this.edges, required this.bursts, required this.nowMs});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    if (w <= 0 || h <= 0) return;

    final t = nowMs * 0.00022;
    final r = min(w, h) * 0.42;
    final ca = cos(t), sa = sin(t);

    final proj = points.map((p) {
      final x = p.x * ca - p.z * sa, z = p.x * sa + p.z * ca;
      final sc = 1 / (2.6 - z * 0.6);
      return _ProjectedPoint(w / 2 + x * r * sc * 1.7, h / 2 - p.y * r * sc * 1.9, sc, p.ph, p.s);
    }).toList();

    // Base mesh: dim connective tissue between neighbouring nodes.
    final linePaint = Paint()..strokeWidth = 0.8;
    for (final e in edges) {
      final a = proj[e.a], b = proj[e.b];
      final depth = (a.d + b.d) / 2;
      linePaint.color = const Color(0xFF0A9C2F).withValues(alpha: (0.22 + depth * 0.4).clamp(0, 1));
      canvas.drawLine(Offset(a.sx, a.sy), Offset(b.sx, b.sy), linePaint);
    }

    // Firing signal: a bright packet travelling each edge on a continuous loop.
    final pulsePaint = Paint();
    for (final e in edges) {
      final a = proj[e.a], b = proj[e.b];
      final tt = (nowMs * 0.00035 * e.speed + e.phase) % 1;
      final px = a.sx + (b.sx - a.sx) * tt, py = a.sy + (b.sy - a.sy) * tt;
      final depth = (a.d + b.d) / 2;
      pulsePaint.color = const Color(0xFFBAFFC9).withValues(alpha: (0.55 + depth * 0.45).clamp(0, 1));
      canvas.drawCircle(Offset(px, py), 1.3 + depth * 1.1, pulsePaint);
    }

    // Nodes themselves, gently pulsing -- the "neurons".
    final dotPaint = Paint();
    for (final p in proj) {
      final pulse = 0.55 + 0.45 * sin(nowMs * 0.002 + p.ph);
      dotPaint.color = const Color(0xFF00FF41).withValues(alpha: (0.25 + p.d * 0.9 * pulse).clamp(0, 1));
      canvas.drawCircle(Offset(p.sx, p.sy), p.s * p.d * 1.5, dotPaint);
    }

    // Digestion bursts: an expanding, fading ring at a random node.
    final burstPaint = Paint()..style = PaintingStyle.stroke;
    for (final b in bursts) {
      final age = (nowMs - b.startMs) / 900;
      if (age < 0 || age > 1 || b.nodeIdx >= proj.length) continue;
      final p = proj[b.nodeIdx];
      burstPaint.strokeWidth = 1.4 * (1 - age);
      burstPaint.color = const Color(0xFFBAFFC9).withValues(alpha: (0.8 * (1 - age)).clamp(0, 1));
      canvas.drawCircle(Offset(p.sx, p.sy), 3 + age * 22 * p.d, burstPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BrainPainter oldDelegate) => true;
}
