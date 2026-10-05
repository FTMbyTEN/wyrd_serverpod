import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/world/city_charter_service.dart';
import 'package:wyrd_server/src/world/city_design_service.dart';
import 'package:wyrd_server/src/world/game_learning.dart';
import 'package:wyrd_server/src/mind/training_data_service.dart';
import 'package:wyrd_server/src/world/world_authority.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given WYRD as the Authority of the open world', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000a1');
    final asAda = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}));

    test('a newcomer starts at standing 0 with no mission', () async {
      final s = jsonDecode(await endpoints.city.status(asAda)) as Map<String, dynamic>;
      expect(s['standing'], 0);
      expect(s['rank'], 'Newcomer');
      expect(s['mission'], isNull);
      expect(s['say'], '');
    });

    test('bad input is refused', () async {
      await expectLater(endpoints.city.address(asAda, 'shout', 'hi', '{}'), throwsException);
      await expectLater(endpoints.city.address(asAda, 'speak', '', '{}'), throwsException);
      await expectLater(endpoints.city.address(asAda, 'speak', 'x' * 601, '{}'), throwsException);
    });

    test("the charter: WYRD's starting board until it writes its own, filtered by standing", () async {
      final c = jsonDecode(await endpoints.city.charter(asAda)) as Map<String, dynamic>;
      expect(c['author'], 'seed');
      expect(c['charter'], contains('WYRD'));
      final missions = (c['missions'] as List).cast<Map<String, dynamic>>();
      expect(missions, isNotEmpty);
      expect(missions.every((m) => (m['minStanding'] as int) <= 0), isTrue); // a newcomer sees only open ones
    });

    test('the design studio is for operators only; the live design is open to every player', () async {
      await expectLater(endpoints.city.designChat(asAda, 'More hawkers please'), throwsException);
      await expectLater(endpoints.city.designNotes(asAda), throwsException);
      expect(await endpoints.city.canDesign(asAda), isFalse);
      final live = jsonDecode(await endpoints.city.design(asAda)) as Map<String, dynamic>;
      expect(live['traffic'], 1.0);
      expect(live['npcLines'], isEmpty);
    });

    test('approved live proposals change the live design; rejected ones do not', () async {
      final session = sessionBuilder.build();
      Future<CityDesignNote> add(String kind, Map<String, dynamic> payload) => CityDesignNote.db.insertRow(session, CityDesignNote(
          author: 'wyrd', kind: kind, title: kind, body: kind, payload: jsonEncode(payload), status: 'proposed', createdAt: DateTime.now().toUtc()));
      final tune = await add('tuning', {'traffic': 1.4});
      final lines = await add('npc_lines', {'lines': ['Shey you dey alright?']});
      final mission = await add('mission', {'kind': 'reach', 'title': 'See the stadium side', 'brief': 'b', 'street': 'Ogunlana Drive', 'reward': 3, 'minStanding': 0});
      await CityDesignService.decide(session, tune.id!, true);
      await CityDesignService.decide(session, lines.id!, false);
      await CityDesignService.decide(session, mission.id!, true);
      final live = jsonDecode(await endpoints.city.design(asAda)) as Map<String, dynamic>;
      expect(live['traffic'], 1.4);
      expect(live['npcLines'], isEmpty);
      final board = (jsonDecode(await endpoints.city.charter(asAda))['missions'] as List).cast<Map<String, dynamic>>();
      expect(board.any((m) => m['title'] == 'See the stadium side'), isTrue);
    });

    test('learning from play needs consent; it is asked once and can be changed', () async {
      var s = jsonDecode(await endpoints.city.status(asAda)) as Map<String, dynamic>;
      expect(s['trainingOptIn'], isFalse);
      expect(s['trainingAsked'], isFalse);
      s = jsonDecode(await endpoints.city.setTraining(asAda, true)) as Map<String, dynamic>;
      expect(s['trainingOptIn'], isTrue);
      expect(s['trainingAsked'], isTrue);
      s = jsonDecode(await endpoints.city.setTraining(asAda, false)) as Map<String, dynamic>;
      expect(s['trainingOptIn'], isFalse);
    });

    test('exchanges are kept only with consent, scrubbed, and credited when they end well', () async {
      final session = sessionBuilder.build();
      expect(await GameLearning.record(session, ada, channel: 'speak', situation: '{}', said: 'hi', reply: 'Welcome to Ojuelegba.', actions: const [], allowed: false), isNull);
      final kept = await GameLearning.record(session, ada, channel: 'speak', situation: '{"street":"Itire Road"}',
          said: 'mail me at ada@example.com', reply: 'Go to Itire Road and greet three people.', actions: [{'type': 'mission', 'title': 'Greet'}], allowed: true);
      expect(kept!.said, contains('[email]'));
      expect(kept.said, isNot(contains('ada@example.com')));
      await GameLearning.missionDone(session, ada);
      final after = await GameExchange.db.findById(session, kept.id!);
      expect(after!.outcome, 'mission_done');
      expect(await GameLearning.examples(session), contains('Itire Road'));
      final stats = <String, int>{};
      final ex = await GameLearning.trainingExamples(session, (k) => stats[k] = (stats[k] ?? 0) + 1);
      expect(stats['kept.world'], 1);
      expect(stats['kept.world.ended_well'], 1);
      expect(ex.length, 2); // what worked counts twice
      expect(ex.first.messages.last.content, 'Go to Itire Road and greet three people.');
    });

    test('a character is made once, checked, and can be edited', () async {
      expect(await endpoints.city.myCharacter(asAda), 'null');
      await expectLater(endpoints.city.saveCharacter(asAda, jsonEncode({'base': 'dragon', 'name': 'Ada'})), throwsException);
      await expectLater(endpoints.city.saveCharacter(asAda, jsonEncode({'base': 'ten', 'name': 'A'})), throwsException);
      await expectLater(endpoints.city.saveCharacter(asAda, jsonEncode({'base': 'ten', 'name': 'Ada', 'neon': 0x123456})), throwsException);
      final c = jsonDecode(await endpoints.city.saveCharacter(asAda, jsonEncode({'base': 'ten', 'name': '  Ada  Lovelace ', 'height': 4, 'outfitHue': -30, 'neon': 0xff2bd6}))) as Map<String, dynamic>;
      expect(c['name'], 'Ada Lovelace');
      expect(c['height'], 1.0); // clamped
      expect(c['outfitHue'], 330.0);
      final edited = jsonDecode(await endpoints.city.saveCharacter(asAda, jsonEncode({'base': 'ten', 'name': 'Ada', 'neon': 0x00e5ff}))) as Map<String, dynamic>;
      expect(edited['name'], 'Ada');
      expect(jsonDecode(await endpoints.city.myCharacter(asAda))['neon'], 0x00e5ff);
    });

    test('without an AI key it still answers, quietly, and changes nothing', () async {
      final d = jsonDecode(await endpoints.city.address(asAda, 'speak', 'Who runs this city?', '{"street":"Ojuelegba Road"}')) as Map<String, dynamic>;
      expect(d['say'], isNotEmpty);
      expect(d['actions'], isEmpty);
      expect(d['standing'], 0);
    });
  });

  group('Decisions from the model are checked before the game sees them', () {
    test('missions need a known kind, a title and a place', () {
      expect(WorldAuthority.sanitize('give_mission', {'kind': 'steal', 'title': 'x', 'street': 'Itire Road'}), isNull);
      expect(WorldAuthority.sanitize('give_mission', {'kind': 'reach', 'title': 'Go'}), isNull); // nowhere to go
      final m = WorldAuthority.sanitize('give_mission', {'kind': 'reach', 'title': 'Go', 'street': 'Itire Road', 'reward': 99})!;
      expect(m['reward'], 10);
      expect(m['street'], 'Itire Road');
    });

    test('weather and traffic only take known values; coordinates are clamped', () {
      expect(WorldAuthority.sanitize('set_weather', {'weather': 'snow'}), isNull);
      expect(WorldAuthority.sanitize('set_weather', {'weather': 'harmattan'})!['weather'], 'harmattan');
      expect(WorldAuthority.sanitize('set_traffic', {'mode': 'rush'})!['mode'], 'rush');
      expect(WorldAuthority.sanitize('dispatch_drone', {'x': 1e9, 'z': 5})!['x'], 20000);
      expect(WorldAuthority.sanitize('dispatch_drone', {})!['toPlayer'], true);
      expect(WorldAuthority.sanitize('launch_missiles', {}), isNull);
    });

    test('long broadcasts are cut short', () {
      expect((WorldAuthority.sanitize('broadcast', {'text': 'a' * 300})!['text'] as String).length, 90);
    });

    test('missions WYRD writes for its board must be on known streets', () {
      final out = CityCharterService.clean([
        {'kind': 'reach', 'title': 'Ok', 'brief': 'b', 'street': 'Itire Road', 'reward': 3, 'minStanding': 999},
        {'kind': 'reach', 'title': 'Made up', 'brief': 'b', 'street': 'Nowhere Lane', 'reward': 3},
        {'kind': 'rob', 'title': 'No', 'brief': 'b', 'street': 'Itire Road'},
      ]);
      expect(out.length, 1);
      expect(out.single['minStanding'], 60);
      expect(out.single['id'], 'm1');
    });

    test('design proposals for live kinds are checked before they can go live', () {
      expect(CityDesignService.check('tuning', {'traffic': 9, 'crowd': 0.1}), {'traffic': 1.6, 'crowd': 0.3});
      expect(CityDesignService.check('tuning', {}), isNull);
      expect(CityDesignService.check('npc_lines', {'lines': ['How far?', '', 'x' * 200]})!['lines'], ['How far?', 'x' * 80]);
      expect(CityDesignService.check('event', {'startHour': 17, 'endHour': 19, 'traffic': 'rush'}), {'startHour': 17, 'endHour': 19, 'traffic': 'rush'});
      expect(CityDesignService.check('event', {'startHour': 17, 'endHour': 17, 'traffic': 'rush'}), isNull);
      expect(CityDesignService.check('event', {'startHour': 3, 'endHour': 5}), isNull); // does nothing
      expect(CityDesignService.check('mission', {'kind': 'greet', 'title': 'Hi', 'brief': 'b', 'street': 'Itire Road', 'reward': 2})!['street'], 'Itire Road');
    });

    test('ranks follow standing', () {
      expect(WorldAuthority.rank(-50), 'Wanted');
      expect(WorldAuthority.rank(0), 'Newcomer');
      expect(WorldAuthority.rank(35), 'Trusted citizen');
      expect(WorldAuthority.rank(80), 'Chief');
    });
  });
}
