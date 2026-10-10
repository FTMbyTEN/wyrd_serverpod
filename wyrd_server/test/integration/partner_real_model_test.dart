import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:wyrd_server/src/partner/partner_api.dart';

import 'test_tools/serverpod_test_tools.dart';

/// One real call to the model behind the partner API, to confirm the request format works end to end. Skipped
/// unless PARTNER_REAL_MODEL=1 (it spends a fraction of a cent). Set PARTNER_IMAGE to a small PNG or JPEG to also
/// try a listing draft.
void main() {
  final on = Platform.environment['PARTNER_REAL_MODEL'] == '1';
  withServerpod('Given the real model', (sessionBuilder, endpoints) {
    Future<ApiResponse> call(
      String key,
      String path,
      Map<String, dynamic> body,
    ) => PartnerApi.handle(
      sessionBuilder.build(),
      method: 'POST',
      path: path,
      query: {},
      authorization: 'Bearer $key',
      idempotencyKey: null,
      body: jsonEncode(body),
    );

    test(
      'a support message and a listing draft come back in the agreed shape',
      () async {
        final session = sessionBuilder.build();
        final (key, _) = await PartnerApi.issueKey(
          session,
          'konnectly',
          'test',
          'real-model check',
        );
        await PartnerApi.openStaging(
          session,
          'konnectly',
          note: 'real-model check',
        );

        final r = await call(key, 'support/messages', {
          'user_ref': 'u_realcheck1',
          'message': 'Where is my order and can I get a refund?',
          'context': {
            'order': {
              'id': 'KN-10492',
              'status': 'out_for_delivery',
              'eta': '2026-10-10T16:00:00Z',
              'refund_eligible': false,
            },
          },
        });
        stdout.writeln('support: ${r.status} ${jsonEncode(r.body)}');
        expect(r.status, 200);
        expect(r.body['reply']['text'], isNotEmpty);

        final pidgin = await call(key, 'support/messages', {
          'user_ref': 'u_realcheck1',
          'conversation_id': r.body['conversation_id'],
          'message': 'Abeg, when e go reach?',
          'locale': 'pcm',
        });
        stdout.writeln('pidgin: ${pidgin.status} ${jsonEncode(pidgin.body)}');
        expect(pidgin.status, 200);

        final img = Platform.environment['PARTNER_IMAGE'];
        if (img != null) {
          final l = await call(key, 'listings/drafts', {
            'user_ref': 'v_realcheck1',
            'images': [base64Encode(File(img).readAsBytesSync())],
            'notes': 'Small market kiosk, used',
          });
          stdout.writeln('listing: ${l.status} ${jsonEncode(l.body)}');
          expect(l.status, 200);
        }
      },
      skip: on
          ? false
          : 'set PARTNER_REAL_MODEL=1 to run (spends a fraction of a cent)',
    );
  });
}
