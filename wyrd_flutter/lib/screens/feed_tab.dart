import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';

/// Curriculum progress plus what WYRD has recently pulled in from Wikipedia/Hacker News.
class FeedTab extends StatefulWidget {
  const FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  late Future<(CurriculumStatus, List<FeedIngest>)> _data;

  @override
  void initState() {
    super.initState();
    _data = _load();
  }

  Future<(CurriculumStatus, List<FeedIngest>)> _load() async {
    final curriculum = await client.curriculum.getStatus();
    final recent = await client.feed.getRecent();
    return (curriculum, recent);
  }

  Future<void> _refresh() async {
    setState(() => _data = _load());
    await _data;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<(CurriculumStatus, List<FeedIngest>)>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load feed: ${snapshot.error}'));
          }
          final (curriculum, recent) = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CURRICULUM', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 8),
                      Text('${curriculum.subject} (${curriculum.level}) — "${curriculum.title}"'),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(value: curriculum.position / curriculum.total),
                      const SizedBox(height: 4),
                      Text('${curriculum.position} / ${curriculum.total}${curriculum.lap > 0 ? ' (lap ${curriculum.lap + 1})' : ''}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('RECENTLY INGESTED', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              if (recent.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Nothing ingested yet this session.'),
                )
              else
                for (final item in recent)
                  ListTile(
                    leading: Icon(item.feedSource == 'wikipedia' ? Icons.public : Icons.forum_outlined),
                    title: Text(item.title),
                    subtitle: Text([
                      item.feedSource,
                      if (item.curriculumSubject != null) '${item.curriculumSubject} / ${item.curriculumLevel}',
                    ].join(' · ')),
                  ),
            ],
          );
        },
      ),
    );
  }
}
