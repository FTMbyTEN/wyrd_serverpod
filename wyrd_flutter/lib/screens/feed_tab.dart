import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/holo.dart';

/// WYRD's vocabulary + live curriculum-driven data feed. Ports FeedTab.tsx. CONCEPT_MAP/
/// GROWTH/WORLD_MAP are placeholders for now -- those are separate visual screens the RN app
/// has that haven't been built in Flutter yet.
class FeedTab extends StatefulWidget {
  const FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  late Future<(LexiconStats, CurriculumStatus, List<FeedIngest>)> _data;
  bool _triggering = false;

  @override
  void initState() {
    super.initState();
    _data = _load();
  }

  Future<(LexiconStats, CurriculumStatus, List<FeedIngest>)> _load() async {
    final stats = await client.lexicon.getStats();
    final curriculum = await client.curriculum.getStatus();
    final feed = await client.feed.getRecent();
    return (stats, curriculum, feed);
  }

  Future<void> _refresh() async {
    setState(() => _data = _load());
    await _data;
  }

  Future<void> _ingestNow() async {
    setState(() => _triggering = true);
    try {
      await client.feed.trigger();
      await _refresh();
    } finally {
      if (mounted) setState(() => _triggering = false);
    }
  }

  void _notAvailable(String label) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label is not built in this app yet.')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WyrdColors.bg,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<(LexiconStats, CurriculumStatus, List<FeedIngest>)>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator(color: WyrdColors.green));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Could not load feed: ${snapshot.error}', style: WyrdText.mono(color: WyrdColors.danger)));
            }
            final (stats, curriculum, feed) = snapshot.data!;
            final recentWords = stats.recentWords.map((w) => w.word).join(' · ');
            final vocabGlow = (0.35 + stats.learned / 4000).clamp(0.0, 1.0);

            return ListView(
              padding: const EdgeInsets.all(14),
              children: [
                HoloFrame(
                  glow: vocabGlow,
                  beam: false,
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('VOCABULARY', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                            Flexible(
                              child: Text(
                                '${curriculum.subject} · ${curriculum.position}/${curriculum.total}',
                                style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text('${stats.learned} words understood', style: WyrdText.display(fontSize: 26)),
                        const SizedBox(height: 5),
                        Text(
                          'recent · ${recentWords.isEmpty ? '—' : recentWords}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: WyrdText.mono(fontSize: 10.5, color: WyrdColors.greenDim),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: HoloButton(label: 'CONCEPT MAP', onPressed: () => _notAvailable('Concept map'))),
                            const SizedBox(width: 7),
                            Expanded(child: HoloButton(label: 'GROWTH', onPressed: () => _notAvailable('Growth chart'))),
                            const SizedBox(width: 7),
                            Expanded(child: HoloButton(label: 'WORLD MAP', onPressed: () => _notAvailable('World map'))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LIVE DATA FEED', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                    SizedBox(
                      width: 110,
                      child: HoloButton(label: _triggering ? '···' : 'INGEST NOW', onPressed: _triggering ? () {} : _ingestNow),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (feed.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('no ingests yet', textAlign: TextAlign.center, style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.greenBorderDim)),
                  ),
                for (final item in feed) _feedItem(item),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _feedItem(FeedIngest item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 3,
            decoration: const BoxDecoration(color: WyrdColors.green, boxShadow: [BoxShadow(color: WyrdColors.green, blurRadius: 6)]),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF000F04).withValues(alpha: 0.72),
                border: Border.all(color: WyrdColors.greenBorderDim),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('[${item.feedSource}]', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                      Text(_timeAgo(item.timestamp), style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(item.title, style: WyrdText.mono(fontSize: 12.5, color: WyrdColors.mint).copyWith(height: 1.4)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().toUtc().difference(dt.toUtc());
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}
