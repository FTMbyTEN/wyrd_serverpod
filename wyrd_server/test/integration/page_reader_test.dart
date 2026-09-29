import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/page_reader_service.dart';

void main() {
  test('HTML becomes readable text: scripts, styles and navigation dropped, entities decoded', () {
    const html = '<html><head><title>T</title><style>p{}</style><script>alert(1)</script></head>'
        '<body><nav>menu</nav><h1>Moby Dick</h1><p>Call me Ishmael &amp; more&#8230;</p><p>Second</p></body></html>';
    final text = PageReaderService.htmlToText(html);
    expect(text, contains('Moby Dick'));
    expect(text, contains('Call me Ishmael & more…'));
    expect(text, isNot(anyOf(contains('alert'), contains('menu'), contains('p{}'))));
    expect(text.split('\n'), containsAllInOrder(['## Moby Dick', 'Call me Ishmael & more…', 'Second']));
  });

  test("Gutenberg's catalogue feed yields books, not its author/subject group links", () {
    const feed = '<feed><entry><id>https://www.gutenberg.org/ebooks/authors/search.opds/?query=x</id><title>Authors</title></entry>'
        '<entry><id>https://www.gutenberg.org/ebooks/84.opds</id><title>Frankenstein; or, the modern prometheus</title>'
        '<content type="text">Mary Wollstonecraft Shelley</content></entry></feed>';
    final books = PageReaderService.parseOpds(feed);
    expect(books, hasLength(1));
    expect(books.single.id, 84);
    expect(books.single.authors.single, 'Mary Wollstonecraft Shelley');
    expect(books.single.textUrl, 'https://www.gutenberg.org/cache/epub/84/pg84.txt');
  });

  test('private and non-web addresses are refused', () async {
    for (final bad in ['http://127.0.0.1/', 'http://169.254.169.254/latest/meta-data', 'file:///etc/passwd', 'ftp://x']) {
      await expectLater(PageReaderService.read(bad), throwsA(anything), reason: bad);
    }
  });
}
