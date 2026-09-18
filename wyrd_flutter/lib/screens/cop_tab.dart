import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';

const _selfModifyMinGap = Duration(hours: 4); // mirrors the backend's own constant

bool _isFlagged(String verdict) => RegExp(r'\bflag', caseSensitive: false).hasMatch(verdict);

/// COP's independent oversight log -- reviews WYRD's self-modifications after the fact, cannot
/// veto anything. Ports CopTab.tsx.
class CopTab extends StatefulWidget {
  const CopTab({super.key});

  @override
  State<CopTab> createState() => _CopTabState();
}

enum _Filter { all, flagged }

class _CopTabState extends State<CopTab> {
  late Future<(SelfConfig, List<CopLogEntry>)> _data;
  _Filter _filter = _Filter.all;
  int? _openIndex;

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
    setState(() {
      _data = _load();
      _openIndex = null;
    });
    await _data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WyrdColors.bg,
      child: FutureBuilder<(SelfConfig, List<CopLogEntry>)>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: WyrdColors.green));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load COP log: ${snapshot.error}', style: WyrdText.mono(color: WyrdColors.danger)));
          }
          final (config, entries) = snapshot.data!;
          final flaggedCount = entries.where((e) => _isFlagged(e.verdict)).length;
          final shown = _filter == _Filter.all ? entries : entries.where((e) => _isFlagged(e.verdict)).toList();
          final lastChange = config.history.isNotEmpty ? config.history.last : null;
          final nextWindowAt = lastChange?.timestamp.add(_selfModifyMinGap);

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('>_ COP', style: WyrdText.display(fontSize: 20)),
                      const SizedBox(height: 2),
                      Text(
                        "an independent overseer reviewing WYRD's self-modifications — not WYRD itself. "
                        'It cannot veto anything. It can only tell you what happened.',
                        style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenDim).copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFF000F04).withValues(alpha: 0.75),
                    border: Border.all(color: WyrdColors.greenBorder),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LIVE BEHAVIOUR CONFIG', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                      const SizedBox(height: 8),
                      _configRow('reply_length_max', '${config.replyLengthMax}'),
                      _configRow('curiosity_level', config.curiosityLevel),
                      _configRow('tone_note', config.toneNote.isNotEmpty ? config.toneNote.substring(0, config.toneNote.length.clamp(0, 40)) : '(unset)'),
                      Container(
                        margin: const EdgeInsets.only(top: 9),
                        padding: const EdgeInsets.only(top: 9),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: WyrdColors.greenBorderDim))),
                        child: Text(
                          [
                            lastChange != null ? 'LAST CHANGE ${_timeAgo(lastChange.timestamp)}' : 'NO CHANGES YET',
                            if (nextWindowAt != null) ' · NEXT WINDOW ~${_countdown(nextWindowAt)}',
                          ].join(),
                          style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenBorderDim),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                  child: Row(
                    children: [
                      _filterButton('ALL', _Filter.all, WyrdColors.green),
                      const SizedBox(width: 8),
                      _filterButton('$flaggedCount FLAGGED', _Filter.flagged, WyrdColors.danger),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if (shown.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text('nothing here yet', style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.greenBorderDim)),
                        ),
                      for (var i = 0; i < shown.length; i++) _entryCard(shown[i], i),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'COP RUNS WITH NO SHARED CONTEXT WITH THE PROCESS IT REVIEWS',
                    textAlign: TextAlign.center,
                    style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenBorderDim).copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _configRow(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k, style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim)),
          Flexible(child: Text(v, textAlign: TextAlign.right, style: WyrdText.mono(fontSize: 12, color: WyrdColors.mint))),
        ],
      ),
    );
  }

  Widget _filterButton(String label, _Filter value, Color activeColor) {
    final active = _filter == value;
    return InkWell(
      onTap: () => setState(() => _filter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(border: Border.all(color: WyrdColors.greenBorder), borderRadius: BorderRadius.circular(2)),
        child: Text(label, style: WyrdText.mono(fontSize: 9.5, color: active ? activeColor : WyrdColors.greenDim).copyWith(letterSpacing: 1)),
      ),
    );
  }

  Widget _entryCard(CopLogEntry entry, int i) {
    final flagged = _isFlagged(entry.verdict);
    final edgeColor = flagged ? WyrdColors.danger : WyrdColors.greenBorder;
    final open = _openIndex == i;
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF000F04).withValues(alpha: 0.72),
        border: Border.all(color: WyrdColors.greenBorderDim),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _openIndex = open ? null : i),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border(left: BorderSide(color: edgeColor, width: 2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELF-MODIFICATION', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                      Text(_timeAgo(entry.timestamp), style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '${entry.configKey}  ${entry.oldValueJson} → ${entry.newValueJson}',
                          style: WyrdText.mono(fontSize: 12, color: WyrdColors.green),
                        ),
                      ),
                      Text(open ? '−' : '+', style: WyrdText.mono(fontSize: 14, color: WyrdColors.greenDim)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'COP: ${flagged ? 'FLAGGED' : 'REASONABLE'}',
                    style: WyrdText.mono(fontSize: 9.5, color: flagged ? WyrdColors.danger : WyrdColors.green).copyWith(letterSpacing: 1),
                  ),
                ],
              ),
            ),
          ),
          if (open)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 11),
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: WyrdColors.greenBorderDim))),
                    child: Text("WYRD'S REASON", style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                  ),
                  const SizedBox(height: 4),
                  Text(entry.reason, style: WyrdText.mono(fontSize: 12, color: WyrdColors.green).copyWith(height: 1.6)),
                  Container(
                    margin: const EdgeInsets.only(top: 13, left: 12),
                    padding: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(border: Border(left: BorderSide(color: edgeColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COP ASSESSMENT · WRITTEN AFTER THE FACT',
                          style: WyrdText.mono(fontSize: 9, color: flagged ? WyrdColors.danger : WyrdColors.mint).copyWith(letterSpacing: 1),
                        ),
                        const SizedBox(height: 4),
                        Text(entry.verdict, style: WyrdText.mono(fontSize: 12, color: WyrdColors.mint).copyWith(height: 1.6)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().toUtc().difference(dt.toUtc());
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  String _countdown(DateTime at) {
    final diff = at.difference(DateTime.now().toUtc());
    if (diff.isNegative) return 'now';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    return '${diff.inMinutes}m';
  }
}
