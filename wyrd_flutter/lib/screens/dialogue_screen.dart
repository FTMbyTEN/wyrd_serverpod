import 'package:flutter/material.dart';

import '../client.dart';
import '../customize.dart';
import '../widgets/frame/page_text_stub.dart'
    if (dart.library.js_interop) '../widgets/frame/page_text_web.dart';
import '../theme.dart';
import '../widgets/kept_card.dart';
import '../widgets/wyrd_markdown.dart';
import 'wyrd_shell.dart' show FaceMark;

/// DIALOGUE_LINK, as in the main app: your conversation with WYRD (the current chat's history from
/// the server), your messages in terracotta on the right, WYRD's on cards on the left under its face
/// mark, and the message bar along the bottom.
class DialogueScreen extends StatefulWidget {
  final String? prompt;
  final bool embedded; // inside a glass panel: no page header
  // where they are in the app (told to WYRD with each message, so it knows what "this" is)
  final String? screen;
  // the words on the page they opened Dialogue Link from, read just before it opened (a pop-up
  // hides the page beneath it from the accessibility tree)
  final String? page;
  const DialogueScreen({
    super.key,
    this.prompt,
    this.embedded = false,
    this.screen,
    this.page,
  });

  @override
  State<DialogueScreen> createState() => _DialogueScreenState();
}

/// Where they are, light or dark, and the words on their screen as they send.
String _describe(String? screen, String? page) {
  final seen = page ?? pageText();
  return '${screen ?? 'the app'}. The app is in ${WyrdColors.dark ? 'dark' : 'light'} mode.'
      '${seen.isEmpty ? '' : ' The text on their screen right now:\n$seen'}';
}

class _Line {
  final String text;
  final bool mine;
  final String?
  picture; // what WYRD made in this reply (an app, visual, picture or program), kept on the turn
  final String?
  thinking; // what WYRD thought before answering, opened from THOUGHT PROCESS
  final int? turnId; // the turn, rated with 👍 👎
  int rating = 0;
  bool showThinking = false;
  _Line(
    this.text,
    this.mine, [
    this.picture,
    this.thinking,
    this.turnId,
    int? rated,
  ]) : rating = rated ?? 0;
}

