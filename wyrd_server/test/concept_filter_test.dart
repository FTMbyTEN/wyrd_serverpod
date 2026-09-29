import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/concept_filter.dart';

void main() {
  test('inflected forms of dictionary words are not mistaken for names', () {
    const known = {'fear', 'rise', 'stop', 'carry', 'happy', 'quick'};
    for (final w in ['feared', 'rising', 'stopped', 'carried', 'happily', 'quickly']) {
      expect(ConceptFilter.inflectedKnown(w, known), isTrue, reason: w);
    }
    for (final w in ['nvidia', 'kubernetes', 'beijing', 'reddit']) {
      expect(ConceptFilter.inflectedKnown(w, known), isFalse, reason: w);
    }
  });

  test('names are learned from how words are written in running text, not from headlines', () {
    final names = ConceptFilter.learnNames([
      'Shares of Nvidia rose after the results, and analysts said Nvidia would keep growing.',
      'Talks in Rafah stalled again; aid groups in Rafah warned of shortages.',
      'Startup Nights 2026 Is Comming Up In Zurich', // title case: proves nothing
      'She wrote that the queue was longer than ever, comming back twice.',
      'The meeting ran Longer than planned. Longer queues followed.', // sentence start doesn't count
    ]);
    expect(names, containsAll(['nvidia', 'rafah']));
    for (final w in ['comming', 'wrote', 'longer', 'startup', 'zurich']) {
      expect(names, isNot(contains(w)), reason: w);
    }
  });
}
