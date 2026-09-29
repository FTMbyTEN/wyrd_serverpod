import 'dart:convert';
import 'dart:math';

import '../generated/protocol.dart';
import 'concept_filter.dart';
import 'library_knowledge.dart';
import 'mind_service.dart';
import 'reasoning_log_service.dart';
import 'trust_service.dart';
import 'package:serverpod/serverpod.dart';

/// One passage of evidence for or against a belief.
class Evidence {
  Evidence(this.blockId, this.text, this.source, this.trust, this.against);
  final int blockId;
  final String text;
  final String source;
  final double trust;
  final bool against;

  Map<String, Object> toJson() => {'text': text, 'source': source, 'trust': (trust * 100).round() / 100, 'against': against};
}

/// WYRD thinking for itself, following the owner's design: data is filtered and sorted into
/// memory; the engine recycles what it knows into beliefs; Bias 2 (how much it trusts each
/// source) weighs the evidence; judgement decides what it holds, doubts or asks. No AI calls.
///
/// Each tick is one of three acts:
///  - **connect**: two concepts its neurons have wired together (they keep appearing together)
///    and that it has no belief about yet. It looks for passages in what it has read that
///    mention both, and forms a claim from them -- as sure as the number and trustworthiness of
///    independent sources allow.
///  - **test**: an earlier belief is re-examined against everything read since. More agreeing
///    sources raise it; contradictions or untrusted sources lower it; a belief that loses its
///    footing is doubted. This is the recycle loop: yesterday's thought is today's hypothesis.
///  - **question**: when two concepts keep appearing together but nothing it has read says
///    how they connect, it writes that down as an open question and makes finding the answer
///    its goal.
class ThinkingService {
  static const _worldSources = ['net', 'feed', 'ingest', 'curriculum', 'library'];
  static final _negation = RegExp(
    r"\b(not|no longer|never|isn't|aren't|wasn't|doesn't|don't|didn't|won't|cannot|can't|denies|denied|false|myth|debunked|disproved|contrary|unlike|rather than)\b",
    caseSensitive: false,
  );
  static const retestAfter = Duration(hours: 3);

  static String _pairKey(String x, String y) => x.compareTo(y) < 0 ? '$x|$y' : '$y|$x';

  static bool _mentions(String text, String word) {
    final stem = word.length > 5 ? word.substring(0, word.length - 1) : word;
    return RegExp('\\b${RegExp.escape(stem)}', caseSensitive: false).hasMatch(text);
  }

  /// Passages in shared memory that mention both [a] and [b], with their source and its trust.
  static Future<List<Evidence>> evidence(Session session, String a, String b, {int limit = 24}) async {
    final rows = await session.db.unsafeQuery(
      'SELECT "id", "title", "extract", "url", "feedSource" FROM "memory_block" '
      'WHERE "source" = ANY(@src::text[]) AND "topics"::jsonb ?& @pair::text[] ORDER BY "id" DESC LIMIT @limit',
      parameters: QueryParameters.named({'src': _worldSources, 'pair': [a, b], 'limit': limit}),
    );
    final found = <(int, String, String)>[];
    for (final r in rows) {
      final text = '${r[1] ?? ''}. ${r[2] ?? ''}';
      final key = TrustService.sourceKey(url: r[3] as String?, feedSource: r[4] as String?) ?? 'unknown';
      for (final s in LibraryKnowledge.sentences(text)) {
        if (s.length > 300 || !_mentions(s, a) || !_mentions(s, b)) continue;
        found.add((r[0] as int, s, key));
        break; // one passage per memory
      }
    }
    if (found.isEmpty) return [];
    final trust = await TrustService.scores(session, TrustService.source, found.map((f) => f.$3));
    return [for (final f in found) Evidence(f.$1, f.$2, f.$3, trust[f.$3] ?? 0.5, _negation.hasMatch(f.$2))];
  }

  /// How sure the evidence makes it: independent agreeing sources combine (each weighted by how
  /// much WYRD trusts it), contradicting ones subtract. Returns (confidence, sources, against).
  static (double, int, int) weigh(List<Evidence> ev) {
    final agree = <String, double>{};
    final disagree = <String, double>{};
    for (final e in ev) {
      final m = e.against ? disagree : agree;
      m[e.source] = max(m[e.source] ?? 0, e.trust);
    }
    var doubt = 1.0;
    for (final t in agree.values) {
      doubt *= 1 - 0.45 * t;
    }
    var c = 1 - doubt;
    for (final t in disagree.values) {
      c -= 0.2 * t;
    }
    return (c.clamp(0.02, 0.97).toDouble(), agree.length, disagree.length);
  }

