import 'package:flutter/material.dart';

import '../theme.dart';
import 'glass.dart';

enum GlassSide { left, right, center }

/// The main app's glass panels, in one place: on a wide screen Dialogue Link slides in from the
/// right and Tasks from the left, as frosted glass over the blurred page; on a phone -- and always
/// for COP and Alerts -- a glass pop-up springs up in the middle. A tap outside, Escape or ✕ closes it.
Future<T?> openGlassPanel<T>(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Widget child,
  GlassSide side = GlassSide.center,
  double maxWidth = 640,
  List<Widget> actions = const [],
}) {
  final wide = MediaQuery.of(context).size.width >= 900;
  final sliding = wide && side != GlassSide.center;
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close',
    barrierColor: Colors.black.withValues(alpha: WyrdColors.dark ? 0.35 : 0.12),
    transitionDuration: Duration(milliseconds: sliding ? 340 : 420),
    pageBuilder: (ctx, _, _) {
      final pane0 = _GlassPane(
        title: title,
        icon: icon,
        actions: actions,
        child: child,
      );
      // the page behind, softly blurred, so the pane stands in front of it
      Widget pane = pane0;
      Widget withVeil(Widget w) => Stack(children: [glassVeil(), w]);
      if (sliding) {
        return withVeil(
          Align(
            alignment: side == GlassSide.right
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: SizedBox(
              width: side == GlassSide.right ? 460 : 420,
              child: Padding(padding: const EdgeInsets.all(10), child: pane),
            ),
          ),
        );
      }
      return withVeil(
        SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: FractionallySizedBox(heightFactor: 0.94, child: pane),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (ctx, anim, _, child) {
      if (sliding) {
        final curve = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return SlideTransition(
          position: Tween(
            begin: Offset(side == GlassSide.right ? 1 : -1, 0),
            end: Offset.zero,
          ).animate(curve),
          child: FadeTransition(opacity: curve, child: child),
        );
      }
      // springs in from a little smaller, overshooting a touch, as in the main app
      final spring = CurvedAnimation(
        parent: anim,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeInBack,
      );
      return FadeTransition(
        opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween(begin: 0.88, end: 1.0).animate(spring),
          child: child,
        ),
      );
    },
  );
}

class _GlassPane extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final List<Widget> actions;
  const _GlassPane({
    required this.title,
    required this.icon,
    required this.child,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Glass(
      child: Material(
        color: Colors.transparent,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 6, 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: WyrdColors.glassBorder),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: WyrdColors.signal),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: WyrdText.display(fontSize: 24),
                      ),
                    ),
                    ...actions,
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: WyrdColors.greenDim,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
