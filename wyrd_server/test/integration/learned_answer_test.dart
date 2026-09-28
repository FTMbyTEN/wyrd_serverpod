import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/learned_answer_service.dart';
import 'package:wyrd_server/src/mind/topic_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given recycle-as-learning', (sessionBuilder, endpoints) {
    const aliceId = '99999999-9999-4999-8999-999999999991';
    const bobId = '99999999-9999-4999-8999-999999999992';
    final alice = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(aliceId, {}));

    LearnedAnswer answer({String? owner, double score = 0.5}) {
      final now = DateTime.now().toUtc();
      return LearnedAnswer(
        authUserId: owner == null ? null : UuidValue.fromString(owner),
        question: 'What is entropy?',
        intent: 'what',
        topics: ['entropy'],
        answer: 'Entropy is a measure of disorder: how many ways a system can be arranged.',
        score: score,
        uses: 0,
        version: 1,
        retired: false,
        createdAt: now,
        updatedAt: now,
      );
    }

    test('only general questions are learnable', () {
      bool l(String t) => LearnedAnswerService.isLearnable(t, TopicService.extractTopics(t));
      expect(l('What is entropy?'), isTrue);
      expect(l('How does photosynthesis work?'), isTrue);
      expect(l('What is my name?'), isFalse); // personal
      expect(l("What's the weather today?"), isFalse); // time-sensitive
      expect(l('And what about it?'), isFalse); // leans on the conversation
      expect(l('I like entropy'), isFalse); // not a question
    });

    test('a learned answer is reused without the AI, and feedback trains it', () async {
      final session = sessionBuilder.build();
      final a = await LearnedAnswer.db.insertRow(session, answer());

      // no AI key in tests: WYRD answers from what it learned instead of a template
      final r1 = await endpoints.chat.sendMessage(alice, 'What is entropy?');
      expect(r1.reply, startsWith('Entropy is a measure of disorder'));
      expect(r1.fromMemory, isTrue);
      expect((await LearnedAnswer.db.findById(session, a.id!))!.uses, 1);

      // carrying on is a quiet vote of confidence
      await endpoints.chat.sendMessage(alice, 'Interesting, thanks');
      expect((await LearnedAnswer.db.findById(session, a.id!))!.score, closeTo(0.7, 1e-9));

      // ask again, then correct it: the answer loses standing and retires
      await endpoints.chat.sendMessage(alice, 'What is entropy?');
      await endpoints.chat.sendMessage(alice, "No, that's wrong");
      final after = (await LearnedAnswer.db.findById(session, a.id!))!;
      expect(after.score, lessThan(0));
      expect(after.retired, isTrue);

      // retired: it's no longer given out
      final r2 = await endpoints.chat.sendMessage(alice, 'What is entropy?');
      expect(r2.fromMemory, isNot(isTrue));
    });

    test('fresh answers are learned, relearned as new versions, and personal ones stay private', () async {
      final session = sessionBuilder.build();
      final me = UuidValue.fromString(aliceId);
      final topics = TopicService.extractTopics('What is a nebula?');

      await LearnedAnswerService.learn(session, me, 'What is a nebula?', topics, 'A nebula is a cloud of gas and dust in space.', userFacts: []);
      final shared = await LearnedAnswer.db.findFirstRow(session, where: (t) => t.intent.equals('what'));
      expect(shared!.authUserId, isNull);

      // retire it, then a fresh answer replaces it as version 2
      await LearnedAnswer.db.updateRow(session, shared.copyWith(retired: true, score: -1));
      await LearnedAnswerService.learn(session, me, 'What is a nebula?', topics, 'A nebula is an interstellar cloud of dust, hydrogen and helium.', userFacts: []);
      final v2 = (await LearnedAnswer.db.findById(session, shared.id!))!;
      expect(v2.version, 2);
      expect(v2.retired, isFalse);
      expect(v2.answer, contains('interstellar'));

      // an answer that names the asker is kept for them only
      final t2 = TopicService.extractTopics('What is a quasar?');
      await LearnedAnswerService.learn(session, me, 'What is a quasar?', t2, 'Great question, Adebisi! A quasar is an extremely bright galactic core.',
          userFacts: ["The user's name is Adebisi"]);
      final private = await LearnedAnswer.db.findFirstRow(session, where: (t) => t.answer.like('%quasar%'));
      expect(private!.authUserId, me);
      final forBob = await LearnedAnswerService.recall(session, UuidValue.fromString(bobId), 'What is a quasar?', t2);
      expect(forBob, isNull);
      final forAlice = await LearnedAnswerService.recall(session, me, 'What is a quasar?', t2);
      expect(forAlice, isNotNull);

      final stats = await endpoints.growth.getLearning(sessionBuilder);
      expect(stats.answers, 2);
      expect(stats.improved, 1);
    });
  });
}
