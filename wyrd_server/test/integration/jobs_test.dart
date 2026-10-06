import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given jobs with real play', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000d1');
    final asAda = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}));
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;

    test('unknown jobs are refused', () async {
      expect(j(await endpoints.city.jobStart(asAda, 'bank-heist'))['error'], isNotNull);
    });

    test('a chase finished in time pays ₦3,000', () async {
      final job = j(await endpoints.city.jobStart(asAda, 'chase'));
      await Future<void>.delayed(const Duration(seconds: 4));
      final r = j(await endpoints.city.jobFinish(asAda, job['id'] as String, 0, 0, 0));
      expect(r['paid'], 3000);
      expect(r['naira'], 8000);
      // the same job can't be paid twice
      expect(j(await endpoints.city.jobFinish(asAda, job['id'] as String, 0, 0, 0))['error'], isNotNull);
    });

    test('impossible speed is refused', () async {
      final job = j(await endpoints.city.jobStart(asAda, 'delivery'));
      final r = j(await endpoints.city.jobFinish(asAda, job['id'] as String, 3000, 0, 300));
      expect(r['error'], contains('Nobody is that fast'));
    });

    test('danfo pay follows passengers, given time to board', () async {
      final job = j(await endpoints.city.jobStart(asAda, 'danfo'));
      await Future<void>.delayed(const Duration(seconds: 9));
      final r = j(await endpoints.city.jobFinish(asAda, job['id'] as String, 0, 2, 0));
      expect(r['paid'], 500);
    });
  });
}
