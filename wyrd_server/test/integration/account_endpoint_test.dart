import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Account endpoint', (sessionBuilder, endpoints) {
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '33333333-3333-4333-8333-333333333333',
        {},
      ),
    );

    test(
      'when exporting data for a first-time user then it returns an empty-but-real profile '
      'and conversation',
      () async {
        final export = await endpoints.account.exportData(authed);
        expect(export.visitCount, 0);
        expect(export.facts, isEmpty);
        expect(export.conversation, isEmpty);
        expect(export.email, isNull);
      },
    );

    test(
      'when sending a chat message then exporting includes it, and deleting wipes it',
      () async {
        await endpoints.chat.sendMessage(authed, 'my name is Dana');

        final export = await endpoints.account.exportData(authed);
        expect(export.conversation, hasLength(1));
        expect(export.facts.any((f) => f.text == 'Name: Dana'), isTrue);

        await endpoints.account.deleteMyData(authed);

        final afterDelete = await endpoints.account.exportData(authed);
        expect(afterDelete.conversation, isEmpty);
        expect(afterDelete.facts, isEmpty);
        expect(afterDelete.visitCount, 0);
      },
    );
  });
}
