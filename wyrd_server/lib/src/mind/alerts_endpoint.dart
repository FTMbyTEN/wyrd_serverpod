import 'dart:convert';

import '../generated/protocol.dart';
import 'mind_service.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/alerts from server.js. Not a stored feature -- a synthesis of events already
/// logged elsewhere (diary, dreams, COP log, digest milestones), newest first. Public, like Node.
class AlertsEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<List<AlertNote>> getAlerts(Session session) =>
      PublicCache.get(session, 'alerts', const Duration(seconds: 30), () => _getAlerts(session));

  Future<List<AlertNote>> _getAlerts(Session session) async {
    final now = DateTime.now().toUtc();
    final notes = <({DateTime ts, AlertNote note})>[];
    void add(DateTime ts, String tag, String body) => notes.add((
      ts: ts,
      note: AlertNote(tag: tag, ago: _ago(now, ts), body: body),
    ));

    // the four sources are independent: ask for them all at once, not one round trip after another
    final diaryF = DiaryEntry.db.findFirstRow(session, orderBy: (t) => t.id.desc());
    final dreamF = DreamEntry.db.findFirstRow(session, orderBy: (t) => t.id.desc());
    final copF = CopLogEntry.db.find(session, orderBy: (t) => t.id.desc(), limit: 5);
    final mindF = MindService.load(session);
    await Future.wait<Object?>([diaryF, dreamF, copF, mindF]);

    final diary = await diaryF;
    if (diary != null) {
      add(
        diary.timestamp,
        'DIARY',
        "WYRD wrote today's entry. One per day, unprompted.",
      );
    }

    final dream = await dreamF;
    if (dream != null) {
      final excerpt = dream.content.length > 80
          ? '${dream.content.substring(0, 80)}…'
          : dream.content;
      add(
        dream.timestamp,
        'DREAM',
        'Idle stretch produced a dream: "$excerpt"',
      );
    }

    final cop = await copF;
    for (final e in cop) {
      add(
        e.timestamp,
        'COP',
        'Self-modification reviewed: ${e.configKey} → ${_newValue(e.newValueJson)}. ${e.verdict}',
      );
    }

    final digest = (await mindF).digest;
    if (digest.percent >= 90) {
      final eta = digest.etaMinutes != null
          ? ' ETA ${digest.etaMinutes!.round()}m to full.'
          : '';
      notes.add((
        ts: now,
        note: AlertNote(
          tag: 'DIGEST',
          ago: 'now',
          body: 'Crossed ${digest.percent.round()}% of the topic corpus.$eta',
        ),
      ));
    }

    notes.sort((a, b) => b.ts.compareTo(a.ts));
    return notes.take(20).map((n) => n.note).toList();
  }

  /// newValueJson is JSON-encoded; show strings bare-quoted like Node's JSON.stringify did.
  static String _newValue(String raw) {
    try {
      return jsonEncode(jsonDecode(raw));
    } catch (_) {
      return raw;
    }
  }

  static String _ago(DateTime now, DateTime ts) {
    final m = (now.difference(ts).inSeconds / 60).round();
    if (m < 1) return 'just now';
    if (m < 60) return '${m}m';
    final h = (m / 60).round();
    if (h < 24) return '${h}h';
    return '${(h / 24).round()}d';
  }
}
