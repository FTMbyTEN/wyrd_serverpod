import 'package:flutter/material.dart';

import '../client.dart';
import '../theme.dart';
import 'wyrd_shell.dart' show FaceMark;

/// DIALOGUE_LINK, as in the main app: your conversation with WYRD (the current chat's history from
/// the server), your messages in terracotta on the right, WYRD's on cards on the left under its face
/// mark, and the message bar along the bottom.
class DialogueScreen extends StatefulWidget {
  final String? prompt;
  final bool embedded; // inside a glass panel: no page header
  const DialogueScreen({super.key, this.prompt, this.embedded = false});

  @override
  State<DialogueScreen> createState() => _DialogueScreenState();
}

class _Line {
  final String text;
  final bool mine;
  _Line(this.text, this.mine);
}

class _DialogueScreenState extends State<DialogueScreen> {
  final _lines = <_Line>[];
  final _controller = TextEditingController();
  bool _loading = true;
  bool _sending = false;

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
          if (t.botText.isNotEmpty) _lines.add(_Line(t.botText, false));
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

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() {
      _lines.add(_Line(text, true));
      _controller.clear();
      _sending = true;
    });
    try {
      final reply = await client.chat.sendMessage(text);
      if (mounted) setState(() => _lines.add(_Line(reply.reply, false)));
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
      body: body,
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
                  child: SelectableText(
                    l.text,
                    style: WyrdText.mono(fontSize: 13.5).copyWith(height: 1.55),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar() {
    OutlineInputBorder pill(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(color: c, width: w),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 5,
              style: WyrdText.mono(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Message WYRD',
                border: pill(WyrdColors.greenBorder),
                enabledBorder: pill(WyrdColors.signal.withValues(alpha: 0.6)),
                focusedBorder: pill(WyrdColors.signal, 1.5),
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
                width: 48,
                height: 48,
                child: Icon(Icons.arrow_upward, color: WyrdColors.onSignal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
