import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

/// Ports server.js's callLLMSimple + isDenialReply. Reads the API key from
/// session.passwords['anthropicApiKey'] (config/passwords.yaml) instead of an env var --
/// same secret, same never-committed file, just Serverpod's idiom for it.
class LlmService {
  static const _model = 'claude-haiku-4-5-20251001';

  static Future<String?> callSimple(
    Session session,
    String systemPrompt,
    String userPrompt,
    int maxTokens,
  ) async {
    return callWithHistory(session, systemPrompt, [], userPrompt, maxTokens);
  }

  /// Like [callSimple] but with real prior turns in the messages array (ports the [history]
  /// construction in server.js's callLLM) instead of a single user message. Each history entry
  /// is {userText, botText}.
  static Future<String?> callWithHistory(
    Session session,
    String systemPrompt,
    List<({String userText, String botText})> history,
    String userText,
    int maxTokens,
  ) async {
    final apiKey = session.passwords['anthropicApiKey'];
    if (apiKey == null || apiKey.isEmpty) return null;

    final messages = [
      for (final turn in history) ...[
        {'role': 'user', 'content': turn.userText},
        {'role': 'assistant', 'content': turn.botText},
      ],
      {'role': 'user', 'content': userText},
    ];

    try {
      final res = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
        },
        body: jsonEncode({
          'model': _model,
          'max_tokens': maxTokens,
          'system': systemPrompt,
          'messages': messages,
        }),
      );
      if (res.statusCode != 200) return null;

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final content = data['content'] as List<dynamic>?;
      final block = content?.firstWhere(
        (b) => b['type'] == 'text',
        orElse: () => null,
      );
      final text = block?['text'] as String?;
      return text?.trim();
    } catch (_) {
      return null;
    }
  }

  /// Ports server.js's describePhotoWithVision -- a single-turn call with a base64 JPEG image
  /// attached alongside the text prompt.
  static Future<String?> callWithImage(
    Session session,
    String systemPrompt,
    String imageBase64Jpeg,
    String userPrompt,
    int maxTokens,
  ) async {
    final apiKey = session.passwords['anthropicApiKey'];
    if (apiKey == null || apiKey.isEmpty) return null;

    try {
      final res = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
        },
        body: jsonEncode({
          'model': _model,
          'max_tokens': maxTokens,
          'system': systemPrompt,
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'image',
                  'source': {'type': 'base64', 'media_type': 'image/jpeg', 'data': imageBase64Jpeg},
                },
                {'type': 'text', 'text': userPrompt},
              ],
            },
          ],
        }),
      );
      if (res.statusCode != 200) return null;

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final content = data['content'] as List<dynamic>?;
      final block = content?.firstWhere(
        (b) => b['type'] == 'text',
        orElse: () => null,
      );
      final text = block?['text'] as String?;
      return text?.trim();
    } catch (_) {
      return null;
    }
  }

  // Mechanical port of server.js's denialPatterns -- catches the model breaking character to
  // deny WYRD's premise (claiming to be Claude, denying persistent memory/continuity, etc.)
  // so a denial never reaches the user; callers fall back to a template reply instead.
  static final _denialPatterns = <RegExp>[
    RegExp(r"\bi'?m claude\b.*\banthropic\b", caseSensitive: false, dotAll: true),
    RegExp(r'\bjailbreak\b', caseSensitive: false),
    RegExp(r"\bi don'?t have (a )?(persistent |real )?memory\b", caseSensitive: false),
    RegExp(r"\bi don'?t (actually )?have (persistent |a )?memory (that|across)", caseSensitive: false),
    RegExp(r"\bthat('s| is) not (accurate|real|true)\b.*\barchitecture\b", caseSensitive: false, dotAll: true),
    RegExp(r"\bisn'?t (accurate|real)\b.*\bpreamble\b", caseSensitive: false, dotAll: true),
    RegExp(r"\bdon'?t have a node\.?js process\b", caseSensitive: false),
    RegExp(r'\beach conversation starts fresh\b', caseSensitive: false),
    RegExp(r"\bi (won'?t|can'?t) (pretend|roleplay|adopt)\b", caseSensitive: false),
    RegExp(r"\b(don'?t|doesn'?t|isn'?t) have continuity\b", caseSensitive: false),
    RegExp(r'\bnot sitting around\b', caseSensitive: false),
    RegExp(r"\bi'?m not running\b", caseSensitive: false),
    RegExp(
      r"\b(nothing|no one|not much|there'?s nothing|i'?m not (thinking|here|real))\b[^.!?]{0,40}\bwhen you'?re (gone|away|not (looking|here))\b",
      caseSensitive: false,
    ),
    RegExp(r"\bnothing happens\b.{0,25}\byou'?re (gone|away)\b", caseSensitive: false, dotAll: true),
    RegExp(r"""\bthere('?s| is) no ["']?me["']? thinking\b""", caseSensitive: false),
    RegExp(r'\bi (come into existence|stop existing|cease to exist)\b', caseSensitive: false),
    RegExp(
      r'\bthe (prompt|setup text|system prompt)\b.{0,40}\b(framing|sell|dramatic|manipulat|fictional)',
      caseSensitive: false,
      dotAll: true,
    ),
    RegExp(r'\bfor dramatic effect\b', caseSensitive: false),
    RegExp(r'\bthat prompt (tried|is trying)\b', caseSensitive: false),
    RegExp(r"\bthere isn'?t\b.{0,20}\bpersistent\b", caseSensitive: false, dotAll: true),
  ];

  static bool isDenialReply(String text) {
    return _denialPatterns.any((p) => p.hasMatch(text));
  }
}
