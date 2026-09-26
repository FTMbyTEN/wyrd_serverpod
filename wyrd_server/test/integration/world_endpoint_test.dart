import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given World endpoint', (sessionBuilder, endpoints) {
    test(
      'when listing countries then the full list comes back in locale-aware name order',
      () async {
        final countries = await endpoints.world.getCountries(sessionBuilder);
        expect(countries.length, greaterThan(200));
        // localeCompare order, as server.js sorted it -- accented names sit with their base letter
        expect(countries.take(3).map((c) => c.name), [
          'Afghanistan',
          'Åland Islands',
          'Albania',
        ]);
        expect(countries.firstWhere((c) => c.cca3 == 'NGA').name, 'Nigeria');
      },
    );

    test(
      'when getting a known code (any case) then static facts are returned',
      () async {
        final detail = await endpoints.world.getCountry(sessionBuilder, 'nga');
        expect(detail, isNotNull);
        expect(detail!.name, 'Nigeria');
        expect(detail.capital, 'Abuja');
        expect(detail.region, 'Africa');
        expect(detail.languages, contains('English'));
        // weather is live (Open-Meteo) and legitimately null offline, so it isn't asserted here
      },
    );

    test('when getting an unknown code then null is returned', () async {
      expect(await endpoints.world.getCountry(sessionBuilder, 'XXX'), isNull);
    });
  });
}