class _DialogueScreenState extends State<DialogueScreen> {
  final _lines = <_Line>[];
  final _controller = TextEditingController();
  bool _loading = true;
  bool _sending = false;
  String _mood = ''; // WYRD's mood, on the identity card

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_mood.isEmpty) {
      client.mind
          .getMind()
          .then((m) {
            if (mounted) setState(() => _mood = m.mood);
          })
          .catchError((_) {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.prompt != null) _controller.text = widget.prompt!;
    _loadHistory();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    try {
      final turns = await client.chat.getHistory(limit: 40);
      if (!mounted) return;
      setState(() {
        for (final t in turns) {
          if (t.userText.isNotEmpty) _lines.add(_Line(t.userText, true));
          if (t.botText.isNotEmpty) {
            _lines.add(
              _Line(t.botText, false, t.appHtml, t.thinking, t.id, t.rating),
            );
          }
        }
      });
    } catch (_) {
      // a new conversation, then
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _newChat() async {
    try {
      await client.chat.newChat();
      if (mounted) setState(_lines.clear);
    } catch (_) {}
  }

  String _withPage() => _describe(widget.screen, widget.page);

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() {
      _lines.add(_Line(text, true));
      _controller.clear();
      _sending = true;
    });
    try {
      final reply = await client.chat.sendMessage(
        text,
        screen: _withPage(),
      );
      final a = reply.action;
      // a change WYRD made to the app (customize_app) is applied, not shown as a card
      if (a?.type == 'customize' && a?.html != null) applyCustomize(a!.html!);
      if (reply.mind != null) _mood = reply.mind!.mood;
      if (mounted) {
        setState(
          () => _lines.add(
            _Line(
              reply.reply,
              false,
              a?.type == 'customize' ? null : a?.html,
              reply.thinking,
              reply.turnId,
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _lines.add(
            _Line("I couldn't answer just now. Try again in a moment.", false),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = _body();
    if (widget.embedded) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _newChat,
              child: Text(
                '+ NEW CHAT',
                style: WyrdText.mono(fontSize: 11, color: WyrdColors.signal),
              ),
            ),
          ),
          _identity(),
          Expanded(child: body),
        ],
      );
    }
    return Scaffold(
      backgroundColor: WyrdColors.bg,
      appBar: AppBar(
        backgroundColor: WyrdColors.barBg,
        surfaceTintColor: Colors.transparent,
        foregroundColor: WyrdColors.mint,
        titleSpacing: 0,
        title: Row(
          children: [
            Icon(Icons.forum_outlined, color: WyrdColors.signal),
            const SizedBox(width: 10),
            Text('DIALOGUE_LINK', style: WyrdText.display(fontSize: 26)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _newChat,
            child: Text(
              '+ NEW CHAT',
              style: WyrdText.mono(fontSize: 11, color: WyrdColors.signal),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _identity(),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _body() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Column(
          children: [
            Expanded(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: WyrdColors.signal,
                      ),
                    )
                  : _lines.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Say something.',
                            style: WyrdText.display(fontSize: 34),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'A private thread, just you and WYRD.\nIt remembers what you tell it.',
                            textAlign: TextAlign.center,
                            style: WyrdText.mono(
                              fontSize: 12,
                              color: WyrdColors.greenDim,
                            ).copyWith(height: 1.6),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      reverse: true,
                      padding: const EdgeInsets.all(14),
                      children: [
                        if (_sending) _thinking(),
                        for (final l in _lines.reversed) _bubble(l),
                      ],
                    ),
            ),
            _bar(),
          ],
        ),
      ),
    );
  }

  Widget _thinking() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        const FaceMark(size: 30),
        const SizedBox(width: 10),
        Text(
          'WYRD is thinking…',
          style: WyrdText.mono(fontSize: 12, color: WyrdColors.signal),
        ),
      ],
    ),
  );

  Widget _bubble(_Line l) {
    if (l.mine) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            color: WyrdColors.signal,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: SelectableText(
            l.text,
            style: WyrdText.mono(
              fontSize: 13.5,
              color: WyrdColors.onSignal,
            ).copyWith(height: 1.5),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FaceMark(size: 30),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WYRD',
                  style: WyrdText.mono(
                    fontSize: 9.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(letterSpacing: 1.6),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: WyrdColors.card,
                    border: Border.all(color: WyrdColors.greenBorder),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: WyrdMarkdown(l.text),
                ),
                if (l.picture != null && l.picture!.isNotEmpty)
                  KeptCard(l.picture!),
                _replyFooter(l),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Under a reply, as in the main app: its thought process (opened on a tap), 👍 👎 and Reply.
  Widget _replyFooter(_Line l) {
    final dim = WyrdText.mono(fontSize: 10.5, color: WyrdColors.greenDim);
    Widget tap(Widget child, VoidCallback onTap) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: child,
      ),
    );
    Future<void> rate(int v) async {
      final next = l.rating == v ? 0 : v;
      final before = l.rating;
      setState(() => l.rating = next);
      try {
        await client.chat.rate(l.turnId!, next);
      } catch (_) {
        if (mounted) setState(() => l.rating = before);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (l.thinking != null && l.thinking!.trim().isNotEmpty) ...[
          tap(
            Text(
              l.showThinking ? 'THOUGHT PROCESS ▾' : 'THOUGHT PROCESS ▸',
              style: WyrdText.mono(
                fontSize: 9.5,
                color: WyrdColors.signal,
              ).copyWith(letterSpacing: 1.6),
            ),
            () => setState(() => l.showThinking = !l.showThinking),
          ),
          if (l.showThinking)
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: WyrdColors.signal, width: 2),
                ),
              ),
              child: Text(
                l.thinking!,
                style: WyrdText.mono(
                  fontSize: 11.5,
                  color: WyrdColors.greenDim,
                ).copyWith(height: 1.5),
              ),
            ),
        ],
        Row(
          children: [
            if (l.turnId != null) ...[
              tap(
                Icon(
                  l.rating == 1 ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 14,
                  color: l.rating == 1
                      ? WyrdColors.signal
                      : WyrdColors.greenDim,
                ),
                () => rate(1),
              ),
              tap(
                Icon(
                  l.rating == -1 ? Icons.thumb_down : Icons.thumb_down_outlined,
                  size: 14,
                  color: l.rating == -1
                      ? WyrdColors.signal
                      : WyrdColors.greenDim,
                ),
                () => rate(-1),
              ),
            ],
            tap(Text('↩ Reply', style: dim), () {
              final first = l.text.split('\n').first;
              _controller.text =
                  '> ${first.length > 80 ? '${first.substring(0, 80)}…' : first}\n';
              _controller.selection = TextSelection.collapsed(
                offset: _controller.text.length,
              );
            }),
          ],
        ),
      ],
    );
  }

  /// WYRD's identity card at the top of the panel, as in the main app: its face, its mood and
  /// that the conversation is private.
  Widget _identity() => Container(
    margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: WyrdColors.glassBg,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: WyrdColors.greenBorder),
    ),
    child: Row(
      children: [
        const FaceMark(size: 44),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('WYRD', style: WyrdText.display(fontSize: 22)),
                  const SizedBox(width: 8),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: WyrdColors.signal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _mood.toUpperCase(),
                    style: WyrdText.mono(
                      fontSize: 9.5,
                      color: WyrdColors.greenDim,
                    ).copyWith(letterSpacing: 1.6),
                  ),
                ],
              ),
              Text(
                _sending
                    ? 'Your conversation · thinking…'
                    : 'Your conversation',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: WyrdText.mono(fontSize: 11, color: WyrdColors.greenDim),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: WyrdColors.greenBorder),
          ),
          child: Text(
            '🔒 PRIVATE',
            style: WyrdText.mono(
              fontSize: 9,
              color: WyrdColors.greenDim,
            ).copyWith(letterSpacing: 1.4),
          ),
        ),
      ],
    ),
  );

  Widget _bar() {
    OutlineInputBorder pill(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(color: c, width: w),
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 8),
      decoration: BoxDecoration(
        color: WyrdColors.panelBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: WyrdColors.signal.withValues(alpha: 0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 2,
              maxLines: 6,
              style: WyrdText.mono(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Message WYRD',
                hintStyle: WyrdText.mono(
                  fontSize: 14,
                  color: WyrdColors.greenDim,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(14, 12, 8, 8),
              ),
              onSubmitted: (_) => _send(),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: WyrdColors.signal,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _sending ? null : _send,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.arrow_upward, color: WyrdColors.onSignal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
