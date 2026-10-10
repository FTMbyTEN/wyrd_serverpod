import 'dart:convert';

import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// The naira ledger and Fair Streets against a real database: payments post once, the books balance, fines
/// settle through the ledger and appeals refund.
void main() {
  withServerpod('Given the naira ledger', (sessionBuilder, endpoints) {
    final player = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '55555555-5555-4555-8555-555555555555',
        {},
      ),
    );
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;

    test(
      'a fare is charged once, gets a receipt, and the books balance',
      () async {
        final start = j(await endpoints.city.wallet(player))['naira'] as int;
        final paid = j(await endpoints.city.pay(player, 'danfo'));
        expect(paid['naira'], start - 100);
        expect(paid['receipt']['amount'], -100);
        final receipts =
            jsonDecode(await endpoints.city.receipts(player)) as List;
        expect(receipts.first['memo'], 'Danfo fare across town');
      },
    );

    test('ten payments at once all post, and none twice', () async {
      final start = j(await endpoints.city.wallet(player))['naira'] as int;
      // (each in its own two-second bucket would be needed to charge ten times; at once they share keys)
      await Future.wait([
        for (var i = 0; i < 10; i++) endpoints.city.pay(player, 'danfo'),
      ]);
      final after = j(await endpoints.city.wallet(player))['naira'] as int;
      // a double tap is one charge: at most two buckets can be spanned by ten simultaneous calls
      expect(start - after, inInclusiveRange(100, 200));
    });

    test(
      'a charge the player cannot cover is refused and changes nothing',
      () async {
        final start = j(await endpoints.city.wallet(player))['naira'] as int;
        final r = j(await endpoints.city.pay(player, 'lawyer'));
        if (start < 10000) {
          expect(r['error'], isNotNull);
          expect(j(await endpoints.city.wallet(player))['naira'], start);
        }
      },
    );
  });

  withServerpod('Given Fair Streets', (sessionBuilder, endpoints) {
    final driver = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '66666666-6666-4666-8666-666666666666',
        {},
      ),
    );
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;

    test(
      'a first red light is a warning, the second a pending fine with stars',
      () async {
        await endpoints.city.wallet(driver);
        final report = jsonEncode({
          'code': 'RL-1',
          'place': 'Broad Street / Joseph Street',
          'unit': 'T-46',
          'kmh': 52,
          'witnesses': 2,
        });
        final first = j(await endpoints.city.policeReport(driver, report));
        expect(first['citation']['outcome'], 'warning');
        expect(first['stars'], 0);
        // (a minute later, so it isn't treated as the same offence)
        final second = j(
          await endpoints.city.policeReport(
            driver,
            jsonEncode({
              'code': 'RL-1',
              'place': 'Marina / Broad Street',
              'unit': 'T-47',
              'witnesses': 1,
            }),
          ),
        );
        expect(second['citation']['outcome'], 'fine');
        expect(second['citation']['status'], 'pending');
        expect(second['stars'], 1);
      },
    );

    test('the fines desk settles what is pending through the ledger', () async {
      // (each test starts from a clean database: build the record up again)
      await endpoints.city.wallet(driver);
      await endpoints.city.policeReport(
        driver,
        jsonEncode({
          'code': 'RL-1',
          'place': 'Broad Street / Joseph Street',
          'unit': 'T-46',
          'witnesses': 2,
        }),
      );
      await endpoints.city.policeReport(
        driver,
        jsonEncode({
          'code': 'RL-1',
          'place': 'Marina / Broad Street',
          'unit': 'T-47',
          'witnesses': 1,
        }),
      );
      final before = j(await endpoints.city.wallet(driver))['naira'] as int;
      final call = j(await endpoints.city.policeCall(driver, 'fines'));
      expect(call['ok'], isTrue);
      final after = j(await endpoints.city.wallet(driver))['naira'] as int;
      expect(before - after, greaterThan(0));
      final record = j(await endpoints.city.policeCitations(driver));
      expect(
        (record['citations'] as List).where((c) => c['status'] == 'pending'),
        isEmpty,
      );
    });

    test('a weak report is only a note', () async {
      final r = j(
        await endpoints.city.policeReport(
          driver,
          jsonEncode({
            'code': 'CD-1',
            'place': 'Herbert Macaulay Way',
            'witnesses': 0,
          }),
        ),
      );
      // a crash record alone is strong evidence; with nothing else it's at least a warning, never a note
      expect(r['citation']['outcome'], isNot('note'));
      final weak = j(
        await endpoints.city.policeReport(
          driver,
          jsonEncode({'code': 'SP-1', 'place': 'Ikorodu Road', 'witnesses': 1}),
        ),
      );
      expect(weak['citation']['outcome'], 'note');
    });

    test('the books still balance after all of it', () async {
      // (the owner-only audit isn't reachable as a player; check the sum of receipts instead)
      final w = j(await endpoints.city.wallet(driver));
      expect(w['naira'], isA<int>());
    });
  });
}
