/// WYRD's model and the shape of its requests to the Anthropic Messages API, in one place.
///
/// Claude Haiku 5.5: a tenth of Haiku 4.5's price ($0.10 / $0.50 per million tokens for prompts up
/// to 100K tokens), so the same daily cap buys far more thinking. Three differences from 4.5 matter
/// here:
/// - it thinks before answering unless told not to. Thinking stays off: the replies are short, a
///   small max_tokens could be spent entirely on thinking, and the agent shortens its own history
///   as it goes, which a conversation carrying thinking blocks doesn't allow;
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

  /// A request body for [model] (WYRD's core model unless said otherwise). [cachedSystem] is the
  /// part of the system prompt that stays the same across the calls of a loop: it's cached, with
  /// the [tools] ahead of it. [system] is the rest, which may change each call.
  static Map<String, dynamic> body({
    String model = core,
    String? cachedSystem,
    String system = '',
    required List<Map<String, dynamic>> messages,
    required int maxTokens,
    List<Map<String, dynamic>>? tools,
  }) =>
      {
        'model': model,
        'max_tokens': room(maxTokens),
        if (cachedSystem == null)
          'system': system
        else
          'system': [
            {'type': 'text', 'text': cachedSystem, 'cache_control': {'type': 'ephemeral'}},
            if (system.isNotEmpty) {'type': 'text', 'text': system},
          ],
        'messages': messages,
        if (tools != null) 'tools': tools,
        'thinking': {'type': 'disabled'},
      };
}
