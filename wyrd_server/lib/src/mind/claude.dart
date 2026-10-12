/// WYRD's model and the shape of its requests to the Anthropic Messages API, in one place.
///
/// Claude Haiku 5.5: a tenth of Haiku 4.5's price ($0.10 / $0.50 per million tokens for prompts up
/// to 100K tokens), so the same daily cap buys far more thinking. Three differences from 4.5 matter
/// here:
/// - it thinks before answering unless told not to. Dialogue Link's replies think (low effort, with
///   [thinkingRoom] on top of max_tokens so thinking can't use up the reply) and return a summary
///   the person can open; everything else runs with thinking off -- the agent shortens its own
///   history as it goes, which a conversation carrying thinking blocks doesn't allow;
/// - the same text counts as about 30% more tokens, so [room] scales max_tokens to keep replies
///   the same length;
/// - prompts from 512 tokens can be cached (4.5 needed 4,096). Only the agent caches: its steps
///   repeat the same system prompt and tools many times a run. A chat reply is usually a single
///   call, where writing a cache would cost a quarter more and nothing would read it back.
class Claude {
  static const core = 'claude-haiku-5-5';
  static final endpoint = Uri.parse('https://api.anthropic.com/v1/messages');

  static Map<String, String> headers(String apiKey) => {
    'Content-Type': 'application/json',
    'x-api-key': apiKey,
    'anthropic-version': '2023-06-01',
  };

  /// [maxTokens] as it was sized for Haiku 4.5's tokenizer.
  static int room(int maxTokens) => (maxTokens * 1.3).ceil();

  /// A request body for [model] (WYRD's core model unless said otherwise). [think]: Dialogue Link's
  /// replies think first (low effort) and return a summary of it, shown under the reply; everything
  /// else runs with thinking off. [cachedSystem] is the
  /// part of the system prompt that stays the same across the calls of a loop: it's cached, with
  /// the [tools] ahead of it. [system] is the rest, which may change each call.
  static Map<String, dynamic> body({
    String model = core,
    String? cachedSystem,
    String system = '',
    required List<Map<String, dynamic>> messages,
    required int maxTokens,
    List<Map<String, dynamic>>? tools,
    bool think = false,
  }) => {
    'model': model,
    'max_tokens': room(maxTokens) + (think ? thinkingRoom : 0),
    if (cachedSystem == null)
      'system': system
    else
      'system': [
        {
          'type': 'text',
          'text': cachedSystem,
          'cache_control': {'type': 'ephemeral'},
        },
        if (system.isNotEmpty) {'type': 'text', 'text': system},
      ],
    'messages': messages,
    if (tools != null) 'tools': tools,
    'thinking': think
        ? {'type': 'adaptive', 'display': 'summarized'}
        : {'type': 'disabled'},
    if (think) 'output_config': {'effort': 'low'},
  };

  /// Room for thinking on top of the reply's own (it counts toward max_tokens).
  static const thinkingRoom = 2048;

  /// The summary of what the model thought, from a response's content (empty blocks skipped), or null.
  static String? thinkingOf(List<Map<String, dynamic>> content) {
    final parts = [
      for (final b in content)
        if (b['type'] == 'thinking' &&
            (b['thinking'] as String? ?? '').trim().isNotEmpty)
          (b['thinking'] as String).trim(),
    ];
    return parts.isEmpty ? null : parts.join('\n\n');
  }
}
