import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

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
  static bool _okKey(String k) => RegExp(r'^[a-zA-Z0-9]{24,64}$').hasMatch(k);

  /// The player [id] belongs to the browser holding its [key] (set on its first tick): a tick, a line of chat or a song
  /// with someone else's id is ignored, so nobody can move, speak or DJ as another player.
  static _Player? _owned(String id, String key) {
    final p = _players[id];
    return p != null && p.key == key ? p : null;
  }

  /// the island names of signed-in players, by account (looked up once, kept 10 minutes)
  static final _ghosts = <String>{}; // accounts in ghost mode (by account id)
  static final _handles = <String, (String, DateTime)>{};

  /// a player changed something the island shows (ghost mode): look them up afresh
  static void forget(String userId) => _handles.remove(userId);
  /// signed-in players on the island now, by island name (lower case): on since, last seen, and metres moved since their
  /// last paid shift. Shifts pay only someone actually here, moving about, for the length of the shift.
  static final _presence = <String, ({DateTime since, DateTime last, double moved, double x, double z})>{};
  static void _seen(String handle, double x, double z) {
    final k = handle.toLowerCase(), now = DateTime.now(), p = _presence[k];
    final cont = p != null && now.difference(p.last) < const Duration(seconds: 30);
    final step = cont ? sqrt(pow(x - p.x, 2) + pow(z - p.z, 2)) : 0.0;
    _presence[k] = (since: cont ? p.since : now, last: now, moved: (cont ? p.moved : 0) + (step < 80 ? step : 0), x: x, z: z);
  }

  /// (minutes on the island without a break, metres moved since the last paid shift) for [handle]
  static (double, double) activity(String handle) {
    final p = _presence[handle.toLowerCase()];
    if (p == null || DateTime.now().difference(p.last) > const Duration(seconds: 30)) return (0, 0);
    return (DateTime.now().difference(p.since).inSeconds / 60, p.moved);
  }

  /// where [handle] is now (out on the island, seen in the last 30 s), and the metres moved so far (jumps don't count)
  static ({double x, double z, double moved})? here(String handle) {
    final p = _presence[handle.toLowerCase()];
    if (p == null || DateTime.now().difference(p.last) > const Duration(seconds: 30)) return null;
    return (x: p.x, z: p.z, moved: p.moved);
  }

  /// a shift was paid: the walking starts again from nothing
  static void paidShift(String handle) {
    final k = handle.toLowerCase(), p = _presence[k];
    if (p != null) _presence[k] = (since: p.since, last: p.last, moved: 0, x: p.x, z: p.z);
  }

  static Future<String?> _handleOf(Session s) async {
    final a = s.authenticated;
    if (a == null) return null;
    final u = a.userIdentifier, hit = _handles[u];
    if (hit != null && DateTime.now().difference(hit.$2) < const Duration(minutes: 10)) return hit.$1;
    final p = await IslandProfile.db.findFirstRow(s, where: (t) => t.authUserId.equals(UuidValue.fromString(u)));
    if (p == null) return null;
    if (p.ghost) {
      _ghosts.add(u);
    } else {
      _ghosts.remove(u);
    }
    _handles[u] = (p.handle, DateTime.now());
    return p.handle;
  }

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
    String key,
  ) async {
    final now = DateTime.now();
    _players.removeWhere((_, p) => now.difference(p.seen) > _fade);
    final taken = _players[id];
    if (!_okId(id) || !_okKey(key) || (taken != null && taken.key != key) || !x.isFinite || !z.isFinite) {
      return jsonEncode({'online': _players.length, 'players': [], 'chat': [], 'seq': _seq});
    }
    // the name others see is the account's own island name; a guest is "Guest" and four characters of their id, so no
    // one can wear someone else's name
    final handle = await _handleOf(session);
    final me = _players.putIfAbsent(id, () => _Player(id, key));
    me
      ..name = handle == null ? 'Guest ${id.substring(id.length - 4).toUpperCase()}' : _ghosts.contains(session.authenticated!.userIdentifier) ? 'Anonymous' : handle
      ..verified = handle != null && !_ghosts.contains(session.authenticated!.userIdentifier);
    if (handle != null && me.room.isEmpty) _seen(handle, me.x, me.z);
    me
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
          {'id': p.id, 'name': p.name, 'v': p.verified, 'color': p.color, 'x': p.room.isEmpty ? p.x.round() : (p.x * 10).round() / 10, 'z': p.room.isEmpty ? p.z.round() : (p.z * 10).round() / 10, 'look': p.look},
    ];
    final heard = [
      for (final l in _chat)
        if (l.seq > since && (l.id == id || (l.room == me.room && (me.room.isNotEmpty || dist(l.x, l.z) < _hear))))
          {'seq': l.seq, 'id': l.id, 'name': l.name, 'v': l.verified, 'color': l.color, 'text': l.text},
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
      'newcomers': await _fresh(session),
      'players': near.take(60).toList(),
      'chat': heard,
      'seq': _seq,
    });
  }

  static List<String> _newcomers = const [];
  static DateTime _newcomersAt = DateTime.fromMillisecondsSinceEpoch(0);
  static Future<List<String>> _fresh(Session s) async {
    if (DateTime.now().difference(_newcomersAt) < const Duration(minutes: 1)) return _newcomers;
    _newcomersAt = DateTime.now();
    final since = DateTime.now().toUtc().subtract(const Duration(hours: 24));
    _newcomers = [for (final p in await IslandProfile.db.find(s, where: (t) => (t.createdAt > since) & t.ghost.equals(false), limit: 200)) p.handle];
    return _newcomers;
  }

  /// How many are on the island now (for the welcome, before you join).
  Future<int> online(Session session) async {
    final now = DateTime.now();
    _players.removeWhere((_, p) => now.difference(p.seen) > _fade);
    return _players.length;
  }

  /// Take the decks: the DJ, standing in a club, plays a song on its speakers for everyone. [url] must be a stream from
  /// the two catalogues Island Music uses (Audius, Deezer previews). An empty [url] hands the decks back.
  Future<bool> spin(Session session, String id, String club, String url, String title, String artist, String art, String key) async {
    final p = _owned(id, key);
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
  /// A pass for the live server on Cloudflare (play.lagos-island.workers.dev/live): who you are, your island name and
  /// your friends' names, signed with the shared `liveSecret` and good for 15 minutes. The live server trusts nothing
  /// else: the name others see and who you may talk to come from here, as they do from [tick].
  Future<String> liveTicket(Session session, String id, String key) async {
    final secret = (session.passwords['liveSecret'] ?? '').trim();
    final taken = _players[id];
    if (secret.isEmpty || !_okId(id) || !_okKey(key) || (taken != null && taken.key != key)) return jsonEncode({'error': 'no'});
    final handle = await _handleOf(session);
    final ghost = handle != null && _ghosts.contains(session.authenticated!.userIdentifier);
    final friends = <String>[];
    if (handle != null && !ghost) {
      final uid = UuidValue.fromString(session.authenticated!.userIdentifier);
      final rows = await IslandFriend.db.find(session, where: (t) => t.status.equals('accepted') & (t.fromUser.equals(uid) | t.toUser.equals(uid)), limit: 500);
      final ids = {for (final r in rows) r.fromUser == uid ? r.toUser : r.fromUser};
      if (ids.isNotEmpty) {
        for (final p in await IslandProfile.db.find(session, where: (t) => t.authUserId.inSet(ids))) {
          friends.add(p.handle.toLowerCase());
        }
      }
    }
    final body = base64Url.encode(utf8.encode(jsonEncode({
      'id': id,
      'name': handle == null ? 'Guest ${id.substring(id.length - 4).toUpperCase()}' : ghost ? 'Anonymous' : handle,
      'v': handle != null && !ghost,
      'h': handle == null || ghost ? '' : handle.toLowerCase(),
      'f': friends,
      'exp': DateTime.now().millisecondsSinceEpoch ~/ 1000 + 900,
    })));
    final sig = base64Url.encode(Hmac(sha256, utf8.encode(secret)).convert(utf8.encode(body)).bytes);
    return jsonEncode({'ticket': '$body.$sig'});
  }

  Future<void> say(Session session, String id, String text, String key) async {
    final p = _owned(id, key);
    final t = _clean(text, 140);
    if (p == null || t.isEmpty) return;
    final now = DateTime.now();
    if (now.difference(p.lastSaid) < const Duration(milliseconds: 800)) return; // no flooding
    p.lastSaid = now;
    _chat.add(_Line(++_seq, p.id, p.name, p.color, t, p.x, p.z, p.room, p.verified));
    if (_chat.length > _keepChat) _chat.removeRange(0, _chat.length - _keepChat);
  }
}

class _Player {
  final String id;
  /// the private key of the browser this player belongs to
  final String key;
  /// signed in: [name] is their account's island name
  bool verified = false;
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
  _Player(this.id, this.key);
}

class _Line {
  final int seq;
  final String id, name, color, text, room;
  final double x, z;
  final bool verified;
  _Line(this.seq, this.id, this.name, this.color, this.text, this.x, this.z, this.room, this.verified);
}

class _Deck {
  final String by, url, title, artist, art;
  final DateTime at;
  _Deck(this.by, this.url, this.title, this.artist, this.art, this.at);
}
