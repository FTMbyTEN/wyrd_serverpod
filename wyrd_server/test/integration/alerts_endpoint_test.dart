import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Alerts endpoint', (sessionBuilder, endpoints) {
    test('when nothing has happened yet then there are no alerts', () async {
      expect(await endpoints.alerts.getAlerts(sessionBuilder), isEmpty);
    });

    test(
      'when diary, dream and COP entries exist then alerts are synthesized newest first',
      () async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();
        await DiaryEntry.db.insertRow(
          session,
          DiaryEntry(
            date: '2026-09-25',
            timestamp: now.subtract(const Duration(hours: 3)),
            content: 'x',
          ),
        );
        await DreamEntry.db.insertRow(
          session,
          DreamEntry(
            timestamp: now.subtract(const Duration(minutes: 5)),
            content: 'a' * 100,
            sourceBlockIds: [],
          ),
        );
        await CopLogEntry.db.insertRow(
          session,
          CopLogEntry(
            timestamp: now.subtract(const Duration(hours: 1)),
            kind: 'config',
            configKey: 'curiosityLevel',
            oldValueJson: '"moderate"',
            newValueJson: '"high"',
            reason: 'r',
            verdict: 'Reasonable.',
          ),
        );

        final alerts = await endpoints.alerts.getAlerts(sessionBuilder);
        expect(alerts.map((a) => a.tag), ['DREAM', 'COP', 'DIARY']);
        expect(alerts[0].ago, '5m');
        expect(alerts[0].body, endsWith('…"'));
        expect(
          alerts[1].body,
          'Self-modification reviewed: curiosityLevel → "high". Reasonable.',
        );
        expect(alerts[2].ago, '3h');
      },
    );
  });
}
