import 'package:flutter/material.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart' hide UserProfile;
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';

/// The person's own profile: what WYRD has learned about them, plus data export/delete and
/// sign-out.
class YouTab extends StatefulWidget {
  const YouTab({super.key});

  @override
  State<YouTab> createState() => _YouTabState();
}

class _YouTabState extends State<YouTab> {
  late Future<UserProfile> _profile;

  @override
  void initState() {
    super.initState();
    _profile = client.profile.getProfile();
  }

  Future<void> _refresh() async {
    setState(() => _profile = client.profile.getProfile());
    await _profile;
  }

  Future<void> _export() async {
    try {
      final export = await client.account.exportData();
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Your data'),
          content: SingleChildScrollView(
            child: Text(
              'Email: ${export.email ?? '(none)'}\n'
              'Visits: ${export.visitCount}\n'
              'Facts known: ${export.facts.length}\n'
              'Conversation turns: ${export.conversation.length}',
            ),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete your data?'),
        content: const Text(
          'This permanently wipes your profile facts and conversation history. '
          'Your sign-in itself is not affected.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
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
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<UserProfile>(
        future: _profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load profile: ${snapshot.error}'));
          }
          final profile = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profile.username ?? 'Unnamed wanderer', style: Theme.of(context).textTheme.titleMedium),
                      Text('${profile.visitCount} visits · first seen ${profile.firstSeen.toLocal()}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('WHAT WYRD KNOWS ABOUT YOU', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              if (profile.facts.isEmpty)
                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Nothing yet — the more you talk, the more it remembers.'))
              else
                for (final fact in profile.facts) ListTile(dense: true, leading: const Icon(Icons.circle, size: 8), title: Text(fact.text)),
              const SizedBox(height: 24),
              OutlinedButton.icon(onPressed: _export, icon: const Icon(Icons.download), label: const Text('Export my data')),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete my data'),
                style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => client.authSessionManager.signOutDevice(),
                icon: const Icon(Icons.logout),
                label: const Text('Sign out'),
              ),
            ],
          );
        },
      ),
    );
  }
}
