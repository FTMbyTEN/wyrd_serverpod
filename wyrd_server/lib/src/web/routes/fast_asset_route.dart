import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

/// Serves one large static file compressed and cacheable. The app's graphics engine
/// (canvaskit.wasm, ~8 MB) was sent uncompressed with `max-age=0` -- the edge proxy only
/// compresses text -- so every visit re-downloaded it before anything could draw. Here it is
/// gzipped once at startup (~3 MB) and browsers keep it for [maxAge].
class CompressedAssetRoute extends Route {
  CompressedAssetRoute(this.file, {required this.mimeType, this.maxAge = const Duration(days: 7)})
      : super(methods: {Method.get, Method.head});

  final File file;
  final MimeType mimeType;
  final Duration maxAge;

  Uint8List? _raw;
  Uint8List? _gzip;
  String? _etag;

  void _load() {
    if (_raw != null) return;
    _raw = file.readAsBytesSync();
    _gzip = Uint8List.fromList(GZipCodec(level: 9).encode(_raw!));
    _etag = '"${file.statSync().modified.millisecondsSinceEpoch.toRadixString(16)}-${_raw!.length.toRadixString(16)}"';
  }

  @override
  FutureOr<Result> handleCall(Session session, Request request) {
    _load();
    // The edge proxy doesn't pass the browser's Accept-Encoding on, and every browser that can run
    // WebAssembly accepts gzip -- so send gzip unless a client explicitly asks for identity only.
    final accept = (request.headers['accept-encoding'] ?? const <String>[]).join(',');
    final acceptsGzip = accept.isEmpty || accept.contains('gzip') || accept.contains('*');
    final ifNoneMatch = (request.headers['if-none-match'] ?? const <String>[]).join(',');
    final headers = <String, Iterable<String>>{
      'cache-control': ['public, max-age=${maxAge.inSeconds}'],
      'etag': [_etag!],
      'vary': ['accept-encoding'],
    };
    if (ifNoneMatch.contains(_etag!)) {
      return Response(304, headers: Headers.fromMap(headers));
    }
    final bytes = acceptsGzip ? _gzip! : _raw!;
    if (acceptsGzip) headers['content-encoding'] = ['gzip'];
    return Response.ok(body: Body.fromData(bytes, mimeType: mimeType), headers: Headers.fromMap(headers));
  }
}

/// Cache headers for the web app: files whose names carry a content hash (the JS bundles under
/// /_expo/static and hashed fonts/images under /assets) never change, so browsers may keep them
/// for a year; everything else (index.html) is revalidated each time so updates show at once.
CacheControlHeader? appCacheControl(Request request, dynamic fileInfo) {
  final path = request.url.path;
  final hashed = path.contains('/_expo/static/') || RegExp(r'\.[0-9a-f]{16,}\.[a-z0-9]+$').hasMatch(path);
  if (hashed) return CacheControlHeader(publicCache: true, maxAge: const Duration(days: 365).inSeconds, immutable: true);
  if (RegExp(r'\.(png|ico|json|webmanifest)$').hasMatch(path)) {
    return CacheControlHeader(publicCache: true, maxAge: const Duration(days: 1).inSeconds);
  }
  return CacheControlHeader(privateCache: true, noCache: true);
}
