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
    expect(WyrdCharter.chat, contains('draw_picture'));
  });

  test(
    'a picture WYRD draws is kept, marked, and cleaned of anything that could run or fetch',
    () {
      final (pic, told) = VisualTools.use('draw_picture', {
        'title': 'Lagos sunset',
        'svg':
            'Here you go: <svg viewBox="0 0 800 600" onload="alert(1)">'
            '<script>steal()</script>'
            '<rect width="800" height="600" fill="url(#sky)"/>'
            '<image href="https://evil.example/x.png"/>'
            '<a xlink:href="javascript:alert(1)"><circle r="5"/></a>'
            '<foreignObject><div>hi</div></foreignObject>'
            '</svg> enjoy',
      });
      expect(pic.type, 'show_visual');
      expect(pic.html, startsWith(VisualTools.pictureMark));
      expect(
        pic.html,
        contains('<rect width="800" height="600" fill="url(#sky)"/>'),
      );
      for (final bad in [
        '<script',
        'onload',
        'https://evil',
        'javascript:',
        'foreignObject',
        'Here you go',
        'enjoy',
      ]) {
        expect(pic.html, isNot(contains(bad)), reason: bad);
      }
      expect(VisualTools.kept(pic), isTrue);
      expect(told, contains('picture'));

      final (none, _) = VisualTools.use('draw_picture', {
        'title': 'x',
        'svg': 'no drawing here',
      });
      expect(VisualTools.kept(none), isFalse);
    },
  );
}