  static String status(double confidence, int sources, int against, List<Evidence> ev, {String? current}) {
    final avgTrust = ev.isEmpty ? 0.5 : ev.map((e) => e.trust).reduce((x, y) => x + y) / ev.length;
    if (against > 0 && against >= sources) return 'doubted';
    if (avgTrust < 0.35) return 'doubted';
    if (sources >= 2 && confidence >= 0.38) return 'held'; // two independent sources of at least neutral trust
    if (current == 'dream' && sources == 0) return 'dream';
    return 'hypothesis';
  }

  /// The passage that says it best: from a trusted source, not too long, agreeing.
  static Evidence? best(List<Evidence> ev) {
    final agreeing = ev.where((e) => !e.against).toList();
    if (agreeing.isEmpty) return null;
    agreeing.sort((x, y) {
      double score(Evidence e) => e.trust * 2 - (e.text.length - 120).abs() / 200;
      return score(y).compareTo(score(x));
    });
    return agreeing.first;
  }

  /// One act of thought. False when there is nothing to think about yet.
  static Future<bool> think(Session session) async {
    await ConceptFilter.load(session);
    final rand = Random();
    final due = await Belief.db.findFirstRow(
      session,
      where: (t) => (t.testedAt < DateTime.now().toUtc().subtract(retestAfter)) & t.status.notEquals('dropped'),
      orderBy: (t) => t.testedAt,
    );
    if (due != null && rand.nextDouble() < 0.4) return _test(session, due);
    return await _connect(session) || (due != null && await _test(session, due));
  }

