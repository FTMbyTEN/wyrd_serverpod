import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/visual_tools.dart';
import 'package:wyrd_server/src/mind/wyrd_charter.dart';

void main() {
  test(
    'a visual and a program are marked, kept on the turn, and honest about not being seen',
    () {
      final (visual, toldV) = VisualTools.use('show_visual', {
        'title': 'Gold levels',
        'html': '<svg></svg>',
      });
      expect(visual.type, 'show_visual');
      expect(visual.html, startsWith(VisualTools.visualMark));
      expect(visual.html, contains('<svg></svg>'));
      expect(toldV, contains('shown'));

      final (py, toldP) = VisualTools.use('run_python', {
        'title': 'Sum',
        'code': 'print(1+1)',
      });
      expect(py.type, 'run_python');
      expect(py.html, startsWith(VisualTools.pythonMark));
      expect(py.html, endsWith('print(1+1)'));
      expect(toldP, contains('will not see'));

      expect(VisualTools.kept(visual), isTrue);
      expect(VisualTools.kept(py), isTrue);
      expect(
        VisualTools.kept(ChatAction(type: 'preview_app', html: '<p>')),
        isTrue,
      );
      expect(VisualTools.kept(ChatAction(type: 'open_world_map')), isFalse);
      expect(VisualTools.kept(null), isFalse);
    },
  );

  test('chat no longer tells WYRD it cannot draw or run code', () {
    expect(WyrdCharter.chat, contains('show_visual'));
    expect(WyrdCharter.chat, contains('run_python'));
  });
}
