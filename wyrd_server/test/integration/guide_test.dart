import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the first-time guide', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000e1');
    final asAda = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}));
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;

    test('a step pays its bonus once', () async {
      expect(j(await endpoints.city.wallet(asAda))['guide'], isEmpty);
      final a = j(await endpoints.city.guideMark(asAda, 'eat'));
      expect(a['paid'], 300);
      expect(a['naira'], 5300);
      final b = j(await endpoints.city.guideMark(asAda, 'eat'));
      expect(b['paid'], 0);
      expect(j(await endpoints.city.wallet(asAda))['guide'], ['eat']);
    });

    test("'home' needs a home; unknown steps refused", () async {
      expect(j(await endpoints.city.guideMark(asAda, 'home'))['error'], contains('no home'));
      expect(j(await endpoints.city.guideMark(asAda, 'fly'))['error'], isNotNull);
    });

    test('skipping marks all steps, pays nothing', () async {
      final s = j(await endpoints.city.guideSkip(asAda));
      expect((s['guide'] as List).length, 6);
      expect(s['naira'], 5000);
    });
  });
}
