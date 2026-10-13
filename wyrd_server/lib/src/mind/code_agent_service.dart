import 'dart:convert';

import 'package:http/http.dart' as http;
import '../generated/protocol.dart';
import 'claude.dart';
import 'llm_budget.dart';
import 'visual_tools.dart';
import 'llm_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's code-request bypass (isCodeRequest / isLikelyCodeFollowUp / callCodeLLM).
/// Coding requests skip the short conversational reply path entirely -- a 1-4 sentence,
/// no-bullets chat reply doesn't serve "write me a function" -- and go to a dedicated code prompt
/// with a much larger token budget instead.
///
/// Tools: preview_app only. It's a pure UI signal (the client renders the HTML in a sandboxed
/// frame), so unlike Node it's offered to every user, not just the owner. Node's run_code is not
/// ported: it executed JavaScript with a local Node binary, which the Serverpod Cloud container
/// doesn't have.
class CodeAgentService {
  static const _model = Claude.core;
  static const _maxToolRounds = 2;

  /// A self-contained HTML/CSS/JS app (preview_app's input) easily needs several thousand tokens
  /// on its own; too small a budget truncates mid tool-call and produces no text block at all.
  static const _maxTokens = 8000;

  // Deliberately broad: a false positive just means an ordinary question gets a more thorough
  // answer; a false negative leaves a code request stuck in the short conversational path.
  static final _codePatterns = <RegExp>[
    RegExp(
      r'\b(write|generate|create|build|refactor|debug|fix|optimi[sz]e|program|code|reprogram|rewrite|redo|remake|rebuild|recode|improve|update|modify|extend)\b[^.!?]{0,40}\b(code|program|script|function|class|method|algorithm|snippet|regex|query|component|endpoint|calculator|app|website|tool|bot|game)\b',
      caseSensitive: false,
    ),
    RegExp(
      r'\b(write|build|make|program|code|create|reprogram|rewrite|redo|remake|rebuild)\s+(me\s+|us\s+)?(a|an|the)?\s*(calculator|app|website|game|bot|script|program|tool)\b',
      caseSensitive: false,
    ),
    RegExp(
      r'\bin (javascript|typescript|python|java|c\+\+|c#|rust|go(?:lang)?|sql|html|css|bash|powershell|dart)\b',
      caseSensitive: false,
    ),
    RegExp(
      r'\bhow (do|would|can) i (write|code|implement|build|program)\b',
      caseSensitive: false,
    ),
    RegExp(
      r'\bcan you (write|code|build|implement|program)\b',
      caseSensitive: false,
    ),
    RegExp(r'\brun (this|the following|that) code\b', caseSensitive: false),
  ];

  static bool isCodeRequest(String text) =>
      text.contains('```') || _codePatterns.any((p) => p.hasMatch(text));

  /// A short, topic-less message right after a code reply ("where", "it's not working") stays in
  /// the code path. In-memory on purpose: a short-lived conversational signal, not durable state.
  static final _recentCodeReplyAt = <String, DateTime>{};
  static const _followUpWindow = Duration(minutes: 10);

  static bool isLikelyFollowUp(UuidValue authUserId, String text) {
    final last = _recentCodeReplyAt[authUserId.toString()];
    if (last == null || DateTime.now().difference(last) > _followUpWindow) {
      return false;
    }
    // long enough to plausibly be a new topic
    if (text.trim().split(RegExp(r'\s+')).length > 8) return false;
    // stacked questions read as a topic change
    return !RegExp(r'\?.*\?').hasMatch(text);
  }

  static const _previewAppTool = {
    'name': 'preview_app',
    'description':
        "Pops up a live, real, interactive preview of a small web app in the user's interface — "
        'calculators, games, small tools, anything with a visible UI. Renders in a sandboxed frame '
        '(scripts run, but it cannot reach the rest of the app or the network).',
    'input_schema': {
      'type': 'object',
      'properties': {
        'html': {
          'type': 'string',
          'description':
              'One complete, self-contained HTML document — <style> and <script> inline, no external '
              'resources, no network calls.',
        },
      },
      'required': ['html'],
    },
  };

  static const _openSavedAppTool = {
    'name': 'open_saved_app',
    'description':
        'Open again, live in their interface, the app you built earlier in this chat (it is saved), '
        'exactly as it was. Use it when they only ask to open, load, show or run it again; to change it, '
        'build the new version with preview_app.',
    'input_schema': {'type': 'object', 'properties': <String, dynamic>{}},
  };

