import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/brain_canvas.dart';
import '../widgets/holo.dart';

/// The main tab: the brain visualization with holographic mood/curiosity/confidence/digest
/// readouts projected around it, plus a dialogue panel underneath. Ports WyrdTab.tsx.
class WyrdTab extends StatefulWidget {
  const WyrdTab({super.key});

  @override
  State<WyrdTab> createState() => _WyrdTabState();
}

class _ChatLine {
  final String text;
  final bool fromUser;
  _ChatLine(this.text, this.fromUser);
}

class _WyrdTabState extends State<WyrdTab> {
  Mind? _mind;
  int _activitySignal = 0;
  final _messages = <_ChatLine>[];
  final _controller = TextEditingController();
  bool _sending = false;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _loadMind();
    // No live event stream yet (see WyrdTab.tsx's SSE-driven useMind for the RN equivalent) --
    // poll instead, so background ticks (reasoning/self-question/feed) still visibly show up
    // as brain activity bursts even with nobody actively chatting.
    _pollTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _loadMind(),
    );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadMind() async {
    try {
      final mind = await client.mind.getMind();
      if (!mounted) return;
      setState(() {
        // A changed lastEvent means something real happened server-side (ingest/reasoning/
        // self-question/chat) since the last poll -- bump the brain's activity signal so a
        // burst renders, mirroring the RN app's useBrainActivitySignal (there driven by SSE,
        // here by polling since this app doesn't have a live event stream yet).
        if (_mind != null && _mind!.updatedAt != mind.updatedAt)
          _activitySignal++;
        _mind = mind;
      });
    } catch (_) {
      // silent -- the readouts just keep showing the last known values
    }
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() {
      _messages.add(_ChatLine(text, true));
      _controller.clear();
      _sending = true;
    });
    try {
      final reply = await client.chat.sendMessage(text);
      if (!mounted) return;
      setState(() {
        _messages.add(_ChatLine(reply.reply, false));
        _mind = reply.mind;
        _activitySignal++;
      });
    } catch (e) {
      if (mounted)
        setState(
          () => _messages.add(_ChatLine('(failed to reply: $e)', false)),
        );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mind = _mind;
    final wide = MediaQuery.of(context).size.width >= 900;
    final brain = _buildBrain(mind);
    final side = _buildSide(context, mind);
    return Container(
      color: WyrdColors.bg,
      child: wide
          // desktop: the brain on the left, the greeting and Dialogue Link on the right, as in
          // the main app
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: brain),
                SizedBox(width: 420, child: side),
              ],
            )
          : Column(
              children: [
                SizedBox(height: 300, child: brain),
                Expanded(child: side),
              ],
            ),
    );
  }

  /// WYRD's brain, its mood over it, and three vital signs.
  Widget _buildBrain(Mind? mind) {
    final curPct = (mind?.curiosity ?? 0) * 100;
    final confPct = (mind?.confidence ?? 0) * 100;
    final digestPct = (mind?.digest.percent ?? 0).toDouble();
    return Stack(
      children: [
        Positioned.fill(child: BrainCanvas(activitySignal: _activitySignal)),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'MOOD',
                style: WyrdText.mono(
                  fontSize: 10,
                  color: WyrdColors.greenDim,
                ).copyWith(letterSpacing: 3),
              ),
              Text(mind?.mood ?? '—', style: WyrdText.display(fontSize: 54)),
              Text(
                'focus · ${mind?.focusTopic ?? 'nothing yet'}',
                style: WyrdText.mono(fontSize: 11, color: WyrdColors.greenDim),
              ),
            ],
          ),
        ),
        Positioned(
          left: 14,
          right: 14,
          bottom: 14,
          child: IgnorePointer(
            child: Row(
              children: [
                Expanded(
                  child: HoloReadout(
                    label: 'CURIOSITY',
                    value: '${curPct.round()}%',
                    pct: curPct,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: HoloReadout(
                    label: 'DIGEST',
                    value: '${digestPct.round()}%',
                    pct: digestPct,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: HoloReadout(
                    label: 'CONFIDENCE',
                    value: '${confPct.round()}%',
                    pct: confPct,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get _greeting {
    final h = DateTime.now().hour;
    return h < 12
        ? 'Good morning'
        : h < 17
        ? 'Good afternoon'
        : 'Good evening';
  }

  /// The greeting, WYRD's last thought, and Dialogue Link.
  Widget _buildSide(BuildContext context, Mind? mind) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_greeting, style: WyrdText.display(fontSize: 34)),
          Text(
            'WYRD has been thinking while you were away.',
            style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: wyrdCard(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _eyebrow('LAST THOUGHT'),
                const SizedBox(height: 6),
                Text(
                  mind?.activeGoal ?? 'still forming one.',
                  style: WyrdText.mono(fontSize: 13.5).copyWith(height: 1.5),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: _buildDialogue()),
        ],
      ),
    );
  }

  Widget _eyebrow(String text) => Row(
    children: [
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
        text,
        style: WyrdText.mono(
          fontSize: 9,
          color: WyrdColors.greenDim,
        ).copyWith(letterSpacing: 1.6),
      ),
    ],
  );

  /// Dialogue Link: the conversation and the message bar.
  Widget _buildDialogue() {
    OutlineInputBorder pill(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: BorderSide(color: c, width: w),
    );
    return Container(
      decoration: wyrdCard(border: WyrdColors.signal.withValues(alpha: 0.55)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _eyebrow(
            _sending
                ? 'DIALOGUE_LINK · WYRD IS THINKING'
                : 'DIALOGUE_LINK · WYRD IS LISTENING',
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'Say something.\nIt remembers what you tell it.',
                      textAlign: TextAlign.center,
                      style: WyrdText.mono(
                        fontSize: 12,
                        color: WyrdColors.greenDim,
                      ).copyWith(height: 1.6),
                    ),
                  )
                : ListView(
                    reverse: true,
                    children: [
                      for (final line in _messages.reversed)
                        _buildChatBubble(line),
                    ],
                  ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: WyrdText.mono(),
                  decoration: InputDecoration(
                    hintText: 'Message WYRD',
                    border: pill(WyrdColors.greenBorder),
                    enabledBorder: pill(WyrdColors.greenBorder),
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
                    width: 46,
                    height: 46,
                    child: _sending
                        ? Padding(
                            padding: const EdgeInsets.all(14),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: WyrdColors.onSignal,
                            ),
                          )
                        : Icon(Icons.arrow_forward, color: WyrdColors.onSignal),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Yours on terracotta, on the right; WYRD's on sand, on the left, under its name.
  Widget _buildChatBubble(_ChatLine line) {
    final mine = line.fromUser;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        constraints: const BoxConstraints(maxWidth: 340),
        decoration: BoxDecoration(
          color: mine ? WyrdColors.signal : WyrdColors.sand,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(mine ? 18 : 4),
            bottomRight: Radius.circular(mine ? 4 : 18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!mine)
              Text(
                'WYRD',
                style: WyrdText.mono(
                  fontSize: 9,
                  color: WyrdColors.signal,
                ).copyWith(letterSpacing: 1.6),
              ),
            Text(
              line.text,
              style: WyrdText.mono(
                fontSize: 13,
                color: mine ? WyrdColors.onSignal : WyrdColors.mint,
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
