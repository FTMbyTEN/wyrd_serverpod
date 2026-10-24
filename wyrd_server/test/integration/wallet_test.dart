import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/world/bank.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the city wallet and homes', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000b1');
    final bola = UuidValue.fromString('00000000-0000-4000-8000-0000000000b2');
    final asAda = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}),
    );
    final asBola = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(bola.uuid, {}),
    );
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;

    test('a newcomer starts with ₦5,000 and no home', () async {
      final w = j(await endpoints.city.wallet(asAda));
      expect(w['naira'], 5000);
      expect(w['home'], isNull);
    });

    test(
      'renting a home charges the first week; one occupant per home',
      () async {
        final homes = (jsonDecode(await endpoints.city.homes(asAda)) as List)
            .cast<Map<String, dynamic>>();
        expect(homes.length, 80);
        final cheap = homes.where((h) => (h['rent'] as int) <= 5000).first;
        final w = j(
          await endpoints.city.takeHome(asAda, cheap['slug'] as String, 'rent'),
        );
        expect(
          w['naira'],
          5000 -
              (cheap['rent'] as int) -
              Bank.taxOn(cheap['rent'] as int, 'fee'),
        ); // the week's rent and the city's 2%
        expect((w['home'] as Map)['slug'], cheap['slug']);
        final taken = j(
          await endpoints.city.takeHome(
            asBola,
            cheap['slug'] as String,
            'rent',
          ),
        );
        expect(taken['error'], contains('Someone already lives here'));
        final mine = (jsonDecode(await endpoints.city.homes(asAda)) as List)
            .cast<Map<String, dynamic>>()
            .firstWhere((h) => h['slug'] == cheap['slug']);
        expect(mine['mine'], isTrue);
      },
    );

    test("you can't buy what you can't afford", () async {
      final homes = (jsonDecode(await endpoints.city.homes(asBola)) as List)
          .cast<Map<String, dynamic>>();
      final dear = homes.firstWhere((h) => h['kind'] == 'penthouse');
      final r = j(
        await endpoints.city.takeHome(asBola, dear['slug'] as String, 'own'),
      );
      expect(r['error'], contains('You need'));
      expect(j(await endpoints.city.wallet(asBola))['naira'], 5000);
    });

    test('fares are set by the server; unknown charges refused', () async {
      final maglev =
          j(await endpoints.city.pay(asBola, 'maglev'))['naira']
              as int; // fares carry the city's 2% too
      expect(maglev, 5000 - 200 - Bank.taxOn(200, 'fee'));
      expect(
        j(await endpoints.city.pay(asBola, 'danfo'))['naira'],
        maglev - 100 - Bank.taxOn(100, 'fee'),
      );
      expect(
        j(await endpoints.city.pay(asBola, 'everything'))['error'],
        isNotNull,
      );
    });

    test('a street mission pays once a day', () async {
      final first = j(await endpoints.city.missionPaid(asBola, 'st-broad'));
      expect(first['paid'], 6000);
      expect(first['naira'], 5000 + 6000 - Bank.taxOn(6000, 'mission'));
      final again = j(await endpoints.city.missionPaid(asBola, 'st-broad'));
      expect(again['paid'], 0);
      expect(again['naira'], first['naira']);
      expect(
        j(await endpoints.city.missionPaid(asBola, 'made-up'))['error'],
        isNotNull,
      );
    });
  });
}
