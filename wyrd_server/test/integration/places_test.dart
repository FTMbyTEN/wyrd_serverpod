import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given places you can walk into', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000c1');
    final asAda = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}));
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;

    test('every kind of place has something to do', () async {
      for (final k in ['food', 'market', 'club', 'bank', 'hospital', 'church', 'factory', 'landmark']) {
        expect((jsonDecode(await endpoints.city.placeActivities(asAda, k)) as List), isNotEmpty, reason: k);
      }
      expect(jsonDecode(await endpoints.city.placeActivities(asAda, 'moon')), isEmpty);
    });

    test('eating costs naira and heals; working pays, then waits', () async {
      final ate = j(await endpoints.city.visit(asAda, 'food', 'amala', 'Amala Shitta'));
      expect(ate['naira'], 4500);
      expect(ate['heal'], 40);
      final worked = j(await endpoints.city.visit(asAda, 'factory', 'shift', 'A factory'));
      expect(worked['naira'], 7000);
      final again = j(await endpoints.city.visit(asAda, 'factory', 'shift', 'A factory'));
      expect(again['error'], contains('Not yet'));
      expect(j(await endpoints.city.wallet(asAda))['naira'], 7000);
    });

    test("you can't do what isn't offered, or afford what you can't", () async {
      expect(j(await endpoints.city.visit(asAda, 'food', 'skydive', 'x'))['error'], isNotNull);
      final hotel = j(await endpoints.city.visit(asAda, 'hotel', 'sleep', 'Eko Hotel'));
      expect(hotel['naira'], 0); // ₦5,000 start, ₦5,000 night
      expect(j(await endpoints.city.visit(asAda, 'food', 'suya', 'x'))['error'], contains("can't afford"));
    });
  });
}
