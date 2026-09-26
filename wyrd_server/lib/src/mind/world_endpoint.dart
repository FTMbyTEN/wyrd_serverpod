import '../generated/protocol.dart';
import 'world_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/world/countries and /api/world/country/:code from server.js -- the data behind
/// the globe WYRD opens via the open_world_map tool. Public, like Node.
class WorldEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<List<WorldCountry>> getCountries(Session session) async =>
      WorldService.countries();

  /// [code] is a cca3 code (e.g. "NGA"). Returns null for an unknown code.
  Future<CountryDetail?> getCountry(Session session, String code) =>
      WorldService.country(session, code);
}
