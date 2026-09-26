import 'dart:convert';

import '../generated/protocol.dart';
import '../mind/llm_service.dart';
import 'drone_safety.dart';
import 'package:serverpod/serverpod.dart';

/// Turns an operator's plain-language instruction into bridge mission steps.
///
/// The model plans in metres north/east of home -- language models are unreliable at lat/lon
/// arithmetic -- and this converts to coordinates exactly. The result then goes through
/// DroneSafety before anything is stored; the model is never trusted to respect the limits.
class DronePlanner {
  static String _systemPrompt(DroneState state) =>
      'You are WYRD, the mission planner for a small quadcopter. You never fly it directly: an '
      'autopilot does, and a safety layer checks your plan. Turn the operator\'s request into a '
      'flight plan.\n\n'
      'Current drone: ${state.armed ? 'airborne/armed' : 'on the ground, disarmed'}, '
      '${state.relativeAltM?.toStringAsFixed(1) ?? '?'} m above home, battery ${state.batteryPct ?? '?'}%.\n\n'
      'Hard limits (a plan outside them is rejected, so stay well inside): altitude '
      '${DroneSafety.minAltitudeM.round()}-${DroneSafety.maxAltitudeM.round()} m above home; every waypoint '
      'within ${DroneSafety.geofenceRadiusM.round()} m of home; at most ${DroneSafety.maxSteps} steps; the plan must '
      'end with "rtl" or "land". If the drone is on the ground the first step must be takeoff.\n\n'
      'Respond with ONLY strict JSON, no markdown:\n'
      '{"summary": "one short sentence describing the flight", "steps": [ ... ]}\n'
      'Step types:\n'
      '  {"type":"takeoff","altitudeM":N}\n'
      '  {"type":"goto","northM":N,"eastM":N,"altitudeM":N}   (metres from HOME, north/east positive)\n'
      '  {"type":"hold"}  {"type":"rtl"}  {"type":"land"}\n'
      'If the request is unsafe, impossible within the limits, or not a flight request, respond '
      '{"summary":"<why not, briefly>","steps":[]}.';

  /// Returns (summary, steps in bridge format) or throws with a reason.
  static Future<({String summary, List<Map<String, dynamic>> steps})> plan(
    Session session,
    String instruction,
    DroneState state,
  ) async {
    final raw = await LlmService.callSimple(
      session,
      _systemPrompt(state),
      instruction,
      700,
      background: false,
    );
    if (raw == null) {
      throw Exception(
        'WYRD could not plan right now (no AI available or daily budget reached)',
      );
    }

    final Map<String, dynamic> parsed;
    try {
      final cleaned = raw
          .trim()
          .replaceFirst(RegExp(r'^```(?:json)?', caseSensitive: false), '')
          .replaceFirst(RegExp(r'```$'), '')
          .trim();
      parsed = jsonDecode(cleaned) as Map<String, dynamic>;
    } catch (_) {
      throw Exception('WYRD returned a plan that could not be read');
    }

    final summary = (parsed['summary'] as String? ?? '').trim();
    final rawSteps = (parsed['steps'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();
    if (rawSteps.isEmpty) {
      throw Exception(
        summary.isEmpty ? 'WYRD declined to plan that flight' : summary,
      );
    }

    final steps = [for (final s in rawSteps) _toBridgeStep(s, state)];
    return (summary: summary.isEmpty ? 'Flight plan' : summary, steps: steps);
  }

  static Map<String, dynamic> _toBridgeStep(
    Map<String, dynamic> s,
    DroneState state,
  ) {
    final type = s['type'];
    final alt = (s['altitudeM'] as num?)?.toDouble();
    switch (type) {
      case 'takeoff':
        return {'type': 'takeoff', 'altitudeM': ?alt};
      case 'goto':
        final north = (s['northM'] as num?)?.toDouble();
        final east = (s['eastM'] as num?)?.toDouble();
        if (north == null || east == null) {
          return {'type': 'goto'}; // fails the safety check with a clear reason
        }
        final p = DroneSafety.offset(
          state.homeLat!,
          state.homeLon!,
          north,
          east,
        );
        return {'type': 'goto', 'lat': p.lat, 'lon': p.lon, 'altitudeM': ?alt};
      default:
        return {'type': type};
    }
  }
}
