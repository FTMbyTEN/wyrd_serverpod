import 'dart:convert';

import 'package:test/test.dart';
import 'package:wyrd_server/src/partner/partner_api.dart';

import 'test_tools/serverpod_test_tools.dart';

/// The partner API (Konnectly) against a real database, with the model stubbed: keys, the staging allowance, the
/// sensitive-data guard, idempotency, conversations and deletion.
void main() {
  // a stub model: records what it was asked and answers in the shape requested
  var calls = 0;
  String? lastSystem;
  setUp(() {
    calls = 0;
    PartnerModel.call = (session, system, messages, schema, maxTokens) async {
      calls++;
      lastSystem = system;
      final props = (schema['properties'] as Map).keys;
      if (props.contains('reply')) {
        return ModelResult(
          {
            'reply': 'Your order KN-10492 is out for delivery.',
            'grounded': true,
            'handoff_needed': false,
            'handoff_reason': 'none',
            'suggested_actions': [],
          },
          900,
          40,
        );
      }
      if (props.contains('amount_kobo')) {
        return ModelResult(
          {
            'amount_kobo': 1500000,
            'account_last4': '0123454471',
            'bank': 'GTBank',
            'reference': 'TX1',
            'date': '2026-10-10',
            'looks_edited': false,
            'flags': [],
          },
          1200,
          60,
        );
      }
      return ModelResult(
        {
          'title': 'HP EliteBook 840 G5',
          'description': 'Fairly used.',
          'tags': ['laptop'],
          'suggested_category': 'electronics/laptops',
          'warnings': ['Price not stated'],
        },
        1500,
        80,
      );
    };
  });

  withServerpod('Given the partner API', (sessionBuilder, endpoints) {
    Future<ApiResponse> call(
      String key,
      String method,
      String path, {
      Map<String, dynamic>? body,
      Map<String, String> query = const {},
      String? idem,
    }) async {
      final session = sessionBuilder.build();
      return PartnerApi.handle(
        session,
        method: method,
        path: path,
        query: query,
        authorization: 'Bearer $key',
        idempotencyKey: idem,
        body: body == null ? '' : jsonEncode(body),
      );
    }

    Future<String> stagingKey({int requests = 2000}) async {
      final session = sessionBuilder.build();
      final (key, _) = await PartnerApi.issueKey(
        session,
        'konnectly',
        'test',
        'tests',
      );
      await PartnerApi.openStaging(
        session,
        'konnectly',
        requests: requests,
        note: 'test',
      );
      return key;
    }

    final order = {
      'order': {
        'id': 'KN-10492',
        'status': 'out_for_delivery',
        'eta': '2026-10-10T16:00:00Z',
      },
    };

    test('no key or a wrong key is refused', () async {
      final r = await PartnerApi.handle(
        sessionBuilder.build(),
        method: 'GET',
        path: 'status',
        query: {},
        authorization: null,
        idempotencyKey: null,
        body: '',
      );
      expect(r.status, 401);
      expect(r.body['error']['code'], 'unauthorized');
      final w = await call('kn_test_${'A' * 40}', 'GET', 'status');
      expect(w.status, 401);
    });

    test('staging that has not been paid for answers 402', () async {
      final (key, _) = await PartnerApi.issueKey(
        sessionBuilder.build(),
        'konnectly',
        'test',
        'unpaid',
      );
      final r = await call(
        key,
        'POST',
        'support/messages',
        body: {'user_ref': 'u_12345678', 'message': 'Hi'},
      );
      expect(r.status, 402);
      expect(r.body['error']['code'], 'allowance_exhausted');
    });

    test(
      'a support message gets a grounded reply in a new conversation, which can continue',
      () async {
        final key = await stagingKey();
        final r = await call(
          key,
          'POST',
          'support/messages',
          body: {
            'user_ref': 'u_12345678',
            'message': 'Where is my order?',
            'context': order,
          },
        );
        expect(r.status, 200);
        expect(r.body['reply']['text'], contains('KN-10492'));
        expect(r.body['handoff']['needed'], isFalse);
        expect(r.body['handoff']['reason'], isNull);
        expect(
          lastSystem,
          contains('out_for_delivery'),
        ); // (Konnectly's data reached the model)
        final conv = r.body['conversation_id'] as String;
        expect(conv, startsWith('conv_'));
        final again = await call(
          key,
          'POST',
          'support/messages',
          body: {
            'user_ref': 'u_12345678',
            'conversation_id': conv,
            'message': 'Thanks',
          },
        );
        expect(again.body['conversation_id'], conv);
        final history = await call(
          key,
          'GET',
          'conversations/$conv',
          query: {'user_ref': 'u_12345678'},
        );
        expect((history.body['messages'] as List).length, 4);
      },
    );

    test('another user_ref cannot read or continue a conversation', () async {
      final key = await stagingKey();
      final r = await call(
        key,
        'POST',
        'support/messages',
        body: {'user_ref': 'u_aaaaaaaa', 'message': 'Hi'},
      );
      final conv = r.body['conversation_id'];
      expect(
        (await call(
          key,
          'GET',
          'conversations/$conv',
          query: {'user_ref': 'u_bbbbbbbb'},
        )).status,
        404,
      );
      expect(
        (await call(
          key,
          'POST',
          'support/messages',
          body: {
            'user_ref': 'u_bbbbbbbb',
            'conversation_id': conv,
            'message': 'Hi',
          },
        )).status,
        404,
      );
    });

    test(
      'a BVN or a card number is refused and never reaches the model',
      () async {
        final key = await stagingKey();
        final r = await call(
          key,
          'POST',
          'support/messages',
          body: {
            'user_ref': 'u_12345678',
            'message': 'My BVN is 22123456789, please check',
          },
        );
        expect(r.status, 400);
        expect(r.body['error']['message'], contains('BVN'));
        final card = await call(
          key,
          'POST',
          'support/messages',
          body: {
            'user_ref': 'u_12345678',
            'message': 'card 4111 1111 1111 1111',
          },
        );
        expect(card.status, 400);
        expect(calls, 0);
      },
    );

    test('a phone number is not mistaken for sensitive data', () {
      expect(
        PartnerApi.sensitive('Call me on 08012345678 when you arrive'),
        isNull,
      );
      expect(PartnerApi.sensitive('my password is hunter2'), isNotNull);
    });

    test(
      'a retry with the same Idempotency-Key gets the first answer; a different body is a conflict',
      () async {
        final key = await stagingKey();
        final body = {
          'user_ref': 'u_12345678',
          'message': 'Where is my order?',
        };
        final a = await call(
          key,
          'POST',
          'support/messages',
          body: body,
          idem: 'idem-1',
        );
        final b = await call(
          key,
          'POST',
          'support/messages',
          body: body,
          idem: 'idem-1',
        );
        expect(b.body['message_id'], a.body['message_id']);
        expect(calls, 1);
        final c = await call(
          key,
          'POST',
          'support/messages',
          body: {...body, 'message': 'Something else'},
          idem: 'idem-1',
        );
        expect(c.status, 409);
      },
    );

    test('the staging allowance runs out with a 402', () async {
      final key = await stagingKey(requests: 2);
      for (var i = 0; i < 2; i++) {
        expect(
          (await call(
            key,
            'POST',
            'support/messages',
            body: {'user_ref': 'u_12345678', 'message': 'Hi $i'},
          )).status,
          200,
        );
      }
      final r = await call(
        key,
        'POST',
        'support/messages',
        body: {'user_ref': 'u_12345678', 'message': 'Hi again'},
      );
      expect(r.status, 402);
      final usage = await call(key, 'GET', 'usage');
      expect(usage.body['allowance']['left'], 0);
    });

    test('a key sent in a URL is revoked', () async {
      final key = await stagingKey();
      final r = await call(key, 'GET', 'status', query: {'key': key});
      expect(r.status, 401);
      expect((await call(key, 'GET', 'status')).status, 401);
    });

    test(
      'deleting a user removes their conversations, and the deletion can be confirmed',
      () async {
        final key = await stagingKey();
        final r = await call(
          key,
          'POST',
          'support/messages',
          body: {'user_ref': 'u_delete01', 'message': 'Hi'},
        );
        final conv = r.body['conversation_id'];
        final d = await call(key, 'DELETE', 'users/u_delete01');
        expect(d.status, 202);
        expect(
          (await call(
            key,
            'GET',
            'conversations/$conv',
            query: {'user_ref': 'u_delete01'},
          )).status,
          404,
        );
        final s = await call(key, 'GET', 'deletions/${d.body['deletion_id']}');
        expect(s.body['status'], 'done');
      },
    );

    test(
      'a receipt is read, never verified, and shows only four digits of the account',
      () async {
        final key = await stagingKey();
        final r = await call(
          key,
          'POST',
          'receipts/read',
          body: {
            'user_ref': 'u_12345678',
            'image': '/9j/${'A' * 100}',
            'expected_amount_kobo': 1500000,
            'expected_account_last4': '4471',
          },
        );
        expect(r.status, 200);
        expect(r.body['verified'], isFalse);
        expect(r.body['read']['account_last4'], '4471');
        expect(r.body['matches_expected'], isTrue);
      },
    );

    test('a listing draft comes back with its warnings and no price', () async {
      final key = await stagingKey();
      final r = await call(
        key,
        'POST',
        'listings/drafts',
        body: {
          'user_ref': 'v_12345678',
          'images': ['/9j/${'A' * 100}'],
          'notes': 'Fairly used HP laptop',
        },
      );
      expect(r.status, 200);
      expect(r.body['warnings'], contains('Price not stated'));
      expect(r.body.containsKey('price'), isFalse);
    });

    test('ten messages a minute per user, then 429', () async {
      final key = await stagingKey();
      for (var i = 0; i < 10; i++) {
        await call(
          key,
          'POST',
          'support/messages',
          body: {'user_ref': 'u_ratelim1', 'message': 'Hi $i'},
        );
      }
      final r = await call(
        key,
        'POST',
        'support/messages',
        body: {'user_ref': 'u_ratelim1', 'message': 'Hi'},
      );
      expect(r.status, 429);
      expect(r.headers['retry-after'], isNotNull);
    });
  });
}
