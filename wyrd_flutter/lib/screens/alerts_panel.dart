import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';

/// ALERTS, as in the main app's bell: what WYRD wants you to know -- each with its tag, how long
/// ago, and the note itself.
class AlertsPanel extends StatefulWidget {
  const AlertsPanel({super.key});

  @override
  State<AlertsPanel> createState() => _AlertsPanelState();
}

class _AlertsPanelState extends State<AlertsPanel> {
  List<AlertNote>? _alerts;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    client.alerts
        .getAlerts()
        .then((a) {
          if (mounted) setState(() => _alerts = a);
        })
        .catchError((_) {
          if (mounted) setState(() => _failed = true);
          return <AlertNote>[];
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return Center(
        child: Text(
          "Couldn't load alerts just now.",
          style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
        ),
      );
    }
    final a = _alerts;
    if (a == null)
      return Center(child: CircularProgressIndicator(color: WyrdColors.signal));
    if (a.isEmpty) {
      return Center(
        child: Text(
          'Nothing new. WYRD will tell you here.',
          style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: a.length,
      separatorBuilder: (_, _) =>
          Divider(color: WyrdColors.greenBorderDim, height: 22),
      itemBuilder: (_, i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: WyrdColors.signalSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  a[i].tag.toUpperCase(),
                  style: WyrdText.mono(
                    fontSize: 9,
                    color: WyrdColors.signal,
                  ).copyWith(letterSpacing: 1.4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                a[i].ago,
                style: WyrdText.mono(fontSize: 10, color: WyrdColors.greenDim),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            a[i].body,
            style: WyrdText.serif(fontSize: 15).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
