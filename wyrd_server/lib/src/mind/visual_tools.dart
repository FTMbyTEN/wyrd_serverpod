import '../generated/protocol.dart';

/// Two things WYRD used to say it couldn't do in a conversation, now tools of Dialogue Link (chat and
/// the code writer):
///  - show_visual: a chart, a price-level map, a diagram or any picture, drawn as one self-contained
///    HTML/SVG document and shown right inside the reply (a sealed frame: no network, no access to
///    the app);
///  - run_python: Python run for the person in a sandbox in their own browser (Pyodide), its output
///    and any matplotlib figures shown in the reply. WYRD never sees the result; it says so.
/// Both are kept on the turn (ConversationTurn.appHtml, marked by kind), so they can be opened again.
class VisualTools {
  static const visualMark = '<!--wyrd:visual-->';
  static const pythonMark = '<!--wyrd:python-->';

  static const showVisual = {
    'name': 'show_visual',
    'description':
        'Show them a visual inside your reply: a chart (line, bar, candles, price levels), a table drawn as a '
        'graphic, a diagram, a timeline. Write ONE complete, self-contained HTML document with inline <svg> '
        'and/or <canvas> + <script> -- no external files, libraries or network. Size it to fill the frame '
        '(width 100%, about 360px tall), label axes and values, and use clear colours that read on a light '
        'background. Use it whenever a picture would explain better than text, or they ask for a chart. Then '
        'say in a sentence or two what it shows.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {'type': 'string', 'description': 'A few words naming it.'},
        'html': {
          'type': 'string',
          'description': 'The complete self-contained HTML document.',
        },
      },
      'required': ['title', 'html'],
    },
  };

  static const runPython = {
    'name': 'run_python',
    'description':
        'Run Python for them, in a sandbox in their own browser (Pyodide: the standard library plus numpy, '
        'pandas and matplotlib; no network, no files of theirs). Its printed output and any matplotlib figures '
        '(plt.show()) appear inside your reply. Use it when they ask you to run code, or when running it is the '
        'best way to answer (a calculation, a plot from data). You do not see the result: say what it will show, '
        'and ask them to tell you if it errors.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {'type': 'string', 'description': 'A few words naming it.'},
        'code': {'type': 'string', 'description': 'The Python program.'},
      },
      'required': ['title', 'code'],
    },
  };

  /// A picture WYRD drew itself: one SVG, shown in the reply and downloadable (draw_picture).
  static const pictureMark = '<!--wyrd:picture-->';

  static const drawPicture = {
    'name': 'draw_picture',
    'description':
        'Draw them a picture yourself, as an illustration: a scene, a landscape, a poster, a character, an '
        'icon, a logo idea, a card. Use it whenever they ask you to draw, paint, illustrate, design or make an '
        'image or picture -- never say you can\'t make images. Write ONE self-contained <svg> with a viewBox '
        '(800x600 for scenes, 800x800 for icons and portraits): no scripts, no external images, links or fonts. '
        'Make it rich and finished: a full background, layered shapes, gradients (linearGradient / '
        'radialGradient), light and shadow, depth from near to far, and a clear subject; use a harmonious '
        'palette. Then say in a sentence what you drew -- do not describe it at length.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'title': {'type': 'string', 'description': 'A few words naming it.'},
        'svg': {
          'type': 'string',
          'description': 'The complete <svg>...</svg>, with a viewBox.',
        },
      },
      'required': ['title', 'svg'],
    },
  };

  /// What can't be trusted in a drawing is taken out: scripts, event handlers, foreign content and
  /// anything fetched from elsewhere. Null when there's no <svg> in it at all.
  static String? cleanSvg(String raw) {
    final start = raw.indexOf('<svg');
    final end = raw.lastIndexOf('</svg>');
    if (start < 0 || end < start) return null;
    var s = raw.substring(start, end + 6);
    s = s.replaceAll(
      RegExp(r'<script[\s\S]*?</script>', caseSensitive: false),
      '',
    );
    s = s.replaceAll(
      RegExp(r'<foreignObject[\s\S]*?</foreignObject>', caseSensitive: false),
      '',
    );
    s = s.replaceAll(
      RegExp(
        r'\son\w+\s*=\s*("[^"]*"|'
        "'[^']*')",
        caseSensitive: false,
      ),
      '',
    );
    s = s.replaceAll(
      RegExp(
        r'''(href|xlink:href)\s*=\s*("|')\s*(https?:|javascript:|data:text)[^"']*("|')''',
        caseSensitive: false,
      ),
      '',
    );
    return s;
  }

  static const names = {'show_visual', 'run_python', 'draw_picture'};

  /// The action for the app, and what the model is told, for one of these tool calls.
  static (ChatAction, String) use(String name, Map<String, dynamic> input) {
    final title = (input['title'] as String? ?? '').trim();
    if (name == 'draw_picture') {
      final svg = cleanSvg(input['svg'] as String? ?? '');
      if (svg == null) {
        return (
          ChatAction(type: 'show_visual', html: ''),
          'That drawing had no <svg> in it, so nothing was shown. Draw it again as one complete <svg>.',
        );
      }
      return (
        ChatAction(
          type: 'show_visual',
          html: '$pictureMark<!--$title-->\n$svg',
        ),
        'The picture is shown in your reply, and they can download it. Say in a sentence what you drew.',
      );
    }
    if (name == 'run_python') {
      final code = (input['code'] as String? ?? '').trim();
      return (
        ChatAction(type: 'run_python', html: '$pythonMark<!--$title-->\n$code'),
        'The code is running in a sandbox in their browser; its output and any figures appear in your reply. '
            'You will not see the result -- tell them what to expect, and to tell you if it errors.',
      );
    }
    final html = (input['html'] as String? ?? '').trim();
    return (
      ChatAction(type: 'show_visual', html: '$visualMark<!--$title-->\n$html'),
      'The visual is shown inside your reply. Say briefly what it shows; do not describe it at length.',
    );
  }

  /// Whether an action is one to keep on the turn (an app, a visual or a program to run).
  static bool kept(ChatAction? a) =>
      a != null &&
      (a.type == 'preview_app' ||
          a.type == 'show_visual' ||
          a.type == 'run_python') &&
      (a.html ?? '').isNotEmpty;
}
