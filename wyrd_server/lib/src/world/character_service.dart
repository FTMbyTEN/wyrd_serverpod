import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Players' characters: made once in the character creator, editable later, the same on every
/// device (and, with multiplayer, what other players see). Everything is checked here: known bases,
/// proportions within range, a sensible street name.
class CharacterService {
  static const bases = {'ten', 'ama'};
  static const neons = {0x00e5ff, 0xff2bd6, 0xffc400, 0x1aff9c, 0x4a6bff, 0xff3b30};

  static Future<PlayerCharacter?> mine(Session session, UuidValue user) =>
      PlayerCharacter.db.findFirstRow(session, where: (t) => t.authUserId.equals(user));

  /// The character as the app reads it (JSON), or 'null'.
  static Future<String> get(Session session, UuidValue user) async {
    final c = await mine(session, user);
    return c == null ? 'null' : jsonEncode(toJson(c));
  }

  static Map<String, dynamic> toJson(PlayerCharacter c) => {
        'base': c.base, 'outfit': c.outfit, 'name': c.name, 'height': c.height, 'build': c.build, 'shoulders': c.shoulders,
        'hips': c.hips, 'skin': c.skin, 'outfitHue': c.outfitHue, 'neon': c.neon,
      };

  /// Saves the character from the creator (JSON). Returns it as stored.
  static Future<String> save(Session session, UuidValue user, String json) async {
    final m = jsonDecode(json) as Map<String, dynamic>;
    final base = m['base'];
    if (base is! String || !bases.contains(base)) throw Exception('Unknown body.');
    final name = (m['name'] as String? ?? '').trim().replaceAll(RegExp(r'\s+'), ' ');
    if (name.length < 2 || name.length > 20) throw Exception('Your name should be 2 to 20 characters.');
    if (!RegExp(r"^[\p{L}\p{N} '._-]+$", unicode: true).hasMatch(name)) throw Exception('Use letters, numbers, spaces and . _ - only.');
    double unit(String k) => ((m[k] as num?) ?? 0).toDouble().clamp(-1.0, 1.0);
    final neon = (m['neon'] as num?)?.toInt() ?? 0x00e5ff;
    if (!neons.contains(neon)) throw Exception('Unknown neon colour.');
    final hue = ((m['outfitHue'] as num?) ?? 0).toDouble();
    final now = DateTime.now().toUtc();
    final old = await mine(session, user);
    final c = PlayerCharacter(
      id: old?.id, authUserId: user, base: base, outfit: ((m['outfit'] as num?) ?? 0).toInt().clamp(0, 4), name: name,
      height: unit('height'), build: unit('build'), shoulders: unit('shoulders'), hips: unit('hips'),
      skin: unit('skin'), outfitHue: ((hue % 360) + 360) % 360, neon: neon,
      createdAt: old?.createdAt ?? now, updatedAt: now,
    );
    final saved = old == null ? await PlayerCharacter.db.insertRow(session, c) : await PlayerCharacter.db.updateRow(session, c);
    return jsonEncode(toJson(saved));
  }
}
