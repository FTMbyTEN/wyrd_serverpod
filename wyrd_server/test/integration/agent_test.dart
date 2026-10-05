import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/agent/agent_service.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given WYRD as an agent', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000a1');
    final ben = UuidValue.fromString('00000000-0000-4000-8000-0000000000b2');
    final asAda = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}));
    final asBen = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ben.uuid, {}));

    test('a task is created queued, private to its owner, and cancellable', () async {
      final t = await endpoints.agent.create(asAda, 'Compare three solar inverters for a small home', null);
      expect(t.status, 'queued');
      expect((await endpoints.agent.mine(asAda)).single.id, t.id);
      expect(await endpoints.agent.mine(asBen), isEmpty);
      await expectLater(endpoints.agent.steps(asBen, t.id!), throwsException); // not theirs
      expect((await endpoints.agent.cancel(asAda, t.id!)).status, 'cancelled');
    });

    test('limits: too-short goals, and the daily number of new tasks', () async {
      await expectLater(endpoints.agent.create(asAda, 'hi', null), throwsException);
      for (var i = 0; i < AgentService.tasksPerDay; i++) {
        await endpoints.agent.create(asBen, 'Research question number $i in some depth', null);
      }
      await expectLater(endpoints.agent.create(asBen, 'One more research question, too many', null), throwsException);
    });

    test('an action waits for approval; a no is passed back to the task and it carries on', () async {
      final t = await endpoints.agent.create(asAda, 'Find a good free course on Dart and sign me up', null);
      // as if a run paused on a proposed action
      final transcript = [
        {'role': 'user', 'content': 'Begin work on the task now.'},
        {'role': 'assistant', 'content': [{'type': 'tool_use', 'id': 'tu1', 'name': 'propose_action', 'input': {'kind': 'web_action', 'summary': 'Sign up on example.com'}}]},
      ];
      await AgentTask.db.updateRow(sessionBuilder.build(), t.copyWith(
        status: 'waiting_approval', transcript: jsonEncode(transcript),
        pendingAction: jsonEncode({'kind': 'web_action', 'summary': 'Sign up on example.com', 'toolUseId': 'tu1'}),
      ));
      await expectLater(endpoints.agent.decide(asBen, t.id!, true), throwsException); // only the owner answers
      final after = await endpoints.agent.decide(asAda, t.id!, false);
      expect(after.status, 'queued'); // it carries on at the next tick
      expect(after.pendingAction, isNull);
      final messages = jsonDecode(after.transcript!) as List;
      final answer = (messages.last['content'] as List).first as Map;
      expect(answer['tool_use_id'], 'tu1');
      expect(answer['content'], contains('said no'));
      final steps = await endpoints.agent.steps(asAda, t.id!);
      expect(steps.single.kind, 'declined');
    });
  });
}
