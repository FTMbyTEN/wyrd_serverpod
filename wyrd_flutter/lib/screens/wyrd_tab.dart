import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';

/// The main tab: WYRD's live mind state plus the chat composer. Mirrors the mobile app's
/// WYRD tab, without the brain visualization -- that's a separate visual-design pass.
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
  bool _loading = true;
  String? _error;
  final _messages = <_ChatLine>[];
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _loadMind();
  }

  Future<void> _loadMind() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final mind = await client.mind.getMind();
      setState(() => _mind = mind);
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      setState(() => _loading = false);
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
      setState(() {
        _messages.add(_ChatLine(reply.reply, false));
        _mind = reply.mind;
      });
    } catch (e) {
      setState(() => _messages.add(_ChatLine('(failed to reply: $e)', false)));
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadMind,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMindCard(context),
                const SizedBox(height: 16),
                if (_messages.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('Say something to WYRD.', textAlign: TextAlign.center),
                  ),
                for (final line in _messages) _buildChatBubble(context, line),
              ],
            ),
          ),
          _buildComposer(context),
        ],
      ),
    );
  }

  Widget _buildMindCard(BuildContext context) {
    if (_loading && _mind == null) {
      return const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
    }
    if (_error != null && _mind == null) {
      return Text('Could not load Mind: $_error');
    }
    final mind = _mind!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MOOD: ${mind.mood.toUpperCase()}', style: Theme.of(context).textTheme.titleMedium),
            if (mind.focusTopic != null) Text('Focused on "${mind.focusTopic}"'),
            const SizedBox(height: 8),
            _buildStatRow('Curiosity', mind.curiosity),
            _buildStatRow('Confidence', mind.confidence),
            const SizedBox(height: 8),
            Text('Digest: ${mind.digest.percent.round()}% (${mind.digest.answeredTopics}/${mind.digest.totalTopics} topics)'),
            Text('${mind.explorationCount} self-questions asked so far'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(label)),
          Expanded(child: LinearProgressIndicator(value: value.clamp(0, 1))),
          const SizedBox(width: 8),
          Text('${(value * 100).round()}%'),
        ],
      ),
    );
  }

  Widget _buildChatBubble(BuildContext context, _ChatLine line) {
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: line.fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: line.fromUser ? scheme.primaryContainer : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(line.text),
      ),
    );
  }

  Widget _buildComposer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Talk to WYRD…', border: OutlineInputBorder()),
              onSubmitted: (_) => _send(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _sending ? null : _send,
            icon: _sending ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
