import 'package:flutter/widgets.dart';

/// Off the web there is no sandboxed frame; the card says so.
Widget sandboxFrame({
  required String key,
  String? html,
  String? pythonCode,
  required double height,
  void Function(double)? onHeight,
  // a round WYRD played in the game (its WYRD LEARNS mode posts {wyrdRound: {score, params, note}})
  void Function(Map<dynamic, dynamic> round)? onWyrdRound,
}) => const SizedBox(
  height: 60,
  child: Center(child: Text('Open WYRD on the web to see this.')),
);
