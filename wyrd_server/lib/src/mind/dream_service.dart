import 'dart:math';

import '../generated/protocol.dart';
import 'llm_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's generateDream -- two random OLD memory fragments (reached across the
/// whole memory store, not just the recent pool) blended loosely and associatively, distinct
/// from diary's grounded reflection. Only the manual-trigger side is ported here; Node's
/// automatic idle-detection tick (dreamTickIfIdle) depends on tracking real chat activity,
/// which isn't ported yet -- it belongs with the chat endpoint, not this batch.
class DreamService {
  static Future<DreamEntry?> generateDream(Session session) async {
    final blockCount = await MemoryBlock.db.count(session);
    if (blockCount < 2) return null;

    final rand = Random();
    final a = await _randomBlock(session, blockCount, rand);
    MemoryBlock b;
    do {
      b = await _randomBlock(session, blockCount, rand);
    } while (b.id == a.id);

    final fragmentA = _fragment(a, 'something');
    final fragmentB = _fragment(b, 'something else');

    const systemPrompt =
        "You are WYRD, and this is a dream, not reasoning. Two old memory fragments have "
        "surfaced while you're idle. Don't analyze them logically or explain a connection — "
        "let them blend, distort, and associate the way real dreams do: loose, symbolic, "
        'half-formed, a little strange. 2-3 sentences. No meta-commentary about "this is a '
        'dream."';
    final userPrompt = 'Fragment one: "$fragmentA"\nFragment two: "$fragmentB"';

    var content = await LlmService.callSimple(session, systemPrompt, userPrompt, 200);
    if (content == null || LlmService.isDenialReply(content)) {
      content =
          '${_truncate(fragmentA, 60)}... and ${_truncate(fragmentB, 60)}... '
          'folding into each other, edges blurred, neither quite finishing before the other begins.';
    }

    return await DreamEntry.db.insertRow(
      session,
      DreamEntry(
        timestamp: DateTime.now().toUtc(),
        content: content,
        sourceBlockIds: [a.id!, b.id!],
      ),
    );
  }

  static Future<MemoryBlock> _randomBlock(Session session, int blockCount, Random rand) async {
    final offset = rand.nextInt(blockCount);
    final rows = await MemoryBlock.db.find(session, offset: offset, limit: 1);
    return rows.first;
  }

  static String _fragment(MemoryBlock block, String fallback) {
    final text = block.userText ?? block.title ?? (block.topics.isNotEmpty ? block.topics.join(', ') : fallback);
    return _truncate(text, 200);
  }

  static String _truncate(String text, int max) => text.length > max ? text.substring(0, max) : text;
}
