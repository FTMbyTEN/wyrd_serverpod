import 'package:test/test.dart';
import 'package:wyrd_server/src/rewards/reward_math.dart';

void main() {
  group('split (owner decision D9: 167 bp, cash rounded down)', () {
    test('test 1: basis 30,000 gives G₦29,499 game + ₦501 cash', () {
      final s = RewardMath.split(30000, 167);
      expect(s.gameReward, 29499);
      expect(s.cashKobo, 50100);
      expect(s.gameReward + s.cashNaira, 30000, reason: 'the two parts add up to the basis, nothing extra');
    });
    test('cash always whole naira, rounded down', () {
      expect(RewardMath.split(100, 167).cashKobo, 100); // 1.67 -> 1
      expect(RewardMath.split(59, 167).cashKobo, 0); // 0.98 -> 0
      expect(RewardMath.split(50000, 167).cashKobo, 83500);
    });
    test('the reward line shown before acceptance', () {
      final s = RewardMath.split(30000, 167);
      expect(RewardMath.rewardLine(s.gameReward, s.cashKobo), 'Reward: G₦29,499 game currency + ₦501 cash reward.');
    });
    test('rejects nonsense', () {
      expect(() => RewardMath.split(0, 167), throwsArgumentError);
      expect(() => RewardMath.split(1000, 10001), throwsArgumentError);
    });
  });

  test('test 2: ordinary jobs never carry cash', () {
    for (final b in [1, 500, 30000, 1000000]) {
      expect(RewardMath.ordinary(b).cashKobo, 0);
      expect(RewardMath.ordinary(b).gameReward, b);
    }
    expect(RewardMath.rewardLine(500, 0), 'Reward: G₦500 game currency.');
  });

  group('test 3: capacity', () {
    test('₦50,000 backs 33 rewards of ₦835 with a ₦650 fee allowance each; the 34th does not fit', () {
      // ₦835 is the 167 bp cash on a basis of 50,000; ₦835 + ₦650 = ₦1,485 reserved per acceptance
      expect(RewardMath.split(50000, 167).cashKobo, 83500);
      expect(RewardMath.capacity(5000000, 83500, 65000), 33);
      final left = 5000000 - 33 * (83500 + 65000);
      expect(left < 83500 + 65000, isTrue, reason: 'what is left cannot back a 34th');
    });
    test('without a fee allowance the same fund backs more', () {
      expect(RewardMath.capacity(5000000, 83500, 0), 59);
    });
    test('an empty or negative fund backs none', () {
      expect(RewardMath.capacity(0, 83500, 65000), 0);
      expect(RewardMath.capacity(-1, 83500, 65000), 0);
    });
  });

  group('test 13: levy rounding, small payments, splitting', () {
    test('the example: G₦1,000 -> G₦995 to the recipient, G₦5 to the treasury', () {
      expect(RewardMath.levy(1000), (5, 995));
    });
    test('no hidden minimum: under G₦200 pays no levy', () {
      expect(RewardMath.levy(199), (0, 199));
      expect(RewardMath.levy(1), (0, 1));
      expect(RewardMath.levy(200), (1, 199));
    });
    test('sender debit = recipient credit + levy, always', () {
      for (var g = 1; g <= 5000; g++) {
        final (fee, net) = RewardMath.levy(g);
        expect(fee + net, g);
        expect(fee >= 0 && net >= 0, isTrue);
      }
    });
    test('splitting a payment can only lower the levy (rounding down), never raise it', () {
      for (final g in [1000, 1999, 4321, 99999]) {
        final whole = RewardMath.levy(g).$1;
        final halves = RewardMath.levy(g ~/ 2).$1 + RewardMath.levy(g - g ~/ 2).$1;
        expect(halves <= whole, isTrue);
        expect(whole - halves <= 1, isTrue, reason: 'splitting saves at most one naira of rounding');
      }
    });
  });

  group('payout states', () {
    test('a timeout (unknown) is not a failure and cannot be resubmitted as new', () {
      expect(PayoutState.isInFlight(PayoutState.unknown), isTrue);
      expect(PayoutState.isFinal(PayoutState.unknown), isFalse);
      expect(PayoutState.canMove(PayoutState.unknown, PayoutState.requested), isFalse);
    });
    test('paid can only come back as returned; failed is final', () {
      expect(PayoutState.canMove(PayoutState.paid, PayoutState.failed), isFalse);
      expect(PayoutState.canMove(PayoutState.paid, PayoutState.returned), isTrue);
      expect(PayoutState.canMove(PayoutState.failed, PayoutState.paid), isFalse);
    });
    test('out-of-order: pending after paid is refused', () {
      expect(PayoutState.canMove(PayoutState.paid, PayoutState.pending), isFalse);
    });
  });
}
