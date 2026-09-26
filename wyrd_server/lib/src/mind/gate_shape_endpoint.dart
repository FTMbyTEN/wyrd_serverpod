import '../generated/protocol.dart';
import 'gate_shape_service.dart';
import 'rate_limiter.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/gate-vortex/shape from server.js. Public (the gate is shown before sign-in), so it's
/// rate limited per caller like Node, since each call can cost an LLM request.
class GateShapeEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<GateShape> next(Session session) async {
    // Behind Serverpod Cloud's load balancer the socket address is the proxy's, so prefer the
    // client address it forwards.
    final request = session.request;
    final forwarded = request?.headers.xForwardedFor?.addresses;
    final caller = forwarded != null && forwarded.isNotEmpty
        ? forwarded.first
        : request?.connectionInfo.remote.address.toString() ?? 'unknown';
    if (RateLimiter.isLimited(
      'gate-shape:$caller',
      8,
      const Duration(minutes: 1),
    )) {
      throw Exception('slow down');
    }
    return GateShapeService.next(session);
  }
}
