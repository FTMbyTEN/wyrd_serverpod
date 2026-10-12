import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/wyrd_charter.dart';

void main() {
  test('the agent charter keeps its rules: plan, ground, verify, ask before acting, report failures', () {
    final a = WyrdCharter.agent(operator: false);
    for (final rule in ['call plan first', 'verified', 'what you infer', 'propose_action', 'Never invent a', 'WHEN YOU CAN\'T COMPLETE IT', 'cannot run code']) {
      expect(a, contains(rule), reason: rule);
    }
    expect(a, isNot(contains('drone')), reason: 'the drone is only for the owner');
    expect(WyrdCharter.agent(operator: true), contains('fly the drone'));
  });

  test('chat gets the same habits in short', () {
    expect(WyrdCharter.chat, contains('lead with the answer'));
    expect(WyrdCharter.chat, contains('Never invent a tool result'));
    expect(WyrdCharter.chat, contains('explicit yes'));
  });
}
