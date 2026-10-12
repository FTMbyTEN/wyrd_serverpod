import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/shared_memory.dart';

import 'test_tools/serverpod_test_tools.dart';

/// One memory of each person, shared by chat, the task agent and the city.
void main() {
  withServerpod('Given the shared memory', (sessionBuilder, endpoints) {
    final user = UuidValue.fromString('77777777-7777-4777-8777-777777777777');

    test(
      'what chat keeps, a task finished and a mission done all show in one view; forget removes',
      () async {
        final s = sessionBuilder.build();

        // chat: told on purpose, and said again (kept once)
        await MemoryTools.use(s, user, 'remember', {
          'fact': 'Their sister Adaeze turns 30 on 4 November 2026',
        });
        await MemoryTools.use(s, user, 'remember', {
          'fact': 'Their sister Adaeze turns 30 on 4 November 2026',
        });

        // the task agent: a recurring task's latest run replaces the one before
        for (final gist in ['gold at 4012', 'gold at 3971']) {
          await SharedMemory.remember(
            s,
            user,
            'Task "watch gold": $gist',
            category: SharedMemory.task,
            key: 'Task "watch gold"',
          );
        }

        // the city
        await SharedMemory.remember(
          s,
          user,
          'In NAIJA 2099 they completed the mission "Ojuelegba run"',
          category: SharedMemory.city,
        );
        await WorldCitizen.db.insertRow(
          s,
          WorldCitizen(
            authUserId: user,
            standing: 12,
            missionsDone: 1,
            record: 'Helped a trader push her cart.',
            updatedAt: DateTime.now().toUtc(),
          ),
        );
        await AgentTask.db.insertRow(
          s,
          AgentTask(
            authUserId: user,
            goal: 'watch gold',
            everyHours: 6,
            status: 'scheduled',
            stepsUsed: 0,
            maxSteps: 12,
            runs: 1,
            unread: false,
            nextRunAt: DateTime.now().toUtc().add(const Duration(hours: 5)),
            createdAt: DateTime.now().toUtc(),
            updatedAt: DateTime.now().toUtc(),
          ),
        );

        final m = await SharedMemory.about(s, user);
        expect(
          m.facts.where((f) => f.contains('Adaeze')).length,
          1,
          reason: 'kept once',
        );
        expect(m.events.where((e) => e.contains('watch gold')).length, 1);
        expect(m.events.any((e) => e.contains('3971')), isTrue);
        expect(m.events.any((e) => e.contains('Ojuelegba run')), isTrue);
        expect(m.tasks.single, contains('runs again'));
        expect(m.city, contains('standing 12/100'));
        expect(m.city, contains('trader'));
        final block = m.lines();
        expect(block, contains('Adaeze'));
        expect(block, contains('NAIJA 2099'));

        final none = await MemoryTools.use(s, user, 'forget', {
          'what': 'my brother\'s car',
        });
        expect(none, startsWith('Nothing'));
        // how people say it: not the fact's own words
        final gone = await SharedMemory.forget(s, user, "my sister's birthday");
        expect(gone.single, contains('Adaeze'));
        expect(
          (await SharedMemory.about(s, user)).facts.any(
            (f) => f.contains('Adaeze'),
          ),
          isFalse,
        );
      },
    );
  });
}
