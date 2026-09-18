import '../generated/protocol.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's takeGrowthSnapshot -- a periodic wall-clock snapshot of vocab/blocks/
/// digest/mood-stats, so growth is visible as a trend. Shared by the manual trigger and the
/// recurring FutureCall in growth_future_call.dart.
class GrowthService {
  static Future<GrowthSnapshot> takeSnapshot(Session session) async {
    final mind = await MindService.load(session);
    final blockCount = await MemoryBlock.db.count(session);
    final lexiconEntries = await LexiconEntry.db.find(session);
    final vocabCount = lexiconEntries.where((e) => e.understood).length;

    return await GrowthSnapshot.db.insertRow(
      session,
      GrowthSnapshot(
        timestamp: DateTime.now().toUtc(),
        vocabCount: vocabCount,
        blockCount: blockCount,
        digestPercent: mind.digest.percent,
        curiosity: mind.curiosity,
        confidence: mind.confidence,
      ),
    );
  }
}
