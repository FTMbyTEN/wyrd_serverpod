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

  static const names = {'show_visual', 'run_python'};

  /// The action for the app, and what the model is told, for one of these tool calls.
  static (ChatAction, String) use(String name, Map<String, dynamic> input) {
    final title = (input['title'] as String? ?? '').trim();
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
