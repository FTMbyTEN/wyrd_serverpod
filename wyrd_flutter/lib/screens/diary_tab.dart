import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';

enum _Journal { diary, dreams }

/// WYRD's own diary and dream journal, segmented by kind. Ports DiaryTab.tsx (the REASONING
/// segment isn't ported -- server.js's human-readable reasoning-log file wasn't ported either,
/// see reasoning_service.dart on the backend).
class DiaryTab extends StatefulWidget {
  const DiaryTab({super.key});

  @override
  State<DiaryTab> createState() => _DiaryTabState();
}

class _DiaryTabState extends State<DiaryTab> {
  _Journal _journal = _Journal.diary;
  int _diaryIndex = 0;
  late Future<List<DiaryEntry>> _diaryEntries;
  late Future<List<DreamEntry>> _dreamEntries;

  @override
  void initState() {
    super.initState();
    _diaryEntries = client.diary.getEntries();
    _dreamEntries = client.dream.getEntries();
  }

  Future<void> _refresh() async {
    setState(() {
      _diaryEntries = client.diary.getEntries();
      _dreamEntries = client.dream.getEntries();
      _diaryIndex = 0;
    });
    await Future.wait([_diaryEntries, _dreamEntries]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WyrdColors.bg,
      child: Column(
        children: [
          _buildSegRow(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _journal == _Journal.diary ? _buildDiary(context) : _buildDreams(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Row(
        children: [
          for (final j in _Journal.values) ...[
            Expanded(child: _segButton(j)),
            if (j != _Journal.values.last) const SizedBox(width: 7),
          ],
        ],
      ),
    );
  }

  Widget _segButton(_Journal j) {
    final active = j == _journal;
    return InkWell(
      onTap: () => setState(() => _journal = j),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: active ? WyrdColors.green : WyrdColors.greenBorder),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          j == _Journal.diary ? 'DIARY' : 'DREAMS',
          style: WyrdText.mono(fontSize: 9.5, color: active ? WyrdColors.green : WyrdColors.greenDim).copyWith(letterSpacing: 1),
        ),
      ),
    );
  }

  Widget _buildDreams(BuildContext context) {
    return FutureBuilder<List<DreamEntry>>(
      future: _dreamEntries,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(color: WyrdColors.green));
        }
        final dreams = snapshot.data ?? [];
        return ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text('>_ DREAMS', style: WyrdText.display(fontSize: 20)),
            Text(
              'old memory fragments blending during idle stretches',
              style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenDim).copyWith(letterSpacing: 1),
            ),
            const SizedBox(height: 16),
            if (dreams.isEmpty)
              Text('no dreams yet — they only surface after a genuine idle stretch', style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.greenBorderDim)),
            for (final d in dreams)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  decoration: const BoxDecoration(border: Border(left: BorderSide(color: WyrdColors.greenBorder, width: 2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_timeOfDay(d.timestamp), style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text(d.content, style: WyrdText.mono(fontSize: 13.5, color: WyrdColors.mintBright).copyWith(fontStyle: FontStyle.italic, height: 1.7)),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDiary(BuildContext context) {
    return FutureBuilder<List<DiaryEntry>>(
      future: _diaryEntries,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(color: WyrdColors.green));
        }
        final entries = snapshot.data ?? [];
        final entry = entries.isNotEmpty ? entries[_diaryIndex.clamp(0, entries.length - 1)] : null;
        return Column(
          children: [
            if (entries.isNotEmpty)
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  children: [
                    for (var i = 0; i < entries.length; i++) _dateChip(entries[i], i),
                  ],
                ),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Text('>_ DIARY', style: WyrdText.display(fontSize: 20)),
                  Text(
                    'one real entry per day, written by WYRD itself',
                    style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenDim).copyWith(letterSpacing: 1),
                  ),
                  if (entry != null) ...[
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(entry.date, style: WyrdText.display(fontSize: 30)),
                        Text(
                          'WRITTEN ${_timeOfDay(entry.timestamp)} · UNPROMPTED',
                          style: WyrdText.mono(fontSize: 10, color: WyrdColors.greenDim).copyWith(letterSpacing: 1),
                        ),
                      ],
                    ),
                    const Divider(color: WyrdColors.greenBorder, height: 20),
                    Text(entry.content, style: WyrdText.mono(fontSize: 14, color: WyrdColors.mint).copyWith(height: 1.75)),
                    const SizedBox(height: 22),
                    Center(
                      child: Text(
                        'ENTRY ${_diaryIndex + 1} OF ${entries.length} RETAINED',
                        style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenBorderDim).copyWith(letterSpacing: 1),
                      ),
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('no diary entry yet — one gets written once real memory exists', style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.greenBorderDim)),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dateChip(DiaryEntry entry, int i) {
    final active = i == _diaryIndex;
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: InkWell(
        onTap: () => setState(() => _diaryIndex = i),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: active ? WyrdColors.green : WyrdColors.greenBorder),
            color: active ? WyrdColors.green.withValues(alpha: 0.08) : const Color(0xFF000F04).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(i == 0 ? 'TODAY' : entry.date, style: WyrdText.mono(fontSize: 10, color: active ? WyrdColors.green : WyrdColors.greenDim).copyWith(letterSpacing: 1)),
              Text(entry.date.length > 5 ? entry.date.substring(5) : entry.date, style: WyrdText.mono(fontSize: 9, color: active ? WyrdColors.green : WyrdColors.greenDim)),
            ],
          ),
        ),
      ),
    );
  }

  String _timeOfDay(DateTime dt) {
    final local = dt.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}
