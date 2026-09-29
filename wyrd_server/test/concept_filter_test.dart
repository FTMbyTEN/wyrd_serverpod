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
}
