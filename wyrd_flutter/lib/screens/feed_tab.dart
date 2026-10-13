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
              return Center(
                child: CircularProgressIndicator(color: WyrdColors.signal),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Couldn't reach WYRD just now. Try again in a moment.",
                  style: WyrdText.mono(color: WyrdColors.danger),
                ),
              );
            }
            final (stats, curriculum, feed) = snapshot.data!;
            final recentWords = stats.recentWords
                .map((w) => w.word)
                .join(' · ');
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
                            Text(
                              'VOCABULARY',
                              style: WyrdText.mono(
                                fontSize: 9,
                                color: WyrdColors.greenDim,
                              ).copyWith(letterSpacing: 1),
                            ),
                            Flexible(
                              child: Text(
                                '${curriculum.subject} · ${curriculum.position}/${curriculum.total}',
                                style: WyrdText.mono(
                                  fontSize: 9,
                                  color: WyrdColors.greenDim,
                                ).copyWith(letterSpacing: 1),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${stats.learned} words understood',
                          style: WyrdText.display(fontSize: 26),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'recent · ${recentWords.isEmpty ? '—' : recentWords}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: WyrdText.mono(
                            fontSize: 10.5,
                            color: WyrdColors.greenDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LIVE DATA FEED',
                      style: WyrdText.mono(
                        fontSize: 9,
                        color: WyrdColors.greenDim,
                      ).copyWith(letterSpacing: 1),
                    ),
                    // starting WYRD's reading by hand is its owner's (the server checks too)
                    ValueListenableBuilder<bool>(
                      valueListenable: ownerAccess,
                      builder: (context, owner, _) => owner
                          ? SizedBox(
                              width: 120,
                              child: HoloButton(
                                label: _triggering ? '···' : 'INGEST NOW',
                                onPressed: _triggering ? () {} : _ingestNow,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (feed.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'no ingests yet',
                      textAlign: TextAlign.center,
                      style: WyrdText.mono(
                        fontSize: 11.5,
                        color: WyrdColors.greenBorderDim,
                      ),
                    ),
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
            decoration: BoxDecoration(
              color: WyrdColors.signal,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: WyrdColors.card,
                border: Border.all(color: WyrdColors.greenBorderDim),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '[${item.feedSource}]',
                        style: WyrdText.mono(
                          fontSize: 9,
                          color: WyrdColors.greenDim,
                        ).copyWith(letterSpacing: 1),
                      ),
                      Text(
                        _timeAgo(item.timestamp),
                        style: WyrdText.mono(
                          fontSize: 9,
                          color: WyrdColors.greenDim,
                        ).copyWith(letterSpacing: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.title,
                    style: WyrdText.mono(
                      fontSize: 12.5,
                      color: WyrdColors.mint,
                    ).copyWith(height: 1.4),
                  ),
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
