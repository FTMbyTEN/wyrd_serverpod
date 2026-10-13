import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Games WYRD programs on request and keeps in the person's Games tab. Saving one with the title
/// of a game they already have replaces it (so "make the snake faster" updates their Snake).
class CustomGames {
  static const maxPerPerson = 30;
  static const maxHtml = 400000;

  static const saveGameTool = {
    'name': 'save_game',
    'description':
        'Program a game they asked for and put it in their Games tab, where they can play it any time '
        '(and it opens live right now). Use it whenever they ask you to make, build, program or add a game. '
        'Write ONE complete, self-contained HTML document (inline <style> and <script>, no external files, '
        'libraries, fonts or network) that is a polished, fully working game: a title screen with how to play, '
        'keyboard AND touch/mouse controls, score (a best score only in memory, or in localStorage wrapped in try/catch: the frame is sandboxed and storage may throw), win/lose '
        'states, restart (it runs inside a frame: call window.focus() on load and on every tap so keys reach it), sound only if made with WebAudio, a responsive canvas or layout that fills the frame '
        '(100vw x 100vh) on phone and desktop, and a smooth requestAnimationFrame loop for anything real-time. '
        'Any computer opponent should play properly. Test the logic in your head before you write it: no '
        'placeholders, no TODOs, no unfinished rules. To change a game they have, save it again with the same title.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {
          'type': 'string',
          'description': 'The game\'s name, a few words.',
        },
        'blurb': {
          'type': 'string',
          'description':
              'One short line for its tile: what it is and how to play.',
        },
        'html': {
          'type': 'string',
          'description': 'The complete game as one HTML document.',
        },
      },
      'required': ['title', 'blurb', 'html'],
    },
  };

  /// Saves (or replaces by title) and returns the action that opens it, and what the model is told.
  static Future<(ChatAction?, String)> save(
    Session session,
    UuidValue user,
    Map<String, dynamic> input,
  ) async {
    final title = (input['title'] as String? ?? '').trim();
    final blurb = (input['blurb'] as String? ?? '').trim();
    final html = (input['html'] as String? ?? '').trim();
    if (title.isEmpty || !html.toLowerCase().contains('<script')) {
      return (
        null,
        'The game was not saved: it needs a title and a complete HTML document with its script.',
      );
    }
    if (html.length > maxHtml) {
      return (
        null,
        'The game was not saved: it is too large. Write it more compactly.',
      );
    }
    final name = title.length > 60 ? title.substring(0, 60) : title;
    final now = DateTime.now().toUtc();
    final existing = await CustomGame.db.findFirstRow(
      session,
      where: (g) => g.authUserId.equals(user) & g.title.ilike(name),
    );
    if (existing != null) {
      await CustomGame.db.updateRow(
        session,
        existing.copyWith(blurb: blurb, html: html, updatedAt: now),
      );
    } else {
      final count = await CustomGame.db.count(
        session,
        where: (g) => g.authUserId.equals(user),
      );
      if (count >= maxPerPerson) {
        return (
          null,
          'The game was not saved: their Games tab already holds $maxPerPerson games. Ask them to delete one first.',
        );
      }
      await CustomGame.db.insertRow(
        session,
        CustomGame(
          authUserId: user,
          title: name,
          blurb: blurb,
          html: html,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
    return (
      ChatAction(type: 'preview_app', html: html),
      '"$name" is ${existing != null ? 'updated' : 'saved'} in their Games tab (under YOUR GAMES) and open live now. '
          'Tell them in a sentence or two how to play, and that they can ask you to change anything.',
    );
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
