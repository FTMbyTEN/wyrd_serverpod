import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';
import 'frame/frame_stub.dart'
    if (dart.library.js_interop) 'frame/frame_web.dart';

/// What WYRD made in a reply, kept on the turn, shown under its words as in the main app's
/// InlineRun: a live app (preview_app), a chart or diagram (show_visual), a picture it drew
/// (draw_picture) or a Python program run in the browser (run_python).
class KeptCard extends StatefulWidget {
  final String kept;
  const KeptCard(this.kept, {super.key});

  static const _visual = '<!--wyrd:visual-->';
  static const _python = '<!--wyrd:python-->';
  static const _picture = '<!--wyrd:picture-->';

  @override
  State<KeptCard> createState() => _KeptCardState();
}

class _KeptCardState extends State<KeptCard> {
  double _pyHeight = 120;
  bool _run = false;

  @override
  Widget build(BuildContext context) {
    final k = widget.kept;
    final kind = k.startsWith(KeptCard._python)
        ? 'python'
        : k.startsWith(KeptCard._picture)
        ? 'picture'
        : k.startsWith(KeptCard._visual)
        ? 'visual'
        : 'app';
    var title = kind == 'app'
        ? 'App'
        : kind[0].toUpperCase() + kind.substring(1);
    var body = k;
    if (kind != 'app') {
      final rest = k.substring(k.indexOf('-->') + 3);
      final m = RegExp(r'^<!--([\s\S]*?)-->\n?').firstMatch(rest);
      if (m != null && m.group(1)!.trim().isNotEmpty)
        title = m.group(1)!.trim();
      body = m == null ? rest : rest.substring(m.end);
    }
    final key = k.hashCode.toRadixString(36);
    final tag = switch (kind) {
      'python' => 'PYTHON · RUNS IN YOUR BROWSER',
      'picture' => 'A PICTURE · DRAWN BY WYRD',
      'visual' => 'VISUAL',
      _ => 'LIVE APP · BUILT BY WYRD',
    };

    final Widget content = switch (kind) {
      'picture' => SvgPicture.string(
        body.substring(body.indexOf('<svg').clamp(0, body.length)),
        width: 560,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => const SizedBox(height: 200),
      ),
      'python' =>
        _run
            ? sandboxFrame(
                key: key,
                pythonCode: body,
                height: _pyHeight.clamp(80, 900),
                onHeight: (h) {
                  if (mounted) setState(() => _pyHeight = h + 4);
                },
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: SelectableText(
                  body,
                  style: WyrdText.mono(fontSize: 12).copyWith(height: 1.45),
                ),
              ),
      'visual' => sandboxFrame(key: key, html: body, height: 380),
      _ => sandboxFrame(key: key, html: body, height: 480),
    };

    return Container(
      margin: const EdgeInsets.only(top: 8),
      constraints: const BoxConstraints(maxWidth: 560),
      decoration: wyrdCard(radius: 12, border: WyrdColors.signal),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 9, 8, 7),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tag,
                        style: WyrdText.mono(
                          fontSize: 9.5,
                          color: WyrdColors.greenDim,
                        ).copyWith(letterSpacing: 1.6),
                      ),
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: WyrdText.mono(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (kind == 'python')
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _run = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: WyrdColors.signal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _run ? 'RUNNING' : 'RUN ▸',
                        style: WyrdText.mono(
                          fontSize: 10.5,
                          color: WyrdColors.onSignal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          content,
        ],
      ),
    );
  }
}
