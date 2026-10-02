import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/training_data_service.dart';

ConversationTurn turn(String user, String bot, {int? rating, String? judgement}) => ConversationTurn(
      authUserId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      userText: user,
      botText: bot,
      timestamp: DateTime.utc(2026, 10, 2),
      rating: rating,
      judgement: judgement,
    );

void main() {
  const good = 'Rain forms when water vapour cools and condenses around tiny bits of dust.';
  test('a clean exchange is kept', () {
    expect(TrainingDataService.rejectReason(turn('why does it rain?', good)), isNull);
    expect(TrainingDataService.rejectReason(turn('why does it rain?', good, judgement: 'pass', rating: 1)), isNull);
  });
  test('what cannot teach the voice is dropped, with the reason', () {
    expect(TrainingDataService.rejectReason(turn('why does it rain?', good, rating: -1)), 'rated_down');
    expect(TrainingDataService.rejectReason(turn('why does it rain?', good, judgement: 'softened: x')), 'failed_judgement');
    expect(TrainingDataService.rejectReason(turn('hi', 'Hey.')), 'too_short');
    expect(TrainingDataService.rejectReason(turn('show me', 'Here:\n```py\nprint(1)\n```')), 'code');
    expect(TrainingDataService.rejectReason(turn('my name is Ada and I live in Lagos', good)), 'personal');
    expect(TrainingDataService.rejectReason(turn('use sk-ant-abcdefghijklmnopqrstu', good)), 'secret');
  });
  test('scrub removes what identifies people', () {
    final s = TrainingDataService.scrub('mail ada@example.com or call +234 803 123 4567, see https://x.io/a?token=1');
    expect(s, isNot(contains('ada@')));
    expect(s, isNot(contains('803')));
    expect(s, isNot(contains('token')));
    expect(s, contains('[email]'));
  });
}
