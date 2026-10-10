import 'dart:async';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import 'partner_api.dart';

/// The partner API on the web server: /partner/v1/** (see PartnerApi). Plain HTTPS JSON, for partners' backends.
class PartnerRoute extends Route {
  PartnerRoute() : super(methods: {Method.get, Method.post, Method.delete});

  static String? _header(Request request, String name) {
    final v = request.headers[name];
    return v == null || v.isEmpty ? null : v.join(',');
  }

  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    final full = request.url.path;
    final i = full.indexOf('/partner/v1/');
    final path = i < 0 ? '' : full.substring(i + '/partner/v1/'.length);
    String body = '';
    if (request.method == Method.post) {
      try {
        body = await request.readAsString(maxLength: 12 * 1024 * 1024);
      } catch (_) {
        body = '\u0000too-large';
      }
    }
    final r = await PartnerApi.handle(
      session,
      method: request.method.name.toUpperCase(),
      path: path,
      query: request.url.queryParameters,
      authorization: _header(request, 'authorization'),
      idempotencyKey: _header(request, 'idempotency-key'),
      body: body == '\u0000too-large' ? 'x' * (12 * 1024 * 1024 + 1) : body,
    );
    return Response(
      r.status,
      body: Body.fromString(jsonEncode(r.body), mimeType: MimeType.json),
      headers: Headers.fromMap({
        for (final e in r.headers.entries) e.key: [e.value],
        'cache-control': ['no-store'],
      }),
    );
  }
}
