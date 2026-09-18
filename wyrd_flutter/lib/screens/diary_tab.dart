import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';

/// WYRD's diary: real entries it's written to itself, newest first.
class DiaryTab extends StatefulWidget {
  const DiaryTab({super.key});

  @override
  State<DiaryTab> createState() => _DiaryTabState();
}

class _DiaryTabState extends State<DiaryTab> {
  late Future<List<DiaryEntry>> _entries;

  @override
  void initState() {
    super.initState();
    _entries = client.diary.getEntries();
  }

  Future<void> _refresh() async {
    setState(() => _entries = client.diary.getEntries());
    await _entries;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<DiaryEntry>>(
        future: _entries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load diary: ${snapshot.error}'));
          }
          final entries = snapshot.data ?? [];
          if (entries.isEmpty) {
            return ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Text('No diary entries yet — WYRD writes one per real day, once there\'s something to reflect on.', textAlign: TextAlign.center),
                ),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final entry = entries[i];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.date, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Text(entry.content),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
