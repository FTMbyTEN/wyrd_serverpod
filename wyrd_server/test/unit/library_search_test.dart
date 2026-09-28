import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/library_search.dart';

void main() {
  test('a language named at the end picks that language', () {
    expect(LibrarySearch.splitLanguage('Les Misérables in French'), ('Les Misérables', 'fr'));
    expect(LibrarySearch.splitLanguage('Don Quijote en español'), ('Don Quijote', 'es'));
    expect(LibrarySearch.splitLanguage('A Room in Paris'), ('A Room in Paris', null)); // not a language
    expect(LibrarySearch.scriptLanguage('紅樓夢'), 'zh');
    expect(LibrarySearch.scriptLanguage('Walden'), isNull);
  });

  test('work ids round-trip for the AI', () {
    expect(LibrarySearch.parseKey('wikisource:fr:Les Misérables'), ('wikisource', 'fr:Les Misérables'));
    expect(LibrarySearch.parseKey('gutenberg:https://www.gutenberg.org/cache/epub/1/pg1.txt')!.$1, 'gutenberg');
    expect(LibrarySearch.parseKey('file:/etc/passwd'), isNull);
  });
}
