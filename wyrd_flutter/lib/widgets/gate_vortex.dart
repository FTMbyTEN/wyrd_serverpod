import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' show PointMode;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// The main app's gate dust (DustVortex.tsx), drawn on the CPU: thousands of fine grains in the
/// Warm Lagos colours, each resting at its own scattered spot on WYRD's current shape. A change of
/// shape is a flow -- grains leave one after another in a wave across the form, are carried through
/// a swirling current that's strongest halfway, and settle into the new shape; at rest they keep a
/// faint drift. Behind it, far dust drifts slowly through the space. ENTER blows the grains out to a
/// haze (scatter); closing the sign-in card brings them back.
class GateVortex extends StatefulWidget {
  const GateVortex({super.key});

  @override
  State<GateVortex> createState() => GateVortexState();
}

const _vn = 720;
const _count = 14000, _bgCount = 4000;
const _flowMs = 2600.0, _holdMs = 4200.0, _burstMs = 900.0;

// Warm Lagos: Adire indigo, terracotta, ochre, palm green
const _palette = [
  Color(0xFF24316B),
  Color(0xFFC4572E),
  Color(0xFFE2A32B),
  Color(0xFF2F6B4C),
];
int _colourOf(double k) => k < 0.46
    ? 0
    : k < 0.72
    ? 1
    : k < 0.86
    ? 2
    : 3;

