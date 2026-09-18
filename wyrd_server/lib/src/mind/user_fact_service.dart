import 'dart:math';

import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class _FactPattern {
  final RegExp re;
  final String category;
  final String Function(RegExpMatch) label;
  final bool Function(RegExpMatch)? guard;

  const _FactPattern(this.re, this.category, this.label, {this.guard});
}

/// Ports server.js's FACT_PATTERNS/extractUserFacts/addUserFacts/mostRelevantFacts -- the
/// small heuristic that lets WYRD remember concrete things a person tells it about themselves
/// (name, location, work, preferences), with a forgetting-curve relevance decay and a
/// first-pass moderation blocklist.
class UserFactService {
  static const _maxProfileFacts = 80;
  static const _factHalfLifeDays = 21.0;

  static final _nameStopwords = <String>{
    'not', 'just', 'still', 'also', 'really', 'very', 'so', 'here', 'there',
    'going', 'trying', 'sure', 'happy', 'sad', 'tired', 'fine', 'okay', 'ok',
    'ready', 'done', 'sorry', 'glad', 'afraid', 'worried', 'confused', 'excited',
    'curious', 'interested', 'feeling', 'gonna', 'about', 'back', 'thinking',
    'wondering', 'guessing', 'saying', 'asking', 'telling', 'kidding', 'joking',
    'serious', 'confident', 'nervous', 'stressed', 'exhausted', 'bored', 'lost',
  };

  static final _blockedTerms = <String>[
    'nigger', 'faggot', 'retard', 'kike', 'spic', 'chink', 'tranny',
  ];

  static bool _containsBlockedContent(String text) {
    final lower = text.toLowerCase();
    return _blockedTerms.any(lower.contains);
  }

