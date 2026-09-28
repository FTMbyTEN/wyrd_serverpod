import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/drone/drone_config.dart';
import 'package:wyrd_server/src/drone/drone_safety.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

const token = 'test-bridge-token-0123456789';
const operatorId = '33333333-3333-4333-8333-333333333333';
const viewerId = '44444444-4444-4444-8444-444444444444';
const home = (lat: 6.5244, lon: 3.3792);

DroneState stateAt({
  bool armed = false,
  int battery = 90,
  int gpsFix = 3,
  DateTime? at,
}) => DroneState(
  droneId: 'wyrd-1',
  connected: true,
  armed: armed,
  mode: armed ? 'GUIDED' : 'STABILIZE',
  lat: home.lat,
  lon: home.lon,
  relativeAltM: armed ? 10 : 0,
  batteryPct: battery,
  gpsFix: gpsFix,
  homeLat: home.lat,
  homeLon: home.lon,
  updatedAt: at ?? DateTime.now().toUtc(),
);

DroneMission mission(String kind, List<Map<String, dynamic>> steps) {
  final now = DateTime.now().toUtc();
  return DroneMission(
    droneId: 'wyrd-1',
    kind: kind,
    instruction: kind,
    summary: kind,
    stepsJson: jsonEncode(steps),
    status: 'pending',
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  group('DroneSafety.checkPlan', () {
    final square = [
      {'type': 'takeoff', 'altitudeM': 15},
      for (final (n, e) in [(40.0, 0.0), (40.0, 40.0), (0.0, 40.0)])
        {
          'type': 'goto',
          'lat': DroneSafety.offset(home.lat, home.lon, n, e).lat,
          'lon': DroneSafety.offset(home.lat, home.lon, n, e).lon,
          'altitudeM': 15,
        },
      {'type': 'rtl'},
    ];

    test('accepts a small square that takes off first and comes home', () {
      expect(DroneSafety.checkPlan(square, stateAt()), isNull);
    });

    test('refuses waypoints outside the fence', () {
      final far = DroneSafety.offset(home.lat, home.lon, 500, 0);
      final plan = [
        {'type': 'takeoff', 'altitudeM': 10},
        {'type': 'goto', 'lat': far.lat, 'lon': far.lon, 'altitudeM': 10},
        {'type': 'rtl'},
      ];
      expect(DroneSafety.checkPlan(plan, stateAt()), contains('fence'));
    });

    test(
      'refuses plans that never come down, fly before takeoff, or climb past the ceiling',
      () {
        expect(
          DroneSafety.checkPlan([square.first], stateAt()),
          contains('never lands'),
        );
        expect(
          DroneSafety.checkPlan(square.sublist(1), stateAt()),
          contains('before taking off'),
        );
        expect(
          DroneSafety.checkPlan([
            {'type': 'takeoff', 'altitudeM': 200},
            {'type': 'land'},
          ], stateAt()),
          contains('altitude'),
        );
      },
    );

    test('refuses on stale telemetry, a weak battery, or no GPS fix', () {
      final old = DateTime.now().toUtc().subtract(const Duration(minutes: 1));
      expect(
        DroneSafety.checkPlan(square, stateAt(at: old)),
        contains('telemetry'),
      );
      expect(
        DroneSafety.checkPlan(square, stateAt(battery: 40)),
        contains('battery'),
      );
      expect(
        DroneSafety.checkPlan(square, stateAt(gpsFix: 1)),
        contains('GPS'),
      );
      expect(DroneSafety.checkPlan(square, null), contains('no drone'));
    });
  });

  withServerpod('Given the drone endpoints', (sessionBuilder, endpoints) {
    final operator = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(operatorId, {}),
    );
    final viewer = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(viewerId, {}),
    );

    setUp(() async {
      DroneConfig.bridgeTokenForTesting = token;
      DroneConfig.operatorEmailForTesting = 'Pilot@Example.com';
      final session = sessionBuilder.build();
      for (final (id, email) in [
        (operatorId, 'pilot@example.com'),
        (viewerId, 'viewer@example.com'),
      ]) {
        await session.db.unsafeExecute(
          'INSERT INTO "serverpod_auth_core_user" ("id", "createdAt", "scopeNames", "blocked") '
          'VALUES (@id, now(), \'[]\', false)',
          parameters: QueryParameters.named({'id': id}),
        );
        await session.db.unsafeExecute(
          'INSERT INTO "serverpod_auth_idp_email_account" ("authUserId", "createdAt", "email", "passwordHash") '
          'VALUES (@id, now(), @email, \'x\')',
          parameters: QueryParameters.named({'id': id, 'email': email}),
        );
      }
    });
    tearDown(() {
      DroneConfig.bridgeTokenForTesting = null;
      DroneConfig.operatorEmailForTesting = null;
    });

    test('the bridge must present the token', () async {
      expect(
        () => endpoints.droneBridge.report(
          sessionBuilder,
          'wrong-token-wrong-token',
          stateAt(),
        ),
        throwsException,
      );
      DroneConfig.bridgeTokenForTesting = null; // no secret configured at all
      expect(
        () => endpoints.droneBridge.report(sessionBuilder, '', stateAt()),
        throwsException,
      );
    });

    test(
      'reports upsert one state row per drone, visible to any signed-in user',
      () async {
        await endpoints.droneBridge.report(sessionBuilder, token, stateAt());
        await endpoints.droneBridge.report(
          sessionBuilder,
          token,
          stateAt(battery: 77),
        );
        expect(await DroneState.db.count(sessionBuilder.build()), 1);
        final seen = await endpoints.drone.getState(viewer);
        expect(seen!.batteryPct, 77);
      },
    );

    test(
      'a waiting mission is handed out once, and an abort jumps the queue',
      () async {
        final session = sessionBuilder.build();
        await DroneMission.db.insertRow(
          session,
          mission('mission', [
            {'type': 'land'},
          ]),
        );
        await DroneMission.db.insertRow(
          session,
          mission('abort', [
            {'type': 'rtl'},
          ]),
        );

        final first = await endpoints.droneBridge.report(
          sessionBuilder,
          token,
          stateAt(),
        );
        expect(first!.kind, 'abort');
        expect(first.status, 'sent');
        final second = await endpoints.droneBridge.report(
          sessionBuilder,
          token,
          stateAt(),
        );
        expect(second!.kind, 'mission');
        expect(
          await endpoints.droneBridge.report(sessionBuilder, token, stateAt()),
          isNull,
        );

        await endpoints.droneBridge.missionUpdate(
          sessionBuilder,
          token,
          second.id!,
          'done',
          null,
        );
        expect(
          (await DroneMission.db.findById(session, second.id!))!.status,
          'done',
        );
      },
    );

    test('only the operator can plan or abort', () async {
      expect(await endpoints.drone.isOperator(operator), isTrue);
      expect(await endpoints.drone.isOperator(viewer), isFalse);
      expect(() => endpoints.drone.plan(viewer, 'take off'), throwsException);
      expect(() => endpoints.drone.abort(viewer), throwsException);
    });

    test(
      'planning is refused before spending AI budget when no drone is connected',
      () async {
        final result = await endpoints.drone.plan(
          operator,
          'fly a small square',
        );
        expect(result.accepted, isFalse);
        expect(result.reason, contains('no drone'));
        expect(await DroneMission.db.count(sessionBuilder.build()), 0);
      },
    );

    test(
      'abort supersedes waiting missions and queues a return home',
      () async {
        final session = sessionBuilder.build();
        final waiting = await DroneMission.db.insertRow(
          session,
          mission('mission', [
            {'type': 'land'},
          ]),
        );
        final abort = await endpoints.drone.abort(operator);
        expect(abort.kind, 'abort');
        expect(jsonDecode(abort.stepsJson), [
          {'type': 'rtl'},
        ]);
        expect(
          (await DroneMission.db.findById(session, waiting.id!))!.status,
          'aborted',
        );
      },
    );
    test('a flight the restarted bridge no longer has is closed, so it stops blocking new plans', () async {
      final session = sessionBuilder.build();
      final old = DateTime.now().toUtc().subtract(const Duration(minutes: 5));
      final lost = await DroneMission.db.insertRow(session, mission('mission', [{'type': 'land'}]).copyWith(status: 'running', updatedAt: old));
      final fresh = await DroneMission.db.insertRow(session, mission('mission', [{'type': 'land'}]).copyWith(status: 'sent'));

      // the bridge is still flying: nothing is touched
      await endpoints.droneBridge.report(sessionBuilder, token, stateAt(armed: true).copyWith(missionStatus: 'running'));
      expect((await DroneMission.db.findById(session, lost.id!))!.status, 'running');

      // the bridge reports idle: the old one is closed, the just-sent one is left alone
      await endpoints.droneBridge.report(sessionBuilder, token, stateAt().copyWith(missionStatus: 'idle'));
      final closed = (await DroneMission.db.findById(session, lost.id!))!;
      expect(closed.status, 'aborted');
      expect(closed.reason, contains('restarted'));
      expect((await DroneMission.db.findById(session, fresh.id!))!.status, 'sent');
    });
  });
}
