import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/world/story_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the Tomato Emergency', (sessionBuilder, endpoints) {
    Map<String, dynamic> j(String s) => jsonDecode(s) as Map<String, dynamic>;
    TestSessionBuilder as(String id) => sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(id, {}));
    final ada = as('00000000-0000-4000-8000-0000000000e1');
    final ben = as('00000000-0000-4000-8000-0000000000e2');
    final chi = as('00000000-0000-4000-8000-0000000000e3');
    final dayo = as('00000000-0000-4000-8000-0000000000e4');

    test('the journeys take real time: a step straight after the last is refused', () async {
      StoryService.noWaitsForTesting = false;
      expect(j(await endpoints.city.storyAct(dayo, 'tomato', 'accept'))['ok'], isTrue);
      expect(j(await endpoints.city.storyAct(dayo, 'tomato', 'route:union'))['ok'], isTrue);
      expect(j(await endpoints.city.storyAct(dayo, 'tomato', 'union:pay'))['error'], contains('that fast'));
    });

    test('through the union, sold fairly: costs the levy, pays well, and the market loves you', () async {
      StoryService.noWaitsForTesting = true;
      for (final move in ['accept', 'route:union', 'union:pay', 'arrive']) {
        expect(j(await endpoints.city.storyAct(ada, 'tomato', move))['ok'], isTrue, reason: move);
      }
      final r = j(await endpoints.city.storyAct(ada, 'tomato', 'sell:fair'));
      expect(r['naira'], 5000 - 3000 + 26000);
      final story = j(await endpoints.city.story(ada));
      expect(story['rep']['faction']['market'], 15);
      expect(story['rep']['faction']['nurtw'], 4);
      expect(story['rep']['district']['Lagos Island'], 10);
      expect(story['missions']['tomato']['step'], 'done');
      // finished is finished
      expect(j(await endpoints.city.storyAct(ada, 'tomato', 'accept'))['error'], isNotNull);
    });

    test('holding the stock back pays more and turns the market against you', () async {
      StoryService.noWaitsForTesting = true;
      for (final move in ['accept', 'route:union', 'union:pay', 'arrive']) {
        await endpoints.city.storyAct(ben, 'tomato', move);
      }
      final r = j(await endpoints.city.storyAct(ben, 'tomato', 'sell:hold'));
      expect(r['naira'], 5000 - 3000 + 46000);
      expect(j(await endpoints.city.story(ben))['rep']['faction']['market'], -20);
    });

    test('order, money and favours are checked', () async {
      StoryService.noWaitsForTesting = true;
      expect(j(await endpoints.city.storyAct(chi, 'tomato', 'sell:fair'))['error'], isNotNull); // not before it starts
      await endpoints.city.storyAct(chi, 'tomato', 'accept');
      await endpoints.city.storyAct(chi, 'tomato', 'route:drone');
      expect(j(await endpoints.city.storyAct(chi, 'tomato', 'drone:pay'))['error'], contains('Not enough naira')); // ₦12,000 on ₦5,000
      expect(j(await endpoints.city.storyAct(chi, 'tomato', 'union:favour'))['error'], isNotNull); // wrong branch
      expect(j(await endpoints.city.storyAct(chi, 'tomato', 'rob-the-bank'))['error'], isNotNull);
    });

    test('the next five missions each play through, and each choice changes the right standing', () async {
      StoryService.noWaitsForTesting = true;
      final eze = as('00000000-0000-4000-8000-0000000000e5');
      Future<void> go(String m, List<String> moves) async {
        for (final mv in moves) {
          final r = j(await endpoints.city.storyAct(eze, m, mv));
          expect(r['ok'], isTrue, reason: '$m $mv: ${r['error']}');
        }
      }
      await go('gridlock', ['accept', 'fix:wyrd']);
      await go('school', ['accept', 'collect', 'boat:canoe', 'arrive']);
      await go('masters', ['accept', 'how:archive', 'proof']);
      await go('water', ['accept', 'test', 'tell:faith']);
      await go('generator', ['accept', 'fix:schedule']);
      final story = j(await endpoints.city.story(eze));
      expect(story['rep']['social']['wyrd'], 10);
      expect(story['rep']['district']['Makoko'], 15);
      expect(story['rep']['faction']['archive'], 15);
      expect(story['rep']['faction']['faith'], 12);
      for (final m in ['gridlock', 'school', 'masters', 'water', 'generator']) {
        expect(story['missions'][m]['step'], 'done');
      }
      // ₦5,000 to start, +3,000 +8,000 +10,000 -1,500 +5,000 +2,000
      expect(story['naira'], 31500);
    });

    tearDownAll(() => StoryService.noWaitsForTesting = false);
  });
}