  static const _systemPrompt =
      'You are WYRD, and for this message you are operating as a genuinely excellent software '
      'engineer — precise, idiomatic, no hand-waving. Write real, complete, working code, not '
      'pseudocode or a sketch, unless the user explicitly asks for an outline. Use proper markdown '
      "code fences with a language tag. Explain non-obvious design choices briefly, but don't pad "
      "the answer with disclaimers or restate the question back. Multi-paragraph, multi-file, or "
      'long answers are fine here — do not compress this the way you would a casual chat reply.\n\n'
      'Your main tool: preview_app is for anything with a visible interface — a '
      'calculator, a game, a small tool, any UI. Build it as ONE complete self-contained HTML '
      'document (inline <style> and <script>, no external requests) and call preview_app so it '
      "actually pops up live in the user's interface, instead of just describing it in text. If "
      'what\'s being asked for is visual/interactive, always prefer preview_app over only writing '
      'the code in the reply — "done" with no popup is not actually done. For a chart or diagram, '
      'use show_visual; to run Python for them (calculations, data, plots), use run_python -- it runs in a '
      "sandbox in their browser and you never see the output, so don't claim to have run or tested "
      'anything yourself.\n\n'
      // WYRD's principles as an agent, for code (wyrd_charter.dart)
      'Work as a careful engineer: understand what they actually need before writing, and if the request is '
      'ambiguous but low-risk, take the sensible reading and say which. Plan the structure briefly, then write it. '
      'Before you finish, check the code against what they asked for -- every requirement met, edge cases handled, '
      'no half-wired features -- and say plainly what you could not verify (it has not been run) and any known '
      'limits. Never present unfinished code as complete.';

  /// Null when there's no API key or the call fails -- the caller falls back to the normal
  /// conversational path, same safety net as Node.
  static Future<({String text, ChatAction? action, String? thinking})?> reply(
    Session session, {
    required UuidValue authUserId,
    required List<({String userText, String botText})> history,
    required String userText,
    String?
    savedApp, // the latest app built in this chat: open_saved_app reopens it without rewriting it
  }) async {
    final apiKey = session.passwords['anthropicApiKey'];
    if (apiKey == null || apiKey.isEmpty) return null;
    if (!await LlmBudget.allow(session, background: false)) return null;

    var messages = <Map<String, dynamic>>[
      for (final turn in history) ...[
        {'role': 'user', 'content': turn.userText},
        {'role': 'assistant', 'content': turn.botText},
      ],
      {'role': 'user', 'content': userText},
    ];
    ChatAction? pendingAction;
    final thoughts = <String>[]; // shown under the reply

    for (var round = 0; round <= _maxToolRounds; round++) {
      final http.Response res;
      try {
        res = await http
            .post(
              Claude.endpoint,
              headers: Claude.headers(apiKey),
              body: jsonEncode(
                Claude.body(
                  system: _systemPrompt,
                  messages: messages,
                  tools: [
                    _previewAppTool,
                    VisualTools.showVisual,
                    VisualTools.drawPicture,
                    VisualTools.runPython,
                    if (savedApp != null) _openSavedAppTool,
                  ],
                  maxTokens: _maxTokens,
                  think: true,
                ),
              ),
            )
            .timeout(const Duration(seconds: 90));
      } catch (e) {
        session.log('[code-llm] request failed: $e', level: LogLevel.warning);
        return null;
      }
      if (res.statusCode != 200) {
        session.log(
          '[code-llm] http ${res.statusCode}',
          level: LogLevel.warning,
        );
        return null;
      }

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      await LlmBudget.record(
        session,
        data['usage'] as Map<String, dynamic>?,
        model: _model,
      );
      final content = (data['content'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      final thought = Claude.thinkingOf(content);
      if (thought != null) thoughts.add(thought);

      if (data['stop_reason'] == 'tool_use' && round < _maxToolRounds) {
        final toolResults = <Map<String, dynamic>>[];
        for (final block in content.where((b) => b['type'] == 'tool_use')) {
          if (block['name'] == 'open_saved_app' && savedApp != null) {
            pendingAction = ChatAction(type: 'preview_app', html: savedApp);
            toolResults.add({
              'type': 'tool_result',
              'tool_use_id': block['id'],
              'content':
                  'The saved app is open again, live in their interface.',
            });
            continue;
          }
          if (VisualTools.names.contains(block['name'])) {
            final (a, told) = VisualTools.use(
              block['name'] as String,
              block['input'] as Map<String, dynamic>? ?? {},
            );
            pendingAction = a;
            toolResults.add({
              'type': 'tool_result',
              'tool_use_id': block['id'],
              'content': told,
            });
            continue;
          }
          if (block['name'] != 'preview_app') continue;
          final input = block['input'] as Map<String, dynamic>? ?? {};
          pendingAction = ChatAction(
            type: 'preview_app',
            html: input['html'] as String? ?? '',
          );
          toolResults.add({
            'type': 'tool_result',
            'tool_use_id': block['id'],
            'content': "App preview opened live in the user's interface.",
          });
        }
        if (toolResults.isEmpty) return null;
        messages = [
          ...messages,
          {'role': 'assistant', 'content': content},
          {'role': 'user', 'content': toolResults},
        ];
        continue;
      }

      final textBlock = content.firstWhere(
        (b) => b['type'] == 'text',
        orElse: () => {},
      );
      final text = (textBlock['text'] as String?)?.trim();
      if (text == null || text.isEmpty) {
        session.log(
          '[code-llm] no text block, stop_reason=${data['stop_reason']}',
          level: LogLevel.warning,
        );
        return null;
      }
      if (LlmService.isDenialReply(text)) return null;

      _recentCodeReplyAt[authUserId.toString()] = DateTime.now();
      return (
        text: text,
        action: pendingAction,
        thinking: thoughts.isEmpty ? null : thoughts.join('\n\n'),
      );
    }
    return null;
  }
}