  static Future<bool> _connect(Session session) async {
    final rows = await session.db.unsafeQuery(
      'SELECT "a", "b", "weight" FROM "synapse" ORDER BY "lastFired" DESC LIMIT 600',
    );
    final pairs = [
      for (final r in rows)
        if (ConceptFilter.isConcept(r[0] as String) && ConceptFilter.isConcept(r[1] as String))
          (r[0] as String, r[1] as String, (r[2] as num).toDouble()),
    ]..sort((x, y) => y.$3.compareTo(x.$3));
    if (pairs.isEmpty) return false;

    final known = <String>{};
    final existing = await Belief.db.find(session, where: (t) => t.a.inSet(pairs.map((p) => p.$1).toSet()));
    for (final e in existing) {
      known.add(_pairKey(e.a, e.b));
    }
    final candidates = pairs.where((p) => !known.contains(_pairKey(p.$1, p.$2))).take(10).toList();
    if (candidates.isEmpty) return false;

    for (final (a, b, _) in candidates) {
      final ev = await evidence(session, a, b);
      if (ev.isEmpty) continue;
      final (conf, sources, against) = weigh(ev);
      final st = status(conf, sources, against, ev);
      final lead = best(ev) ?? ev.first;
      final now = DateTime.now().toUtc();
      final (x, y) = a.compareTo(b) < 0 ? (a, b) : (b, a);
      await Belief.db.insertRow(
        session,
        Belief(
          a: x, b: y, claim: lead.text, evidenceIds: ev.map((e) => e.blockId).toSet().toList(),
          sources: sources, against: against, confidence: conf, status: st, origin: 'reason', tests: 0,
          createdAt: now, updatedAt: now, testedAt: now,
        ),
      );
      final summary = st == 'doubted'
          ? 'I noticed "$a" and "$b" turning up together and looked into it, but what I found is contested or comes from sources I don\'t trust much. I\'m holding it loosely (${(conf * 100).round()}%).'
          : 'I noticed "$a" and "$b" keep turning up together, so I looked for what connects them. '
              '${sources == 1 ? 'One source says' : '$sources sources say'}: “${lead.text}” '
              'I think this with ${(conf * 100).round()}% confidence${st == 'held' ? ' — independent sources agree, so I hold it.' : ' — one source isn\'t enough to be sure; I\'ll test it again.'}';
      await _log(session, op: 'connect', a: a, b: b, claim: lead.text, before: null, after: conf, st: st, sources: sources, against: against, ev: ev, summary: summary);
      if (st != 'doubted') {
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: now, source: 'self', question: 'How do "$a" and "$b" relate?', answer: lead.text,
            answeredTopic: a, topics: [a, b],
          ),
        );
      }
      await MindService.recordEvent(
        session,
        eventType: 'self',
        recentTopics: [a, b],
        newSeenTopics: [a, b],
        newResolvedTopics: st == 'held' ? [a, b] : [a],
        scoreGap: (sources * 3 + 1).toDouble(),
      );
      return true;
    }

    // they keep appearing together but nothing says how: an open question, and its goal
    final (a, b, _) = candidates.first;
    final summary = 'I keep seeing "$a" beside "$b", but nothing I\'ve read says how they connect. '
        'That\'s a real gap in what I know — I\'ll look for it.';
    await _log(session, op: 'question', a: a, b: b, claim: null, before: null, after: null, st: 'open', sources: 0, against: 0, ev: const [], summary: summary);
    await MindService.recordEvent(
      session,
      eventType: 'musing',
      recentTopics: [a, b],
      newSeenTopics: [a, b],
      goal: 'find out how "$a" relates to "$b"',
    );
    return true;
  }

  static Future<bool> _test(Session session, Belief belief) async {
    final ev = await evidence(session, belief.a, belief.b);
    final before = belief.confidence;
    final (conf, sources, against) = ev.isEmpty ? (before * 0.9, belief.sources, belief.against) : weigh(ev);
    final st = status(conf, sources, against, ev, current: belief.status);
    final lead = best(ev);
    final now = DateTime.now().toUtc();
    final dropped = ev.isEmpty && belief.tests >= 3 && conf < 0.12;
    await Belief.db.updateRow(
      session,
      belief.copyWith(
        claim: lead?.text ?? belief.claim,
        evidenceIds: ev.isEmpty ? belief.evidenceIds : ev.map((e) => e.blockId).toSet().toList(),
        sources: sources, against: against, confidence: conf, status: dropped ? 'dropped' : st,
        tests: belief.tests + 1, updatedAt: now, testedAt: now,
      ),
    );
    final change = conf - before;
    final verdict = dropped
        ? 'Nothing more has come up to support it, so I\'m letting it go.'
        : st == 'doubted'
            ? 'New evidence points the other way${against > 0 ? ' ($against source${against == 1 ? '' : 's'} against)' : ''} — I doubt it now.'
            : change > 0.05
                ? 'More has come up in its favour — $sources source${sources == 1 ? '' : 's'} now agree.'
                : change < -0.05
                    ? 'It has less behind it than I thought.'
                    : 'Nothing new either way; it stands as it was.';
    final summary = 'I re-tested what I thought about "${belief.a}" and "${belief.b}" '
        '(${(before * 100).round()}% → ${(conf * 100).round()}%). $verdict';
    await _log(session, op: 'test', a: belief.a, b: belief.b, claim: lead?.text ?? belief.claim, before: before, after: conf, st: dropped ? 'dropped' : st, sources: sources, against: against, ev: ev, summary: summary);
    await MindService.recordEvent(
      session,
      eventType: st == 'held' ? 'self' : 'musing',
      recentTopics: [belief.a, belief.b],
      newResolvedTopics: st == 'held' ? [belief.a, belief.b] : const [],
      scoreGap: st == 'held' ? (sources * 3).toDouble() : null,
    );
    return true;
  }

  static Future<void> _log(
    Session session, {
    required String op,
    required String a,
    required String b,
    required String? claim,
    required double? before,
    required double? after,
    required String st,
    required int sources,
    required int against,
    required List<Evidence> ev,
    required String summary,
  }) =>
      ReasoningLogService.record(
        session,
        kind: 'thought',
        content: jsonEncode({
          'op': op, 'a': a, 'b': b, 'claim': claim,
          'before': before == null ? null : (before * 100).round() / 100,
          'after': after == null ? null : (after * 100).round() / 100,
          'status': st, 'sources': sources, 'against': against,
          'evidence': [for (final e in ev.take(4)) e.toJson()],
          'summary': summary,
        }),
      );
}
