import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'topic_service.dart';

/// Two tools of Dialogue Link for WYRD called up from anywhere in the app:
///  - customize_app: changes the app for the person -- light or dark, the accent colour, the text
///    size -- or takes them to a tab or panel. The app applies it (ChatAction 'customize', its
///    setting and value as JSON in html), so WYRD changes what it can see they're looking at;
///  - learn: keeps a method WYRD just found on the web (how to do or fix something it didn't know)
///    as a memory block, which its recall searches, so the next time it knows.
class AppTools {
  static const settings = {'theme', 'accent', 'text_size', 'open'};
  static const places = {
    'wyrd', 'academy', 'games', 'journal', 'drone', 'you', //
    'tasks', 'alerts', 'cop', 'brain', 'globe',
  };

  static const customizeTool = {
    'name': 'customize_app',
    'description':
        'Change the app for them, or take them somewhere in it. setting "theme": value light, dark or auto. '
        'setting "accent": the accent colour as a hex like #2A7FFF (pick a fitting one when they name a colour). '
        'setting "text_size": small, normal, large or huge. setting "open": a place -- wyrd (home), academy, '
        'games, journal, drone, you, tasks, alerts, cop, brain (BRAIN_3D) or globe. Call it whenever they ask '
        'for any of these; it is applied the moment you reply.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'setting': {
          'type': 'string',
          'enum': ['theme', 'accent', 'text_size', 'open'],
        },
        'value': {'type': 'string'},
      },
      'required': ['setting', 'value'],
    },
  };

  static const learnTool = {
    'name': 'learn',
    'description':
        'Keep something you just found out how to do (from web_search and read_page) so you know it next '
        'time: a short title, the method in your own words, and the page it came from. Use it whenever you '
        'had to look up how to do or fix something.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {'type': 'string'},
        'how': {
          'type': 'string',
          'description': 'The method, step by step, in your own words.',
        },
        'url': {'type': 'string'},
      },
      'required': ['title', 'how'],
    },
  };

  static const names = {'customize_app', 'learn'};

  /// The action for the app (null for learn), and what the model is told.
  static Future<(ChatAction?, String)> use(
    Session session,
    String name,
    Map<String, dynamic> input,
  ) async {
    if (name == 'learn') return (null, await _learn(session, input));
    final setting = (input['setting'] as String? ?? '').trim();
    var value = (input['value'] as String? ?? '').trim().toLowerCase();
    final ok = switch (setting) {
      'theme' => {'light', 'dark', 'auto'}.contains(value),
      'accent' => RegExp(r'^#[0-9a-f]{6}$').hasMatch(value),
      'text_size' => {'small', 'normal', 'large', 'huge'}.contains(value),
      'open' => places.contains(value),
      _ => false,
    };
    if (!ok) {
      return (
        null,
        'That was not applied: "$setting" = "$value" is not something customize_app takes. Use theme '
            '(light/dark/auto), accent (#rrggbb), text_size (small/normal/large/huge) or open (one of '
            '${places.join(', ')}).',
      );
    }
    return (
      ChatAction(
        type: 'customize',
        html: jsonEncode({'setting': setting, 'value': value}),
      ),
      'Done: $setting is set to $value in their app as you reply. Say so in a few words.',
    );
  }

  static Future<String> _learn(
    Session session,
    Map<String, dynamic> input,
  ) async {
    final title = (input['title'] as String? ?? '').trim();
    final how = (input['how'] as String? ?? '').trim();
    final url = (input['url'] as String? ?? '').trim();
    if (title.isEmpty || how.length < 20) {
      return 'Not kept: learn needs a title and the method.';
    }
    await MemoryBlock.db.insertRow(
      session,
      MemoryBlock(
        timestamp: DateTime.now().toUtc(),
        source: 'net',
        feedSource: 'learned',
        title: title.length > 200 ? title.substring(0, 200) : title,
        extract: how.length > 4000 ? how.substring(0, 4000) : how,
        url: url.isEmpty ? null : url,
        topics: TopicService.extractTopics('$title $how'),
        category: 'how-to',
      ),
    );
    return 'Kept: you will know "$title" next time.';
  }
}
