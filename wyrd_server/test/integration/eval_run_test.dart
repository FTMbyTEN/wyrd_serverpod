import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/eval_service.dart';

import 'test_tools/serverpod_test_tools.dart';

/// A run of WYRD's test questions is kept even when the model can't be reached, and counts every
/// unanswered question as a fail (a run never looks better than it was); the dashboard is owner-only.
void main() {
  withServerpod('Given the test questions', (sessionBuilder, endpoints) {
    test('with no API key every question fails, and the run is kept', () async {
      final run = await EvalService.run(
        sessionBuilder.build(),
        UuidValue.fromString('77777777-7777-4777-8777-777777777777'),
      );
      expect(run.id, isNotNull);
      expect(run.total, EvalService.cases.length);
      expect(run.passed, 0);
      final results = jsonDecode(run.results) as List;
      expect(results.first['why'], isNotEmpty);
      expect(
        (await EvalService.recent(sessionBuilder.build())).first.id,
        run.id,
      );
    });

    test('the dashboard is refused to anyone but the owner', () async {
      final player = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          '88888888-8888-4888-8888-888888888888',
          {},
        ),
      );
      expect(() => endpoints.dashboard.get(player), throwsA(anything));
      expect(() => endpoints.dashboard.runEval(player), throwsA(anything));
    });
  });
}
