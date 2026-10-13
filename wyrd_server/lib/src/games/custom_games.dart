import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../mind/claude.dart';
import '../mind/llm_budget.dart';

/// Games WYRD programs on request and keeps in the person's Games tab. Writing a whole game takes
/// a minute or two -- longer than a chat request may stay open -- so build_game only starts it:
/// the tile shows "building" at once, the game is written in the background with its own session,
/// and the tile turns playable (or failed) when it's done. Asking again with the same title
/// rewrites that game, starting from the current version.
class CustomGames {
  static const maxPerPerson = 30;
  static const maxHtml = 400000;

  static const buildGameTool = {
    'name': 'build_game',
    'description':
        'Program a game they asked for into their Games tab (under YOUR GAMES), where they can play it any '
        'time. Use it whenever they ask you to make, build, program, design or add a game, or to change one '
        'you made. You only describe it here: the game itself is then written in the background and appears '
        'in their Games tab in a minute or two. Do NOT write the code in your reply.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {
          'type': 'string',
          'description':
              "The game's name, a few words. To change a game they have, use its exact title.",
        },
        'blurb': {
          'type': 'string',
          'description':
              'One short line for its tile: what it is and how to play.',
        },
        'spec': {
          'type': 'string',
          'description':
              'What to build, fully: the game, its rules, controls, look and theme, levels, any '
              'computer opponent, and everything they asked for (or, for a change, exactly what to change).',
        },
      },
      'required': ['title', 'blurb', 'spec'],
    },
  };

  static const _writer =
      'You are WYRD, programming a game for someone, to be played full screen in a sandboxed frame in '
      'their Games tab. Reply with ONLY one complete, self-contained HTML document, from <!doctype html> '
      'to </html>: inline <style> and <script>, no external files, libraries, fonts, images or network. '
      'It must be a polished, fully working, genuinely fun game, not a demo: a title screen with how to '
      'play and a start button; keyboard AND touch/mouse controls (on-screen buttons on touch screens '
      'where the game needs them); score, win/lose states and restart; a responsive canvas or layout '
      'that fills 100vw x 100vh on phone and desktop and adapts on resize; a smooth requestAnimationFrame '
      'loop with delta time for anything real-time; any computer opponent playing properly. It runs '
      'inside a frame: call window.focus() on load and on every tap so keys reach it, and prevent arrow '
      'keys and space from scrolling. Storage may throw there: keep a best score in memory, or in '
      'localStorage only inside try/catch. Sound only via WebAudio, started after the first tap. Draw '
      'everything with canvas or CSS shapes (emoji are fine). Check every rule and every code path in your '
      'head before you write: no placeholders, no TODOs, no unfinished features, no console errors.';

  /// Starts building (or rebuilding by title) and returns what the model is told.
  static Future<String> startBuild(
    Session session,
    UuidValue user,
    Map<String, dynamic> input,
  ) async {
    var title = (input['title'] as String? ?? '').trim();
    final blurb = (input['blurb'] as String? ?? '').trim();
    final spec = (input['spec'] as String? ?? '').trim();
    if (title.isEmpty || spec.isEmpty) {
      return 'Nothing was started: build_game needs a title and a spec.';
    }
    if (title.length > 60) title = title.substring(0, 60);
    final now = DateTime.now().toUtc();
    var game = await CustomGame.db.findFirstRow(
      session,
      where: (g) => g.authUserId.equals(user) & g.title.ilike(title),
    );
    if (game?.status == 'building') {
      return '"$title" is already being built; it will be in their Games tab shortly.';
    }
    final previous = game?.html ?? '';
    if (game != null) {
      game = await CustomGame.db.updateRow(
        session,
        game.copyWith(
          blurb: blurb.isEmpty ? game.blurb : blurb,
          status: 'building',
          updatedAt: now,
        ),
      );
    } else {
      final count = await CustomGame.db.count(
        session,
        where: (g) => g.authUserId.equals(user),
      );
      if (count >= maxPerPerson) {
        return 'Nothing was started: their Games tab already holds $maxPerPerson games. Ask them to delete one first.';
      }
      game = await CustomGame.db.insertRow(
        session,
        CustomGame(
          authUserId: user,
          title: title,
          blurb: blurb,
          html: '',
          status: 'building',
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
    unawaited(
      _write(
        game.id!,
        session.passwords['anthropicApiKey'] ?? '',
        spec,
        previous,
      ),
    );
    return '"$title" is being programmed now; it appears in their Games tab (Apps -> Games, under YOUR '
        'GAMES) in a minute or two, marked "building" until it is ready. Tell them that in a sentence or '
        'two, say what it will be like, and that they can ask you to change anything. Do not write any code.';
  }

  /// Writes the game in the background, in a session of its own (the chat's has ended by then).
  static Future<void> _write(
    int id,
    String apiKey,
    String spec,
    String previous,
  ) async {
    final session = await Serverpod.instance.createSession();
    try {
      String? html;
      if (apiKey.isNotEmpty &&
          await LlmBudget.allow(session, background: false)) {
        final ask = previous.isEmpty
            ? 'Build this game:\n$spec'
            : 'Here is the current version of the game:\n\n$previous\n\nChange it as follows, keeping '
                  'everything else working, and reply with the whole new document:\n$spec';
        final res = await http
            .post(
              Claude.endpoint,
              headers: Claude.headers(apiKey),
              body: jsonEncode(
                Claude.body(
                  system: _writer,
                  messages: [
                    {'role': 'user', 'content': ask},
                  ],
                  maxTokens: 16000,
                  think: true,
                ),
              ),
            )
            .timeout(const Duration(minutes: 8));
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          await LlmBudget.record(
            session,
            data['usage'] as Map<String, dynamic>?,
            model: Claude.core,
          );
          final text = (data['content'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>()
              .where((b) => b['type'] == 'text')
              .map((b) => b['text'] as String? ?? '')
              .join();
          html = extractHtml(text);
        } else {
          session.log(
            '[games] build http ${res.statusCode}',
            level: LogLevel.warning,
          );
        }
      }
      await _finish(session, id, html);
    } catch (e) {
      session.log('[games] build failed: $e', level: LogLevel.warning);
      try {
        await _finish(session, id, null);
      } catch (_) {}
    } finally {
      await session.close();
    }
  }

  /// Marks the game ready with [html], or failed -- a failed rewrite keeps the old version playable.
  static Future<void> _finish(Session session, int id, String? html) async {
    final game = await CustomGame.db.findById(session, id);
    if (game == null) return; // deleted while it was being built
    final ok = html != null && html.length <= maxHtml;
    await CustomGame.db.updateRow(
      session,
      game.copyWith(
        html: ok ? html : game.html,
        status: ok || game.html.isNotEmpty ? null : 'failed',
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// The HTML document in a reply (fenced or not), or null if there's no complete one.
  static String? extractHtml(String text) {
    final lower = text.toLowerCase();
    var start = lower.indexOf('<!doctype');
    if (start < 0) start = lower.indexOf('<html');
    final end = lower.lastIndexOf('</html>');
    if (start < 0 || end < start) return null;
    final html = text.substring(start, end + 7);
    return html.toLowerCase().contains('<script') ? html : null;
  }

  static Future<List<CustomGame>> mine(Session session, UuidValue user) =>
      CustomGame.db.find(
        session,
        where: (g) => g.authUserId.equals(user),
        orderByList: (g) => [g.updatedAt.desc()],
      );

  static Future<void> delete(Session session, UuidValue user, int id) async {
    await CustomGame.db.deleteWhere(
      session,
      where: (g) => g.id.equals(id) & g.authUserId.equals(user),
    );
  }
}
