import 'package:flutter/material.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart' hide UserProfile;
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/holo.dart';

/// The person's own identity panel, stats grid, capability notes, and account actions. Ports
/// YouTab.tsx. Node's "owner-only capabilities" gating doesn't exist in this backend (real
/// browsing and the world-map tool are available to every account here, see
/// chat_tool_service.dart), so that panel reflects what's actually true instead of copying the
/// RN app's stale owner-gated text.
class YouTab extends StatefulWidget {
  const YouTab({super.key});

  @override
  State<YouTab> createState() => _YouTabState();
}

class _YouTabState extends State<YouTab> {
  late Future<(UserProfile, Mind, List<ConversationTurn>)> _data;

  @override
  void initState() {
    super.initState();
    _data = _load();
  }

  Future<(UserProfile, Mind, List<ConversationTurn>)> _load() async {
    final profile = await client.profile.getProfile();
    final mind = await client.mind.getMind();
    final history = await client.chat.getHistory();
    return (profile, mind, history);
  }

  Future<void> _refresh() async {
    setState(() => _data = _load());
    await _data;
  }

  Future<void> _export() async {
    try {
      final export = await client.account.exportData();
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: WyrdColors.panelBg,
          title: Text('YOUR DATA', style: WyrdText.mono(color: WyrdColors.green, letterSpacing: 1)),
          content: SingleChildScrollView(
            child: Text(
              'Email: ${export.email ?? '(none)'}\n'
              'Visits: ${export.visitCount}\n'
              'Facts known: ${export.facts.length}\n'
              'Conversation turns: ${export.conversation.length}',
              style: WyrdText.mono(color: WyrdColors.mint),
            ),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('CLOSE', style: WyrdText.mono(color: WyrdColors.green)))],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }

  Future<void> _deleteData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: WyrdColors.panelBg,
        title: Text('DELETE YOUR DATA?', style: WyrdText.mono(color: WyrdColors.danger, letterSpacing: 1)),
        content: Text(
          'This permanently wipes your profile facts and conversation history. Your sign-in itself is not affected.',
          style: WyrdText.mono(color: WyrdColors.mint),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('CANCEL', style: WyrdText.mono(color: WyrdColors.greenDim))),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('DELETE', style: WyrdText.mono(color: WyrdColors.danger))),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await client.account.deleteMyData();
      await _refresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your data has been deleted.')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WyrdColors.bg,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<(UserProfile, Mind, List<ConversationTurn>)>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator(color: WyrdColors.green));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Could not load profile: ${snapshot.error}', style: WyrdText.mono(color: WyrdColors.danger)));
            }
            final (profile, mind, history) = snapshot.data!;
            final days = DateTime.now().toUtc().difference(profile.firstSeen.toUtc()).inDays;
            final name = (profile.username ?? '—').toUpperCase();

            return ListView(
              padding: const EdgeInsets.all(14),
              children: [
                HoloFrame(
                  glow: 0.6,
                  beam: false,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: WyrdColors.green),
                            boxShadow: const [BoxShadow(color: WyrdColors.green, blurRadius: 12)],
                          ),
                          child: const Icon(Icons.person_outline, color: WyrdColors.green, size: 32),
                        ),
                        Text(name, style: WyrdText.display(fontSize: 40, shadowRadius: 14).copyWith(letterSpacing: 4)),
                        const SizedBox(height: 6),
                        Text('OWNER NODE · SESSION ${days}d', style: WyrdText.mono(fontSize: 10, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(width: (MediaQuery.of(context).size.width - 14 * 2 - 10) / 2, child: HoloReadout(label: 'PRIVATE THREAD', value: '${history.length} messages', glow: 0.4)),
                    SizedBox(width: (MediaQuery.of(context).size.width - 14 * 2 - 10) / 2, child: HoloReadout(label: 'FACTS ABOUT YOU', value: '${profile.facts.length} retained', glow: 0.4)),
                    SizedBox(width: (MediaQuery.of(context).size.width - 14 * 2 - 10) / 2, child: HoloReadout(label: 'SHARED MEMORY', value: '${mind.digest.totalTopics} topics', glow: 0.4)),
                    SizedBox(width: (MediaQuery.of(context).size.width - 14 * 2 - 10) / 2, child: HoloReadout(label: 'MEMBER SINCE', value: _dateOnly(profile.firstSeen), glow: 0.4)),
                  ],
                ),
                const SizedBox(height: 14),
                HoloFrame(
                  glow: 0.35,
                  beam: false,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AVAILABLE CAPABILITIES', style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim).copyWith(letterSpacing: 1)),
                        const SizedBox(height: 8),
                        _capRow('Real web browsing', 'EVERY ACCOUNT'),
                        _capRow('World map tool', 'EVERY ACCOUNT'),
                        _capRow('Camera / vision', 'EVERY ACCOUNT'),
                        _capRow('Code execution', 'NOT BUILT YET'),
                        Container(
                          margin: const EdgeInsets.only(top: 9),
                          padding: const EdgeInsets.only(top: 9),
                          decoration: const BoxDecoration(border: Border(top: BorderSide(color: WyrdColors.greenBorderDim))),
                          child: Text(
                            'Browsing runs in a fresh, anonymous headless-Chrome session each time — never logged in as anyone, never reused between turns.',
                            style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenBorderDim).copyWith(height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: HoloButton(label: 'EXPORT DATA', onPressed: _export)),
                    const SizedBox(width: 8),
                    Expanded(child: HoloButton(label: 'DELETE DATA', onPressed: _deleteData, tone: 'danger')),
                  ],
                ),
                const SizedBox(height: 8),
                HoloButton(label: 'LOGOUT', onPressed: () => client.authSessionManager.signOutDevice(), tone: 'danger'),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _capRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.mint)),
          Text(value, style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.green)),
        ],
      ),
    );
  }

  String _dateOnly(DateTime dt) {
    final local = dt.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }
}