class GateVortexState extends State<GateVortex>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _shapes = _buildShapes();
  final _rng = Random();

  // every grain belongs to one of the shape's points, with its own fixed scatter around it
  final _base = Int32List(_count);
  final _jitter = Float32List(_count * 3);
  final _seed = Float32List(_count * 4); // x,y,z: a direction; w: random 0..1
  final _from = Float32List(_count * 3);
  final _to = Float32List(_count * 3);
  final _bg = Float32List(_bgCount * 4);

  int _idx = 0;
  double _now = 0, _flowStart = -1e9, _nextAt = _holdMs, _burstAt = -1e9;
  double _intensity = 0, _intensityTarget = 0, _scatter = 0, _scatterTarget = 0;

  @override
  void initState() {
    super.initState();
    double g() =>
        (_rng.nextDouble() + _rng.nextDouble() + _rng.nextDouble() - 1.5) *
        0.13;
    for (var i = 0; i < _count; i++) {
      _base[i] = i % _vn;
      _jitter[i * 3] = g();
      _jitter[i * 3 + 1] = g();
      _jitter[i * 3 + 2] = g();
      final a = _rng.nextDouble() * 6.283, b = acos(2 * _rng.nextDouble() - 1);
      _seed[i * 4] = sin(b) * cos(a);
      _seed[i * 4 + 1] = sin(b) * sin(a);
      _seed[i * 4 + 2] = cos(b);
      _seed[i * 4 + 3] = _rng.nextDouble();
    }
    for (var i = 0; i < _bgCount; i++) {
      _bg[i * 4] = (_rng.nextDouble() - 0.5) * 12; // wide
      _bg[i * 4 + 1] = (_rng.nextDouble() - 0.5) * 8; // tall
      _bg[i * 4 + 2] =
          -1 - _rng.nextDouble() * 9; // behind the shape, into the distance
      _bg[i * 4 + 3] = _rng.nextDouble();
    }
    _place(0, _from);
    _place(0, _to);
    _ticker = createTicker((d) {
      _now = d.inMicroseconds / 1000.0;
      if (_now >= _nextAt) _jump(_pick());
      _intensity += (_intensityTarget - _intensity) * 0.06;
      // out quickly, back more gently
      _scatter +=
          (_scatterTarget - _scatter) *
          (_scatterTarget > _scatter ? 0.045 : 0.03);
      setState(() {});
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _place(int shape, Float32List out) {
    final pts = _shapes[shape];
    for (var i = 0; i < _count; i++) {
      final j = _base[i] * 3;
      out[i * 3] = pts[j] + _jitter[i * 3];
      out[i * 3 + 1] = pts[j + 1] + _jitter[i * 3 + 1];
      out[i * 3 + 2] = pts[j + 2] + _jitter[i * 3 + 2];
    }
  }

  static double _ease(double t) => t * t * t * (t * (t * 6 - 15) + 10);

  /// Each grain's own beat in a change: a wave sweeping up the shape, with a little randomness.
  double _grainT(int i, double flow) {
    final wave =
        ((_from[i * 3 + 1] + 1.2) / 2.4).clamp(0.0, 1.0) * 0.45 +
        _seed[i * 4 + 3] * 0.2;
    return _ease(((flow - wave) / 0.35).clamp(0.0, 1.0));
  }

  void _jump(int next) {
    // start from wherever the last change had got to
    final f = min(1.0, (_now - _flowStart) / _flowMs);
    if (f >= 1) {
      _from.setAll(0, _to);
    } else {
      for (var i = 0; i < _count; i++) {
        final t = _grainT(i, f);
        for (var c = 0; c < 3; c++) {
          _from[i * 3 + c] += (_to[i * 3 + c] - _from[i * 3 + c]) * t;
        }
      }
    }
    _idx = next;
    _place(_idx, _to);
    _flowStart = _now;
    _nextAt = _now + _flowMs + _holdMs;
  }

  int _pick() {
    int n;
    do {
      n = _rng.nextInt(_shapes.length);
    } while (n == _idx);
    return n;
  }

  /// A bloom and a new shape (as someone types).
  void burst() {
    _burstAt = _now;
    _jump(_pick());
  }

  void setIntensity(double v) => _intensityTarget = v;

  /// Blow the grains out to a haze (true), or bring them back to the shape (false).
  void scatter(bool on) => _scatterTarget = on ? 1 : 0;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _DustPainter(this),
    size: Size.infinite,
  );
}

double _smooth(double e0, double e1, double x) {
  final t = ((x - e0) / (e1 - e0)).clamp(0.0, 1.0);
  return t * t * (3 - 2 * t);
}

/// A cheap swirling current (the GPU version's curl noise): smooth, divergence-free enough to read
/// as a flow.
void _current(
  double x,
  double y,
  double z,
  double time,
  double w,
  List<double> out,
) {
  out[0] = sin(y * 1.7 + time * 0.5 + w * 4) + sin(z * 1.3 - time * 0.3);
  out[1] = sin(z * 1.9 + time * 0.4 + w * 2) + sin(x * 1.1 + time * 0.2);
  out[2] = sin(x * 1.5 + time * 0.6 + w * 3) + sin(y * 1.4 - time * 0.35);
}

class _DustPainter extends CustomPainter {
  final GateVortexState s;
  _DustPainter(this.s);

  // grains grouped by colour, two sizes and five shades, each drawn in one call
  static const _shades = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final cx = w / 2, cy = h / 2;
    final now = s._now;
    final time = now / 1000;
    final yaw = now * (0.00026 + s._intensity * 0.0006);
    final pitch = sin(now * 0.00015) * 0.15;
    final bt = (now - s._burstAt) / _burstMs;
    final pulse = bt >= 0 && bt < 1 ? sin(bt * pi) * 0.12 : 0.0;
    final fFar = 0.8 * min(w, h);
    final f = fFar * (1 + pulse);
    final cyw = cos(yaw), syw = sin(yaw), cp = cos(pitch), sp = sin(pitch);
    final flow = min(1.0, (now - s._flowStart) / _flowMs);
    final scatter = s._scatter;
    final cur = [0.0, 0.0, 0.0];

    // groups: [colour][size][shade] -> points
    final groups = List.generate(
      _palette.length * 2 * _shades,
      (_) => <double>[],
    );
    void add(int colour, bool big, double alpha, double x, double y) {
      final shade = (alpha * _shades).floor().clamp(0, _shades - 1);
      groups[(colour * 2 + (big ? 1 : 0)) * _shades + shade]
        ..add(x)
        ..add(y);
    }

    // the far dust, behind
    final byaw = yaw * 0.35, bcy = cos(byaw), bsy = sin(byaw);
    for (var i = 0; i < _bgCount; i++) {
      final bw = s._bg[i * 4 + 3];
      var px = s._bg[i * 4], py = s._bg[i * 4 + 1], pz = s._bg[i * 4 + 2];
      _current(
        px * 0.35,
        py * 0.35 + time * 0.035,
        pz * 0.35,
        time * 0.3,
        bw * 3,
        cur,
      );
      px += cur[0] * 0.22;
      py += cur[1] * 0.22;
      pz += cur[2] * 0.22;
      py =
          ((py + time * (0.02 + bw * 0.03) + 4) % 8) -
          4; // rising very slowly, wrapping round
      final qz = pz + 5.5;
      final rx = px * bcy - qz * bsy, rz = px * bsy + qz * bcy - 5.5;
      final d = 7.5 - rz;
      final k = fFar / max(d, 0.5);
      final a =
          (0.22 + bw * 0.3) *
          (7.0 / d).clamp(0.45, 1.0) *
          (1 + scatter * 0.4) *
          _smooth(1.2, 4.0, d) *
          0.75;
      add(_colourOf((bw * 5.17) % 1), bw > 0.6, a, cx + rx * k, cy - py * k);
    }

    // the shape's grains
    final intensity = s._intensity;
    for (var i = 0; i < _count; i++) {
      final sw = s._seed[i * 4 + 3];
      final t = flow >= 1 ? 1.0 : s._grainT(i, flow);
      var px = s._from[i * 3] + (s._to[i * 3] - s._from[i * 3]) * t;
      var py = s._from[i * 3 + 1] + (s._to[i * 3 + 1] - s._from[i * 3 + 1]) * t;
      var pz = s._from[i * 3 + 2] + (s._to[i * 3 + 2] - s._from[i * 3 + 2]) * t;
      // carried by the current mid-flight, most at the halfway point
      final carry = sin(pi * t);
      if (carry > 0.01) {
        _current(
          px * 1.25,
          py * 1.25 + time * 0.12,
          pz * 1.25,
          time,
          sw * 4,
          cur,
        );
        final c = carry * (0.32 + intensity * 0.25) * 0.5;
        px += cur[0] * c;
        py += cur[1] * c;
        pz += cur[2] * c;
      }
      // at rest: a faint drift around its home
      final drift = 0.012 + 0.006 * sin(time * 0.9 + sw * 30);
      final dx = s._seed[i * 4],
          dy = s._seed[i * 4 + 1],
          dz = s._seed[i * 4 + 2];
      px += dx * drift;
      py += dy * drift;
      pz += dz * drift;
      // scattered: blown outwards from the centre on its own beat
      final sc = scatter <= 0.001
          ? 0.0
          : _smooth(sw * 0.35, 0.65 + sw * 0.35, scatter);
      if (sc > 0) {
        final len = sqrt(px * px + py * py + pz * pz) + 1e-3;
        final reach = 1.4 + sw * 2.2;
        px += (px / len + dx * 0.3) * reach * sc;
        py += (py / len + dy * 0.3) * reach * sc;
        pz += (pz / len + dz * 0.3) * reach * sc;
      }
      // turn slowly, tilt a little, then a simple perspective
      final rx = px * cyw - pz * syw, rz0 = px * syw + pz * cyw;
      final ry = py * cp - rz0 * sp, rz = py * sp + rz0 * cp;
      final d = 7.5 - rz;
      if (d <= 0.4) continue;
      final k = f / d;
      final a =
          ((0.55 + intensity * 0.25) * (7.0 / d) - carry * 0.15).clamp(
            0.12,
            0.95,
          ) *
          (1 - sc * 0.8) *
          _smooth(1.2, 4.0, d);
      // nearer grains a touch bigger
      final big = (0.9 + sw * 0.9) * (6.5 / d) > 1.45;
      add(_colourOf((sw * 7.31) % 1), big, a, cx + rx * k, cy - ry * k);
    }

    final paint = Paint()..strokeCap = StrokeCap.round;
    for (var c = 0; c < _palette.length; c++) {
      for (var b = 0; b < 2; b++) {
        paint.strokeWidth = b == 1 ? 2.3 : 1.4;
        for (var sh = 0; sh < _shades; sh++) {
          final g = groups[(c * 2 + b) * _shades + sh];
          if (g.isEmpty) continue;
          paint.color = _palette[c].withValues(alpha: (sh + 0.5) / _shades);
          canvas.drawRawPoints(
            PointMode.points,
            Float32List.fromList(g),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_DustPainter old) => true;
}

// ---- the shapes (ported from shapes.ts; every one is exactly _vn points) ----------------------

List<Float32List> _buildShapes() => [
  _sphere(),
  _mandala(),
  _infinity(),
  _helix(),
  _knot(),
  _cube(),
  _pyramid(),
  _galaxy(),
  _waveGrid(),
  _starBurst(),
];

Float32List _sphere() {
  final a = Float32List(_vn * 3);
  const r0 = 2.1;
  final g = pi * (3 - sqrt(5));
  for (var i = 0; i < _vn; i++) {
    final y = 1 - (i / (_vn - 1)) * 2;
    final r = sqrt(max(0, 1 - y * y));
    final t = g * i;
    a[i * 3] = cos(t) * r * r0;
    a[i * 3 + 1] = y * r0;
    a[i * 3 + 2] = sin(t) * r * r0;
  }
  return a;
}

Float32List _mandala() {
  const rings = 10, per = _vn ~/ rings;
  final a = Float32List(_vn * 3);
  var k = 0;
  for (var r = 0; r < rings; r++) {
    final rad = 0.3 + r * 0.22;
    for (var p = 0; p < per; p++) {
      final t = (p / per) * pi * 2 + r * 0.3;
      a[k++] = cos(t) * rad;
      a[k++] = sin(t) * rad;
      a[k++] = 0;
    }
  }
  return a;
}

Float32List _infinity() {
  final a = Float32List(_vn * 3);
  const amp = 2.1;
  for (var i = 0; i < _vn; i++) {
    final t = (i / _vn) * pi * 2, d = 1 + sin(t) * sin(t);
    a[i * 3] = amp * cos(t) / d;
    a[i * 3 + 1] = amp * sin(t) * cos(t) / d;
    a[i * 3 + 2] = sin(t * 3) * 0.35;
  }
  return a;
}

Float32List _helix() {
  final a = Float32List(_vn * 3);
  const h = _vn ~/ 2;
  for (var i = 0; i < _vn; i++) {
    final st = i < h ? 0 : 1, id = st == 1 ? i - h : i, t = id / (h - 1);
    final ang = t * pi * 10 + (st == 1 ? pi : 0);
    a[i * 3] = cos(ang) * 1.3;
    a[i * 3 + 1] = -2.8 + t * 5.6;
    a[i * 3 + 2] = sin(ang) * 1.3;
  }
  return a;
}

Float32List _knot() {
  final a = Float32List(_vn * 3);
  const p = 2, q = 3, r0 = 1.6, r = 0.6;
  for (var i = 0; i < _vn; i++) {
    final t = (i / _vn) * pi * 2;
    a[i * 3] = (r0 + r * cos(q * t)) * cos(p * t) * 1.3;
    a[i * 3 + 1] = (r0 + r * cos(q * t)) * sin(p * t) * 0.9 * 1.3;
    a[i * 3 + 2] = r * sin(q * t) * 1.3;
  }
  return a;
}

Float32List _lattice(
  List<List<double>> c,
  List<List<int>> edges, [
  double fillY = 0,
]) {
  final a = Float32List(_vn * 3);
  final per = _vn ~/ edges.length;
  var k = 0;
  for (final e in edges) {
    final p0 = c[e[0]], p1 = c[e[1]];
    for (var i = 0; i < per; i++) {
      final t = i / per;
      a[k * 3] = p0[0] + (p1[0] - p0[0]) * t;
      a[k * 3 + 1] = p0[1] + (p1[1] - p0[1]) * t;
      a[k * 3 + 2] = p0[2] + (p1[2] - p0[2]) * t;
      k++;
    }
  }
  while (k < _vn) {
    a[k * 3 + 1] = fillY;
    k++;
  }
  return a;
}

Float32List _cube() {
  const s = 1.8;
  return _lattice(
    [
      [-s, -s, -s],
      [s, -s, -s],
      [s, s, -s],
      [-s, s, -s],
      [-s, -s, s],
      [s, -s, s],
      [s, s, s],
      [-s, s, s],
    ],
    [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 0],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 4],
      [0, 4],
      [1, 5],
      [2, 6],
      [3, 7],
    ],
  );
}

Float32List _pyramid() {
  const s = 1.9;
  return _lattice(
    [
      [0, 2.2, 0],
      [-s, -1.4, -s],
      [s, -1.4, -s],
      [s, -1.4, s],
      [-s, -1.4, s],
    ],
    [
      [0, 1],
      [0, 2],
      [0, 3],
      [0, 4],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 1],
    ],
    -1.4,
  );
}

Float32List _galaxy() {
  final a = Float32List(_vn * 3);
  const arms = 3;
  for (var i = 0; i < _vn; i++) {
    final t = i / _vn, arm = i % arms, rad = 0.3 + t * 2.6;
    final ang = t * pi * 6 + arm * (pi * 2 / arms);
    final sp = sin(i * 12.9898) * 0.5 * 0.25;
    a[i * 3] = cos(ang) * rad + sp;
    a[i * 3 + 1] = sin(i * 78.233) * 0.15;
    a[i * 3 + 2] = sin(ang) * rad + sp;
  }
  return a;
}

Float32List _waveGrid() {
  final a = Float32List(_vn * 3);
  final g = sqrt(_vn).round();
  var k = 0;
  for (var gx = 0; gx < g; gx++) {
    for (var gz = 0; gz < g; gz++) {
      if (k >= _vn) break;
      final x = (gx / (g - 1) - 0.5) * 4.5, z = (gz / (g - 1) - 0.5) * 4.5;
      a[k * 3] = x;
      a[k * 3 + 1] = sin(x * 1.3) * cos(z * 1.3) * 0.8;
      a[k * 3 + 2] = z;
      k++;
    }
  }
  return a;
}

Float32List _starBurst() {
  final a = Float32List(_vn * 3);
  final g = pi * (3 - sqrt(5));
  for (var i = 0; i < _vn; i++) {
    final y = 1 - (i / (_vn - 1)) * 2, ry = sqrt(max(0, 1 - y * y)), t = g * i;
    final spike = 1 + 0.9 * pow((sin(t * 5) * cos(y * 8)).abs(), 3);
    final r = 1.7 * spike;
    a[i * 3] = cos(t) * ry * r;
    a[i * 3 + 1] = y * r;
    a[i * 3 + 2] = sin(t) * ry * r;
  }
  return a;
}
