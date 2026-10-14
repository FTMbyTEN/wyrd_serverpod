import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../mind/claude.dart';
import '../mind/llm_budget.dart';
import '../mind/topic_service.dart';

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
      'head before you write: no placeholders, no TODOs, no unfinished features, no console errors. '
      '$_learns';

  /// How WYRD plays a game and learns from it, the same in a new game and in an add-on.
  static const _learns =
      'WYRD LEARNS mode, required: at load, read window.WYRD_LEARNS (when set, an object {best, rounds, '
      'params}); when it is set, YOUR computer player plays the game while they watch, and learns. Its strategy '
      'depends on a params object of 3 to 6 numeric knobs with sensible ranges (how far ahead it looks, how '
      'early it reacts, how much risk it takes...); start from WYRD_LEARNS.params when given, else your '
      'defaults. Start the game once, as a player would, then play: decide at most once every 120 ms and send '
      'only the key or pointer events the game listens for (or call its own input functions). Never call, '
      'repeat or speed up the game\'s update or draw loop, never change its timers or frame rate, and never '
      'restart while a round is in progress -- the game must run exactly as it does for a person. When a '
      'round ends (game over or win), send its result to the page that holds the game: '
      'parent.postMessage({wyrdRound: {score, params, note}}, "*") -- score a number from the game, note a '
      'short plain line on what ended it ("hit a truck in the left lane at speed 7"). Then learn: keep the '
      'params of your best round so far and try a small random change of them for the next round (hill '
      'climbing), and start the next round after 2 seconds. Show a small fixed badge in a corner: "WYRD IS '
      'PLAYING · round N · best X" (N counting on from WYRD_LEARNS.rounds, X the best including '
      'WYRD_LEARNS.best). The moment a real person presses a key or taps (event.isTrusted), stop playing for '
      'good (no more inputs, no restarts) and remove the badge. Never throw: wrap all of it in try/catch.';

  /// The spec that means "add the WYRD PLAYS mode to this game", written as an add-on script
  /// instead of rewriting the whole game (a big game is too long to write out again).
  static const _playSpec = '__add_wyrd_plays__';

  static const _playWriter =
      'You are WYRD. You add a WYRD PLAYS mode to a finished game, as ONE <script> that is appended at the '
      'end of its <body>: it must not change or repeat any of the game. Reply with ONLY that <script>...</script>.';

  static const _playAddOn =
      'Write the <script> that adds the WYRD LEARNS mode to this game. Your computer player reads the '
      'game\'s real state (its variables, the DOM or the canvas logic it uses). $_learns';

  /// [game] with WYRD's add-on script spliced in before </body>, or null if [reply] holds no usable script.
  static String? withPlayAddOn(String game, String reply) {
    final lower = reply.toLowerCase();
    final start = lower.indexOf('<script');
    final end = lower.lastIndexOf('</script>');
    if (start < 0 || end < start) return null;
    final script = reply
        .substring(start, end + 9)
        .replaceFirst('<script', '<script data-wyrd-learns');
    if (!script.contains('WYRD_LEARNS')) return null;
    final body = game.toLowerCase().lastIndexOf('</body>');
    return body < 0
        ? '$game\n$script'
        : '${game.substring(0, body)}$script\n${game.substring(body)}';
  }

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
    if (game != null && game.status == 'building' && !_isStale(game)) {
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
        // adding WYRD's play mode to an existing game is an add-on, never a whole rewrite
        previous.isNotEmpty &&
                !previous.contains('WYRD_LEARNS') &&
                RegExp(
                  r'wyrd.?plays|play.?mode',
                  caseSensitive: false,
                ).hasMatch(spec)
            ? _playSpec
            : spec,
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
    // printed, not session.log: a background session's log isn't in the server's output
    void note(String m) => print('[games] game $id: $m');
    try {
      String? html;
      if (apiKey.isEmpty) note('no API key');
      // two tries: a game that comes back cut off or unreadable gets one more go
      for (var attempt = 1; attempt <= 2 && html == null; attempt++) {
        if (apiKey.isEmpty) break;
        if (!await LlmBudget.allow(session, background: false)) {
          note('over the daily model budget');
          break;
        }
        final addingPlay = spec == _playSpec;
        final ask = addingPlay
            ? 'Here is a game:\n\n$previous\n\n$_playAddOn'
            : previous.isEmpty
            ? 'Build this game:\n$spec'
            : 'Here is the current version of the game:\n\n$previous\n\nChange it as follows, keeping '
                  'everything else working, and reply with the whole new document:\n$spec';
        final res = await http
            .post(
              Claude.endpoint,
              headers: Claude.headers(apiKey),
              body: jsonEncode(
                Claude.body(
                  system: addingPlay ? _playWriter : _writer,
                  messages: [
                    {'role': 'user', 'content': ask},
                  ],
                  // no thinking: with it on, a game could spend the whole allowance thinking and never be written
                  // a whole game, or a rewrite of a big one, needs a lot of room; the WYRD PLAYS
                  // add-on is one script
                  maxTokens: addingPlay ? 9000 : 45000,
                  think: false,
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
          html = addingPlay ? withPlayAddOn(previous, text) : extractHtml(text);
          if (html == null) {
            note(
              'try $attempt: no complete document (stop ${data['stop_reason']}, '
              '${text.length} chars, usage ${data['usage']})',
            );
          }
        } else {
          final body = res.body;
          note(
            'try $attempt: http ${res.statusCode} '
            '${body.length > 300 ? body.substring(0, 300) : body}',
          );
        }
      }
      await _finish(session, id, html);
      note(html == null ? 'failed' : 'ready (${html.length} chars)');
    } catch (e) {
      note('failed: $e');
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

  /// A build that's been "building" this long was cut off (a restart mid-build): it's failed.
  static const _stale = Duration(minutes: 15);
  static bool _isStale(CustomGame g) =>
      g.status == 'building' &&
      DateTime.now().toUtc().difference(g.updatedAt) > _stale;

  static Future<List<CustomGame>> mine(Session session, UuidValue user) async {
    final games = await CustomGame.db.find(
      session,
      where: (g) => g.authUserId.equals(user),
      orderByList: (g) => [g.updatedAt.desc()],
    );
    return [
      for (final g in games)
        _isStale(g)
            ? await CustomGame.db.updateRow(
                session,
                g.copyWith(status: g.html.isEmpty ? 'failed' : null),
              )
            : g,
    ];
  }

  /// A game with WYRD at its controls: the game's own WYRD PLAYS mode, switched on before it loads.
  static const playGameTool = {
    'name': 'play_game',
    'description':
        'Launch one of the games you programmed for them, full screen, with YOU playing it (its WYRD PLAYS '
        'mode) while they watch; they can take the controls at any moment. Use it when they ask you to play '
        'a game, show them how it plays, or play against yourself. Give the game\'s title.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {'type': 'string'},
      },
      'required': ['title'],
    },
  };

  /// [html] with WYRD at the controls from the moment it loads, starting from what it learned
  /// before ([game]'s best, rounds and strategy).
  static String withWyrdPlaying(String html, [CustomGame? game]) {
    Object? params;
    try {
      params = game?.wyrdParams == null ? null : jsonDecode(game!.wyrdParams!);
    } catch (_) {}
    final learned = jsonEncode({
      'best': game?.wyrdBest ?? 0,
      'rounds': game?.wyrdRounds ?? 0,
      'params': params,
    }).replaceAll('<', r'\u003c');
    final flag = '<script>window.WYRD_LEARNS=$learned</script>';
    final head = html.toLowerCase().indexOf('<head>');
    return head < 0
        ? '$flag$html'
        : '${html.substring(0, head + 6)}$flag${html.substring(head + 6)}';
  }

  /// The action that opens the game with WYRD playing, or why it can't yet.
  static Future<(ChatAction?, String)> play(
    Session session,
    UuidValue user,
    Map<String, dynamic> input,
  ) async {
    final title = (input['title'] as String? ?? '').trim();
    final games = await mine(session, user);
    final game = games
        .where((g) => g.title.toLowerCase() == title.toLowerCase())
        .followedBy(
          games.where(
            (g) => g.title.toLowerCase().contains(title.toLowerCase()),
          ),
        )
        .firstOrNull;
    if (game == null) {
      return (
        null,
        'They have no game called "$title". Their games: ${games.map((g) => g.title).join(', ')}. '
            'If they want a new one, build it with build_game.',
      );
    }
    if (game.status != null || game.html.isEmpty) {
      return (
        null,
        '"${game.title}" is not ready to play yet (${game.status ?? 'empty'}).',
      );
    }
    if (!game.html.contains('WYRD_LEARNS')) {
      // programmed before WYRD could play and learn: add the mode now, as an add-on, in the background
      await CustomGame.db.updateRow(
        session,
        game.copyWith(status: 'building', updatedAt: DateTime.now().toUtc()),
      );
      unawaited(
        _write(
          game.id!,
          session.passwords['anthropicApiKey'] ?? '',
          _playSpec,
          game.html,
        ),
      );
      return (
        null,
        '"${game.title}" had no WYRD LEARNS mode yet, so you are adding it now (about a minute; its tile '
            'shows "programming" until then). Tell them that, and that when it is ready they can tap WATCH '
            'WYRD PLAY on its tile or ask you again. Do not claim it is ready.',
      );
    }
    return (
      ChatAction(type: 'preview_app', html: withWyrdPlaying(game.html, game)),
      '"${game.title}" is open full screen with you at the controls. Say in a sentence that you are '
          'playing and that they can take over any time by pressing a key or tapping.',
    );
  }

  /// The game, with WYRD's play mode: as it is if it has one, else "building" while the add-on is
  /// written (see [play]). Null if it isn't theirs.
  static Future<CustomGame?> readyForWyrd(
    Session session,
    UuidValue user,
    int id,
  ) async {
    final game = await CustomGame.db.findFirstRow(
      session,
      where: (g) => g.id.equals(id) & g.authUserId.equals(user),
    );
    if (game == null) return null;
    if (game.status != null || game.html.contains('WYRD_LEARNS')) return game;
    await play(session, user, {'title': game.title}); // starts the add-on
    return CustomGame.db.findById(session, id);
  }

  /// One round WYRD played of [id] (sent by the game through the app): counted, and when it beats
  /// WYRD's best, its strategy is kept to start the next session from, and WYRD remembers it got better.
  static Future<CustomGame?> recordRound(
    Session session,
    UuidValue user,
    int id,
    int score,
    String params,
    String note,
  ) async {
    final game = await CustomGame.db.findFirstRow(
      session,
      where: (g) => g.id.equals(id) & g.authUserId.equals(user),
    );
    if (game == null) return null;
    final rounds = (game.wyrdRounds ?? 0) + 1;
    final best = game.wyrdBest;
    final better = best == null || score > best;
    final kept = params.length > 2000 ? null : params;
    final updated = await CustomGame.db.updateRow(
      session,
      game.copyWith(
        wyrdRounds: rounds,
        wyrdBest: better ? score : best,
        wyrdParams: better && kept != null ? kept : game.wyrdParams,
      ),
    );
    if (better && best != null) {
      final why = note.trim().isEmpty ? '' : ' Last round: ${note.trim()}.';
      await MemoryBlock.db.insertRow(
        session,
        MemoryBlock(
          timestamp: DateTime.now().toUtc(),
          source: 'self',
          title: 'Getting better at ${game.title}',
          extract:
              'My best at ${game.title} is now $score (it was $best), after $rounds rounds of practice.$why',
          topics: TopicService.extractTopics(game.title),
          ownerId: user,
        ),
      );
    }
    return updated;
  }

  /// When [text] asks WYRD to play one of their games by name ("play Lagos Dodge", "WYRD, play my
  /// trivia quiz"), [play] it now and return what happened; null for any other message.
  static Future<(ChatAction?, String)?> playIfAsked(
    Session session,
    UuidValue user,
    String text,
  ) async {
    final m = RegExp(
      r'\bplay\b\s+(?:the\s+|my\s+)?(.+?)[.!?]*$',
      caseSensitive: false,
    ).firstMatch(text.trim());
    if (m == null) return null;
    final asked = m
        .group(1)!
        .toLowerCase()
        .replaceAll(RegExp(r'\s+game$'), '')
        .trim();
    if (asked.isEmpty) return null;
    final games = await mine(session, user);
    final hit = games.where((g) {
      final t = g.title.toLowerCase();
      return t == asked || t.contains(asked) || asked.contains(t);
    }).firstOrNull;
    if (hit == null)
      return null; // not one of theirs (chess, a song...): left to WYRD
    return play(session, user, {'title': hit.title});
  }

  static Future<void> delete(Session session, UuidValue user, int id) async {
    await CustomGame.db.deleteWhere(
      session,
      where: (g) => g.id.equals(id) & g.authUserId.equals(user),
    );
  }
}
