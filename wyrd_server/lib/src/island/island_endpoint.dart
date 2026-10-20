import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

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
  /// what each club's DJ is playing, by the club's room key: set by [spin] from inside the club, sent to everyone with
  /// [tick] so the whole island hears the same song from the same moment; dropped when the DJ leaves or goes quiet
  static final _decks = <String, _Deck>{};
  static const _deckIdle = Duration(minutes: 12);
  static final _chat = <_Line>[];
  static var _seq = 0;

  static String _clean(String s, int max) {
    final t = s.replaceAll(RegExp(r'[\u0000-\u001f<>]'), '').trim();
    return t.length > max ? t.substring(0, max) : t;
  }

  static bool _okId(String id) => RegExp(r'^[a-zA-Z0-9_-]{8,40}$').hasMatch(id);

  /// The housing register, public: which homes in the island's estates are lived in. Only the plots, never who owns them,
  /// so anyone (a guest too) sees the same real count. Read fresh from the homes table, cached for 10 seconds.
  static String? _housing;
  static DateTime _housingAt = DateTime.fromMillisecondsSinceEpoch(0);
  Future<String> housing(Session session) async {
    if (_housing != null &&
        DateTime.now().difference(_housingAt) < const Duration(seconds: 10))
      return _housing!;
    final rows = await IslandHome.db.find(session, limit: 1000);
    _housing = jsonEncode({
      'taken': [for (final h in rows) h.plot],
      'bqs': await IslandProfile.db.count(session), // every Lagosian keeps a BQ on HQ Row
      'at': DateTime.now().toUtc().toIso8601String(),
    });
    _housingAt = DateTime.now();
    return _housing!;
  }

  /// The airport's hangars, public: the three newest private jets, by registration and colour; the owner's island name
  /// only where they chose to show it. Cached for 30 seconds.
  static String? _hangars;
  static DateTime _hangarsAt = DateTime.fromMillisecondsSinceEpoch(0);
  Future<String> hangars(Session session) async {
    if (_hangars != null && DateTime.now().difference(_hangarsAt) < const Duration(seconds: 30)) return _hangars!;
    final jets = await IslandJet.db.find(session, orderBy: (t) => t.boughtAt.desc(), limit: 3);
    final out = <Map<String, dynamic>>[];
    for (final j in jets) {
      String? name;
      if (j.showName) name = (await IslandProfile.db.findFirstRow(session, where: (t) => t.authUserId.equals(j.authUserId)))?.handle;
      out.add({'tail': j.tail, 'model': j.model, 'livery': j.livery, if (name != null) 'name': name});
    }
    _hangars = jsonEncode(out);
    _hangarsAt = DateTime.now();
    return _hangars!;
  }

  /// Here I am; who's around? [since]: the last chat line already seen (0 the first time).
  Future<String> tick(
    Session session,
    String id,
    String name,
    String color,
    double x,
    double z,
    int since,
    String room,
    String look,
    String car,
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
      ..room = _clean(room, 40)
      ..look = RegExp(r'^[a-z0-9_,|.+-]{0,240}$').hasMatch(look) ? look : ''
      ..car = RegExp(r'^[a-z]{2,16}:#[0-9A-Fa-f]{6}$').hasMatch(car) ? car : ''
      ..seen = now;
    double dist(double ax, double az) => sqrt(pow(ax - me.x, 2) + pow(az - me.z, 2));
    final near = [
      for (final p in _players.values)
        if (p.id != id && p.room == me.room && (me.room.isNotEmpty || dist(p.x, p.z) < _near))
          {'id': p.id, 'name': p.name, 'color': p.color, 'x': p.room.isEmpty ? p.x.round() : (p.x * 10).round() / 10, 'z': p.room.isEmpty ? p.z.round() : (p.z * 10).round() / 10, 'look': p.look},
    ];
    final heard = [
      for (final l in _chat)
        if (l.seq > since && (l.id == id || (l.room == me.room && (me.room.isNotEmpty || dist(l.x, l.z) < _hear))))
          {'seq': l.seq, 'id': l.id, 'name': l.name, 'color': l.color, 'text': l.text},
    ];
    // the cars parked outside each building: one per person inside who drove there
    final parked = <String, List<String>>{};
    for (final p in _players.values) {
      if (p.room.isNotEmpty && p.car.isNotEmpty) (parked[p.room] ??= []).add(p.car);
    }
    // the clubs' decks: a DJ who has left the club (or the island), or gone quiet, hands back to the resident DJ
    _decks.removeWhere((club, d) => _players[d.by]?.room != club || now.difference(d.at) > _deckIdle);
    return jsonEncode({
      'decks': {
        for (final e in _decks.entries)
          e.key: {'url': e.value.url, 'title': e.value.title, 'artist': e.value.artist, 'art': e.value.art, 'dj': _players[e.value.by]?.name ?? 'DJ', 'by': e.value.by, 'ago': now.difference(e.value.at).inMilliseconds},
      },
      'parked': parked,
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

  /// Take the decks: the DJ, standing in a club, plays a song on its speakers for everyone. [url] must be a stream from
  /// the two catalogues Island Music uses (Audius, Deezer previews). An empty [url] hands the decks back.
  Future<bool> spin(Session session, String id, String club, String url, String title, String artist, String art) async {
    final p = _players[id];
    if (p == null || !club.startsWith('place:club:') || p.room != club) return false;
    final held = _decks[club];
    if (held != null && held.by != id && _players[held.by]?.room == club) return false; // someone else is on the decks
    if (url.isEmpty) {
      if (held?.by == id) _decks.remove(club);
      return true;
    }
    final ok = RegExp(r'^https://(api\.audius\.co/v1/tracks/[A-Za-z0-9]+/stream\?app_name=[A-Za-z]+|cdn[a-z]*-preview[a-z0-9-]*\.dzcdn\.net/[^\s<>"]+)$');
    final artOk = RegExp(r'^https://[a-z0-9.-]+(\.dzcdn\.net|\.audius\.co|\.audius\.org|audius[a-z0-9.-]*)/[^\s<>"]*$');
    if (!ok.hasMatch(url)) return false;
    _decks[club] = _Deck(id, url, _clean(title, 80), _clean(artist, 60), artOk.hasMatch(art) ? art : '', DateTime.now());
    return true;
  }

  /// A line of chat, heard by the people near the speaker.
  Future<void> say(Session session, String id, String text) async {
    final p = _players[id];
    final t = _clean(text, 140);
    if (p == null || t.isEmpty) return;
    final now = DateTime.now();
    if (now.difference(p.lastSaid) < const Duration(milliseconds: 800)) return; // no flooding
    p.lastSaid = now;
    _chat.add(_Line(++_seq, p.id, p.name, p.color, t, p.x, p.z, p.room));
    if (_chat.length > _keepChat) _chat.removeRange(0, _chat.length - _keepChat);
  }
}

class _Player {
  final String id;
  String name = 'Lagosian';
  String color = '#C4572E';
  double x = 0, z = 0;
  /// '' outside; inside a building, its key (everyone in the same room sees and hears each other)
  String room = '';
  /// how they look and what they're doing: "g,skin,hair,style,bottom|pose,x,z" (pose: sit, sleep)
  String look = '';
  /// the car they drove here: "model:#colour" ('' on foot)
  String car = '';
  DateTime seen = DateTime.now();
  DateTime lastSaid = DateTime.fromMillisecondsSinceEpoch(0);
  _Player(this.id);
}

class _Line {
  final int seq;
  final String id, name, color, text, room;
  final double x, z;
  _Line(this.seq, this.id, this.name, this.color, this.text, this.x, this.z, this.room);
}

class _Deck {
  final String by, url, title, artist, art;
  final DateTime at;
  _Deck(this.by, this.url, this.title, this.artist, this.art, this.at);
}
