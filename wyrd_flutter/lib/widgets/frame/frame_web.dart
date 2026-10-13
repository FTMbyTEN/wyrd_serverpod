import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

final _registered = <String>{};

/// A sandboxed iframe (scripts only: no access to this app, its storage or its session) showing
/// [html], or running [pythonCode] in run_python.html, which reports its height back.
Widget sandboxFrame({
  required String key,
  String? html,
  String? pythonCode,
  required double height,
  void Function(double)? onHeight,
}) {
  final viewType = 'wyrd-frame-$key';
  if (_registered.add(viewType)) {
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int _) {
      final f = web.HTMLIFrameElement()
        ..setAttribute('sandbox', 'allow-scripts')
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%';
      if (pythonCode != null) {
        f.src = 'run_python.html#$key';
        f.onLoad.listen(
          (_) => f.contentWindow?.postMessage(
            {'wyrdCode': pythonCode}.jsify(),
            '*'.toJS,
          ),
        );
        web.window.onMessage.listen((e) {
          final d = e.data.dartify();
          if (d is Map && d['id'] == key && d['wyrdRunH'] is num) {
            onHeight?.call((d['wyrdRunH'] as num).toDouble());
          }
        });
      } else {
        f.srcdoc = (html ?? '').toJS;
      }
      return f;
    });
  }
  return SizedBox(
    height: height,
    child: HtmlElementView(viewType: viewType),
  );
}
