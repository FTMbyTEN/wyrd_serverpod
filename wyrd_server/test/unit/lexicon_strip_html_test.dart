import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/lexicon_service.dart';

void main() {
  test('Wiktionary HTML definitions become plain text', () {
    const html = '<span class="usage-label-sense"></span> Any <a rel="mw:WikiLink" href="/wiki/place">place</a> '
        'of <i>shelter</i> &amp; safety &quot;here&quot;.';
    expect(LexiconService.stripHtml(html), 'Any place of shelter & safety "here".');
  });
}