  static final List<_FactPattern> _patterns = [
    _FactPattern(
      RegExp(r"\bmy name'?s? is ([a-z][a-z '-]{1,30})", caseSensitive: false),
      'name',
      (m) => 'Name: ${m.group(1)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi'?m (?:called|known as) ([a-z][a-z '-]{1,30})", caseSensitive: false),
      'name',
      (m) => 'Goes by: ${m.group(1)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi(?:'m| am) ([a-z][a-z'-]{1,20})(?=[.,!?]|\$)", caseSensitive: false),
      'name',
      (m) => 'Name: ${m.group(1)!.trim()}',
      guard: (m) => !_nameStopwords.contains(m.group(1)!.trim().toLowerCase()),
    ),
    _FactPattern(
      RegExp(r"\bi live in ([a-z][a-z ,'-]{2,40}?)(?=[.,!?]|\$|\band\b|\bbut\b)", caseSensitive: false),
      'location',
      (m) => 'Lives in ${m.group(1)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi'?m from ([a-z][a-z ,'-]{2,40}?)(?=[.,!?]|\$|\band\b|\bbut\b)", caseSensitive: false),
      'location',
      (m) => 'From ${m.group(1)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi work (?:as|at) (?:an? )?([a-z][a-z0-9 '-]{2,40}?)(?=[.,!?]|\$|\band\b|\bbut\b)", caseSensitive: false),
      'work',
      (m) => 'Works ${m.group(0)!.toLowerCase().startsWith('i work at') ? 'at' : 'as'} ${m.group(1)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi'?m (?:a|an) ([a-z][a-z0-9 '-]{2,40}?)(?=[.,!?]|\$|\band\b|\bbut\b)", caseSensitive: false),
      'identity',
      (m) {
        final value = m.group(1)!.trim();
        final article = RegExp(r'^[aeiou]', caseSensitive: false).hasMatch(value) ? 'n' : '';
        return 'Is a$article $value';
      },
    ),
    _FactPattern(
      RegExp(r"\bmy (?:dog|cat|pet)(?:'s name)? is ([a-z][a-z '-]{1,30})", caseSensitive: false),
      'pet',
      (m) => "Pet's name: ${m.group(1)!.trim()}",
    ),
    _FactPattern(
      RegExp(r"\bi have (a|an|\d+|two|three|four|five) ([a-z][a-z0-9 '-]{2,40})(?=[.,!?]|\$)", caseSensitive: false),
      'life',
      (m) => 'Has ${m.group(1)} ${m.group(2)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bmy (?:favorite|favourite) ([a-z]+) is ([a-z0-9 '-]{2,40})(?=[.,!?]|\$)", caseSensitive: false),
      'preference',
      (m) => 'Favorite ${m.group(1)}: ${m.group(2)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi (?:really )?(?:love|enjoy) ([a-z][a-z0-9 '-]{2,40})(?=[.,!?]|\$)", caseSensitive: false),
      'preference',
      (m) => 'Likes ${m.group(1)!.trim()}',
    ),
    _FactPattern(
      RegExp(r"\bi (?:hate|dislike|can'?t stand) ([a-z][a-z0-9 '-]{2,40})(?=[.,!?]|\$)", caseSensitive: false),
      'preference',
      (m) => 'Dislikes ${m.group(1)!.trim()}',
    ),
  ];

  static List<UserFact> extractFacts(String text) {
    final now = DateTime.now().toUtc();
    final facts = <UserFact>[];
    for (final p in _patterns) {
      final m = p.re.firstMatch(text);
      if (m == null) continue;
      if (p.guard != null && !p.guard!(m)) continue;
      try {
        final label = p.label(m).replaceAll(RegExp(r'\s+'), ' ').trim();
        if (label.length > 4 && label.length < 120) {
          facts.add(UserFact(text: label, category: p.category, timestamp: now, lastMentioned: now));
        }
      } catch (_) {
        // a pattern's label callback threw (e.g. an unexpectedly empty group) -- skip it,
        // same as Node's try/catch around p.label(m).
      }
    }
    return facts;
  }

  /// Loads the UserProfile for [authUserId], creating a fresh one if this is their first
  /// activity of any kind (chat, profile view, etc.) -- shared with ProfileEndpoint so both
  /// entry points agree on what "first-time user" means.
  static Future<UserProfile> loadOrCreateProfile(Session session, UuidValue authUserId) async {
    final existing = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    return await UserProfile.db.insertRow(
      session,
      UserProfile(
        authUserId: authUserId,
        username: null,
        facts: [],
        visitCount: 0,
        firstSeen: now,
        lastSeen: now,
      ),
    );
  }

  /// Merges [newFacts] into [session]'s UserProfile for [authUserId], reinforcing (bumping
  /// lastMentioned on) an existing near-duplicate instead of adding a new one. Returns the
  /// facts that were newly added (not reinforcements), for broadcasting to the client.
  static Future<List<UserFact>> addFacts(
    Session session,
    UuidValue authUserId,
    List<UserFact> newFacts,
  ) async {
    if (newFacts.isEmpty) return [];

    final profile = await loadOrCreateProfile(session, authUserId);
    final facts = [...profile.facts];
    final added = <UserFact>[];
    final now = DateTime.now().toUtc();

    for (final f in newFacts) {
      if (_containsBlockedContent(f.text)) continue;
      final lower = f.text.toLowerCase();
      final existingIndex = facts.indexWhere((e) {
        final el = e.text.toLowerCase();
        return el == lower || el.contains(lower) || lower.contains(el);
      });
      if (existingIndex != -1) {
        facts[existingIndex] = facts[existingIndex].copyWith(lastMentioned: now);
        continue;
      }
      facts.add(f);
      added.add(f);
    }

    if (added.isEmpty) return [];

    final trimmed = facts.length > _maxProfileFacts
        ? facts.sublist(facts.length - _maxProfileFacts)
        : facts;

    await UserProfile.db.updateRow(session, profile.copyWith(facts: trimmed));
    return added;
  }

  static double _factRelevance(UserFact fact, DateTime now) {
    final daysSince = now.difference(fact.lastMentioned).inHours / 24.0;
    final clamped = daysSince < 0 ? 0.0 : daysSince;
    return pow(0.5, clamped / _factHalfLifeDays).toDouble();
  }

  static List<UserFact> mostRelevantFacts(List<UserFact> facts, int limit) {
    final now = DateTime.now().toUtc();
    final ranked = facts.toList()
      ..sort((a, b) => _factRelevance(b, now).compareTo(_factRelevance(a, now)));
    return ranked.take(limit).toList();
  }
}
