import 'package:flutter/material.dart';

import '../theme.dart';

/// WYRD's replies are Markdown; this draws the parts it uses: **bold**, *italic*, `code`,
/// ``` code blocks ```, # headings and - / 1. lists. Selectable, in the chat's mono type.
class WyrdMarkdown extends StatelessWidget {
  final String text;
  const WyrdMarkdown(this.text, {super.key});

  static TextStyle get _base =>
      WyrdText.mono(fontSize: 13.5).copyWith(height: 1.55);

  static final _inline = RegExp(
    r'\*\*(.+?)\*\*|`([^`]+)`|(?<![\w*])\*(?!\s)(.+?)(?<!\s)\*(?![\w*])',
  );

  static List<InlineSpan> _spans(String s, TextStyle style) {
    final out = <InlineSpan>[];
    var at = 0;
    for (final m in _inline.allMatches(s)) {
      if (m.start > at) out.add(TextSpan(text: s.substring(at, m.start)));
      if (m.group(1) != null) {
        out.add(
          TextSpan(
            text: m.group(1),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        );
      } else if (m.group(2) != null) {
        out.add(
          TextSpan(
            text: m.group(2),
            style: TextStyle(
              color: WyrdColors.signal,
              backgroundColor: WyrdColors.signal.withValues(alpha: 0.08),
            ),
          ),
        );
      } else {
        out.add(
          TextSpan(
            text: m.group(3),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      }
      at = m.end;
    }
    if (at < s.length) out.add(TextSpan(text: s.substring(at)));
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final blocks = <Widget>[];
    final lines = text.replaceAll('\r', '').split('\n');
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.trimLeft().startsWith('```')) {
        final code = <String>[];
        for (
          i++;
          i < lines.length && !lines[i].trimLeft().startsWith('```');
          i++
        ) {
          code.add(lines[i]);
        }
        blocks.add(
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: WyrdColors.signal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: WyrdColors.greenBorder),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                code.join('\n'),
                style: _base.copyWith(fontSize: 12.5, height: 1.45),
              ),
            ),
          ),
        );
        continue;
      }
      if (line.trim().isEmpty) {
        blocks.add(const SizedBox(height: 8));
        continue;
      }
      final h = RegExp(r'^(#{1,4})\s+(.*)$').firstMatch(line);
      if (h != null) {
        final style = _base.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: h.group(1)!.length <= 2 ? 15.5 : 14,
        );
        blocks.add(
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 2),
            child: SelectableText.rich(
              TextSpan(style: style, children: _spans(h.group(2)!, style)),
            ),
          ),
        );
        continue;
      }
      final li = RegExp(r'^(\s*)([-*•]|\d+[.)])\s+(.*)$').firstMatch(line);
      if (li != null) {
        final marker = RegExp(r'\d').hasMatch(li.group(2)!)
            ? li.group(2)!
            : '•';
        blocks.add(
          Padding(
            padding: EdgeInsets.only(
              left: 4.0 + li.group(1)!.length * 6,
              top: 1,
              bottom: 1,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    marker,
                    style: _base.copyWith(color: WyrdColors.signal),
                  ),
                ),
                Expanded(
                  child: SelectableText.rich(
                    TextSpan(
                      style: _base,
                      children: _spans(li.group(3)!, _base),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        continue;
      }
      blocks.add(
        SelectableText.rich(
          TextSpan(style: _base, children: _spans(line, _base)),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks,
    );
  }
}
