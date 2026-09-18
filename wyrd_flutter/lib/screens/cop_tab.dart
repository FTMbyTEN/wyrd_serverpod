import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';

/// Shows WYRD's current behavior config and COP's independent oversight log of every change
/// WYRD has made to it.
class CopTab extends StatefulWidget {
  const CopTab({super.key});

  @override
  State<CopTab> createState() => _CopTabState();
}

class _CopTabState extends State<CopTab> {
  late Future<(SelfConfig, List<CopLogEntry>)> _data;

  @override
  void initState() {
    super.initState();
    _data = _load();
  }

  Future<(SelfConfig, List<CopLogEntry>)> _load() async {
    final config = await client.selfConfig.getConfig();
    final log = await client.selfConfig.getCopLog();
    return (config, log);
  }

  Future<void> _refresh() async {
    setState(() => _data = _load());
    await _data;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<(SelfConfig, List<CopLogEntry>)>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load COP log: ${snapshot.error}'));
          }
          final (config, log) = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CURRENT BEHAVIOR CONFIG', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 8),
                      Text('Reply length: up to ${config.replyLengthMax} sentences'),
                      Text('Curiosity level: ${config.curiosityLevel}'),
                      if (config.toneNote.isNotEmpty) Text('Tone note: ${config.toneNote}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('OVERSIGHT LOG', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              if (log.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('No self-modifications reviewed yet.'),
                )
              else
                for (final entry in log)
                  Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${entry.configKey}: ${entry.oldValueJson} → ${entry.newValueJson}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Reason: ${entry.reason}', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 4),
                          Text(entry.verdict),
                        ],
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
