import 'dart:math';

import '../generated/protocol.dart';

/// Server-side twin of the bridge's safety.js, applied to a whole plan before it's stored. The
/// bridge re-checks everything itself (and watches the flight), so this is the first of two
/// gates, not the only one. Keep the limits in step with drone/bridge/src/safety.js.
class DroneSafety {
  static const maxAltitudeM = 60.0;
  static const minAltitudeM = 2.0;
  static const geofenceRadiusM = 300.0;
  static const minBatteryForTakeoffPct = 50;
  static const minBatteryPct = 30;
  static const maxTelemetryAge = Duration(seconds: 10);
  static const maxSteps = 20;

  static const stepTypes = {'takeoff', 'goto', 'hold', 'rtl', 'land'};

  /// Null if [steps] may be sent to the drone in [state]; otherwise the reason it can't.
  static String? checkPlan(
    List<Map<String, dynamic>> steps,
    DroneState? state, {
    DateTime? now,
  }) {
    if (steps.isEmpty) return 'the plan has no steps';
    if (steps.length > maxSteps) {
      return 'the plan has more than $maxSteps steps';
    }
    if (state == null || !state.connected) return 'no drone is connected';
    if ((now ?? DateTime.now().toUtc()).difference(state.updatedAt) >
        maxTelemetryAge) {
      return 'no fresh telemetry from the drone';
    }
    if (state.homeLat == null || state.homeLon == null) {
      return 'the drone has no home position yet';
    }

    var airborne = state.armed;
    for (var i = 0; i < steps.length; i++) {
      final step = steps[i];
      final n = i + 1;
      final type = step['type'];
      if (type is! String || !stepTypes.contains(type)) {
        return 'step $n: unknown type "$type"';
      }

      final alt = step['altitudeM'];
      if (alt != null &&
          (alt is! num || alt < minAltitudeM || alt > maxAltitudeM)) {
        return 'step $n: altitude must be between ${minAltitudeM.round()} and ${maxAltitudeM.round()} m';
      }

      switch (type) {
        case 'takeoff':
          if (alt == null) return 'step $n: takeoff needs an altitude';
          if ((state.gpsFix ?? 0) < 3) return 'step $n: no 3D GPS fix';
          if ((state.batteryPct ?? 0) < minBatteryForTakeoffPct) {
            return 'step $n: battery below $minBatteryForTakeoffPct% for takeoff';
          }
          airborne = true;
        case 'goto':
          if (!airborne) return 'step $n: flies somewhere before taking off';
          final lat = step['lat'], lon = step['lon'];
          if (lat is! num || lon is! num || alt == null) {
            return 'step $n: goto needs lat, lon and altitude';
          }
          final d = distanceMeters(
            state.homeLat!,
            state.homeLon!,
            lat.toDouble(),
            lon.toDouble(),
          );
          if (d > geofenceRadiusM) {
            return 'step $n: waypoint is ${d.round()} m from home, outside the ${geofenceRadiusM.round()} m fence';
          }
        case 'land':
        case 'rtl':
          airborne = false;
      }
    }
    if (airborne) return 'the plan never lands or returns home';
    if (state.armed && (state.batteryPct ?? 100) < minBatteryPct) {
      return 'battery below $minBatteryPct%';
    }
    return null;
  }

  static double distanceMeters(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371000.0;
    double rad(double d) => d * pi / 180;
    final dLat = rad(lat2 - lat1), dLon = rad(lon2 - lon1);
    final h =
        pow(sin(dLat / 2), 2) +
        cos(rad(lat1)) * cos(rad(lat2)) * pow(sin(dLon / 2), 2);
    return 2 * r * asin(min(1.0, sqrt(h)));
  }

  /// The point [northM]/[eastM] metres from (lat, lon) -- flat-earth, fine at fence scale.
  static ({double lat, double lon}) offset(
    double lat,
    double lon,
    double northM,
    double eastM,
  ) {
    const r = 6371000.0;
    return (
      lat: lat + (northM / r) * (180 / pi),
      lon: lon + (eastM / (r * cos(lat * pi / 180))) * (180 / pi),
    );
  }
}
