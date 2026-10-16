import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

/// LAGOS ISLAND together: who is on the island and where, and what they say to the people near them.
///
/// Less is more: all of it lives in memory (a player who stops sending fades out in 20 seconds; the
/// last 300 lines of chat are kept), nothing is stored, and no account is needed -- the page makes
/// up an id and a name the first time and keeps them in the browser. Positions are metres from Tafawa
/// Balewa Square (x east, z south), as in the map.
///
/// The page calls [tick] about once a second: its own position in, the people near it, any new
/// lines of chat near it and the count on the island out (as JSON). [say] posts a line.
class IslandEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _fade = Duration(seconds: 20);
  static const _near = 2500.0; // metres: who you see on the map
  static const _hear = 600.0; // metres: whose chat reaches you
  static const _keepChat = 300;

  static final _players = <String, _Player>{};
  static final _chat = <_Line>[];
  static var _seq = 0;

  static String _clean(String s, int max) {
    final t = s.replaceAll(RegExp(r'[\u0000-\u001f<>]'), '').trim();
    return t.length > max ? t.substring(0, max) : t;
  }

  static bool _okId(String id) => RegExp(r'^[a-zA-Z0-9_-]{8,40}$').hasMatch(id);

  /// Here I am; who's around? [since]: the last chat line already seen (0 the first time).
  Future<String> tick(
    Session session,
    String id,
    String name,
    String color,
    double x,
    double z,
    int since,
  ) async {
    final now = DateTime.now();
    _players.removeWhere((_, p) => now.difference(p.seen) > _fade);
    if (!_okId(id) || !x.isFinite || !z.isFinite) {
      return jsonEncode({'online': _players.length, 'players': [], 'chat': [], 'seq': _seq});
    }
    final me = _players.putIfAbsent(id, () => _Player(id));
    me
      ..name = _clean(name, 24).isEmpty ? 'Lagosian' : _clean(name, 24)
      ..color = RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(color) ? color : '#C4572E'
      ..x = x.clamp(-60000, 60000).toDouble()
      ..z = z.clamp(-60000, 60000).toDouble()
      ..seen = now;
    double dist(double ax, double az) => sqrt(pow(ax - me.x, 2) + pow(az - me.z, 2));
    final near = [
      for (final p in _players.values)
        if (p.id != id && dist(p.x, p.z) < _near)
          {'id': p.id, 'name': p.name, 'color': p.color, 'x': p.x.round(), 'z': p.z.round()},
    ];
    final heard = [
      for (final l in _chat)
        if (l.seq > since && (l.id == id || dist(l.x, l.z) < _hear))
          {'seq': l.seq, 'id': l.id, 'name': l.name, 'color': l.color, 'text': l.text},
    ];
    return jsonEncode({
      'online': _players.length,
      'players': near.take(60).toList(),
      'chat': heard,
      'seq': _seq,
    });
  }

  /// How many are on the island now (for the welcome, before you join).
  Future<int> online(Session session) async {
    final now = DateTime.now();
    _players.removeWhere((_, p) => now.difference(p.seen) > _fade);
    return _players.length;
  }

  /// A line of chat, heard by the people near the speaker.
  Future<void> say(Session session, String id, String text) async {
    final p = _players[id];
    final t = _clean(text, 140);
    if (p == null || t.isEmpty) return;
    final now = DateTime.now();
    if (now.difference(p.lastSaid) < const Duration(milliseconds: 800)) return; // no flooding
    p.lastSaid = now;
    _chat.add(_Line(++_seq, p.id, p.name, p.color, t, p.x, p.z));
    if (_chat.length > _keepChat) _chat.removeRange(0, _chat.length - _keepChat);
  }
}

class _Player {
  final String id;
  String name = 'Lagosian';
  String color = '#C4572E';
  double x = 0, z = 0;
  DateTime seen = DateTime.now();
  DateTime lastSaid = DateTime.fromMillisecondsSinceEpoch(0);
  _Player(this.id);
}

class _Line {
  final int seq;
  final String id, name, color, text;
  final double x, z;
  _Line(this.seq, this.id, this.name, this.color, this.text, this.x, this.z);
}
