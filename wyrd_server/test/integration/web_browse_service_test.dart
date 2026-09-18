import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/web_browse_service.dart';

void main() {
  group('Given WebBrowseService', () {
    test(
      'when opening a real public page then it returns the actual title and text via real '
      'headless Chrome',
      () async {
        final session = await WebBrowseService.openSession();
        try {
          final snap = await WebBrowseService.open(session, 'https://example.com');
          expect(snap.title, contains('Example'));
          expect(snap.text, isNotEmpty);
          expect(snap.url, contains('example.com'));
        } finally {
          await WebBrowseService.closeSession(session);
        }
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'when asked to browse to a private/internal address then it refuses',
      () async {
        final session = await WebBrowseService.openSession();
        try {
          expect(
            () => WebBrowseService.open(session, 'http://127.0.0.1:9999'),
            throwsException,
          );
        } finally {
          await WebBrowseService.closeSession(session);
        }
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
