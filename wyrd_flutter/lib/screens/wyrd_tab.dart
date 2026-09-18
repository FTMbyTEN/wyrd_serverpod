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
    _pollTimer = Timer.periodic(const Duration(seconds: 15), (_) => _loadMind());
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
        if (_mind != null && _mind!.updatedAt != mind.updatedAt) _activitySignal++;
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
      if (mounted) setState(() => _messages.add(_ChatLine('(failed to reply: $e)', false)));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mind = _mind;
    final curPct = ((mind?.curiosity ?? 0) * 100);
    final confPct = ((mind?.confidence ?? 0) * 100);
    final digestPct = (mind?.digest.percent ?? 0);

    return Container(
      color: WyrdColors.bg,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: BrainCanvas(activitySignal: _activitySignal)),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 26),
                    decoration: BoxDecoration(
                      color: const Color(0xFF000F04).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('MOOD', style: WyrdText.mono(fontSize: 10, color: WyrdColors.greenDim).copyWith(letterSpacing: 3)),
                        Text((mind?.mood ?? '—').toUpperCase(), style: WyrdText.display(fontSize: 56, shadowRadius: 22)),
                        const SizedBox(height: 6),
                        Text('focus · ${mind?.focusTopic ?? 'nothing yet'}', style: WyrdText.mono(fontSize: 11, color: WyrdColors.greenDim)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 90,
                  child: IgnorePointer(
                    child: SizedBox(width: 112, child: HoloReadout(label: 'CURIOSITY', value: '${curPct.round()}%', pct: curPct)),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 90,
                  child: IgnorePointer(
                    child: SizedBox(width: 112, child: HoloReadout(label: 'CONFIDENCE', value: '${confPct.round()}%', pct: confPct)),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.92),
                  child: IgnorePointer(
                    child: SizedBox(width: 128, child: HoloReadout(label: 'DIGEST', value: '${digestPct.round()}%', pct: digestPct, big: true)),
                  ),
                ),
              ],
            ),
          ),
          _buildDialoguePanel(context, mind),
        ],
      ),
    );
  }

  Widget _buildDialoguePanel(BuildContext context, Mind? mind) {
    return Container(
      color: const Color(0xFF000A03).withValues(alpha: 0.92),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('LAST THOUGHT', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(
            mind?.activeGoal ?? 'still forming one.',
            style: WyrdText.mono(fontSize: 12.5, color: WyrdColors.mint),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (_messages.isNotEmpty) ...[
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: [for (final line in _messages.reversed) _buildChatBubble(line)],
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: WyrdText.mono(color: WyrdColors.mint),
                  decoration: const InputDecoration(hintText: 'Talk to WYRD…'),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 44,
                child: HoloButton(
                  label: _sending ? '···' : '>',
                  onPressed: _sending ? () {} : _send,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(_ChatLine line) {
    return Align(
      alignment: line.fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          border: Border.all(color: line.fromUser ? WyrdColors.green : WyrdColors.greenBorder),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(line.text, style: WyrdText.mono(fontSize: 12, color: line.fromUser ? WyrdColors.mintBright : WyrdColors.mint)),
      ),
    );
  }
}
