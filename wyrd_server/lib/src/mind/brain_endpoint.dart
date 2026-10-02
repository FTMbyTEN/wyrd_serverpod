import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'brain_map_service.dart';

/// WYRD's real brain for the app to draw: its neurons, synapses and latest thoughts. Public like
/// the diary -- it is WYRD's mind, not anyone's data -- and shared from a 20-second cache.
class BrainEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<BrainMap> getMap(Session session) => BrainMapService.get(session);
}
