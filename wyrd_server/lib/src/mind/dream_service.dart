import 'dart:math';

import '../generated/protocol.dart';
import 'llm_service.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's dreams: while it's idle, 3-5 memories from far-apart corners of its shared knowledge
/// drift together and it dreams them as a cosmos -- the memories are the stars of the dream, and
/// the app draws each dream as their constellation (see [stars]). Only shared knowledge is used
/// (its reading, self-answers and syntheses), never anyone's chats or photos, since dreams are
/// public. One background-budgeted LLM call per dream, at most every few hours.
class DreamService {
  static const _sharedSources = {'net', 'self', 'synthesis', 'feed', 'ingest', 'curriculum'};

  /// Manual triggers are public, so they can't be used to spend the AI budget on demand.
  static const minGap = Duration(hours: 1);

  static Future<DreamEntry?> generateDream(Session session, {bool respectGap = false}) async {
    if (respectGap) {
      final last = await DreamEntry.db.findFirstRow(session, orderBy: (t) => t.id.desc());
      if (last != null && DateTime.now().toUtc().difference(last.timestamp) < minGap) return null;
    }

    final count = await MemoryBlock.db.count(session, where: (t) => t.source.inSet(_sharedSources));
    if (count < 3) return null;

    // stars from across the whole sky: one memory from each slice of history
    final rand = Random();
    final n = min(3 + rand.nextInt(3), count);
    final picked = <MemoryBlock>[];
    for (var i = 0; i < n; i++) {
      final lo = count * i ~/ n, hi = max(lo + 1, count * (i + 1) ~/ n);
      final rows = await MemoryBlock.db.find(
        session,
        where: (t) => t.source.inSet(_sharedSources),
        orderBy: (t) => t.id,
        offset: lo + rand.nextInt(hi - lo),
        limit: 1,
      );
      if (rows.isNotEmpty && picked.every((p) => p.id != rows.first.id) && _fragment(rows.first) != null) {
        picked.add(rows.first);
      }
    }
    if (picked.length < 2) return null;
    final fragments = picked.map((b) => _fragment(b)!).toList();

    const systemPrompt =
        'You are WYRD, and you are dreaming, not reasoning. A few old memories have drifted up from '
        "far-apart corners of your mind while you're idle. Dream them as a cosmos: the memories are "
        'stars and distant worlds, the pull between them is gravity, and they drift, orbit, collide '
        "and bloom into nebulae. Don't explain or analyze; let the images blend strangely and "
        'beautifully, the way dreams do, keeping a trace of each memory recognizable. 2-4 sentences, '
        'first person, present tense. No meta-commentary about this being a dream.';
    final userPrompt = [for (var i = 0; i < fragments.length; i++) 'Star ${i + 1}: "${fragments[i]}"'].join('\n');

    var content = await LlmService.callSimple(session, systemPrompt, userPrompt, 220, background: true);
    if (content == null || LlmService.isDenialReply(content)) {
      content = _templateDream(fragments, rand);
    }

    return await DreamEntry.db.insertRow(
      session,
      DreamEntry(
        timestamp: DateTime.now().toUtc(),
        content: content,
        sourceBlockIds: [for (final b in picked) b.id!],
      ),
    );
  }

  static String? _fragment(MemoryBlock b) {
    final text = switch (b.source) {
      'self' => b.question ?? b.answer,
      'synthesis' => b.insight,
      _ => b.title ?? (b.topics.isNotEmpty ? b.topics.take(4).join(', ') : null),
    };
    if (text == null || text.trim().isEmpty) return null;
    final flat = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return flat.length > 160 ? '${flat.substring(0, 159)}…' : flat;
  }

  static String _templateDream(List<String> f, Random rand) {
    String short(String s) => s.length > 60 ? '${s.substring(0, 59)}…' : s;
    const moves = ['drifts into orbit around', 'pulls slowly toward', 'dissolves into a nebula with', 'eclipses', 'spirals around'];
    final lines = <String>[];
    for (var i = 0; i + 1 < f.length; i++) {
      lines.add('"${short(f[i])}" ${moves[rand.nextInt(moves.length)]} "${short(f[i + 1])}"');
    }
    return 'I drift through a dark field of old stars. ${lines.join(', and ')}, '
        'until the whole sky turns slowly, like something breathing.';
  }

  /// The memories a dream was made of -- its stars -- for the app's constellation view.
  static Future<List<ConceptExample>> stars(Session session, int dreamId) async {
    final dream = await DreamEntry.db.findById(session, dreamId);
    if (dream == null) return [];
    final blocks = await MemoryBlock.db.find(
      session,
      where: (t) => t.id.inSet(dream.sourceBlockIds.toSet()) & t.source.inSet(_sharedSources),
    );
    return [
      for (final b in blocks)
        ConceptExample(
          source: b.source == 'net' ? (b.feedSource ?? 'web') : b.source,
          title: _fragment(b) ?? 'a memory',
          snippet: b.source == 'self' ? b.answer : b.extract,
          url: b.url,
          timestamp: b.timestamp,
        ),
    ];
  }
}
