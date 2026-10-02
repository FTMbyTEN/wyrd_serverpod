import 'dart:convert';

import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/brain_map_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given WYRD\'s real brain map', (sessionBuilder, endpoints) {
    setUp(BrainMapService.forget);

    Future<void> synapse(String a, String b, double w) async {
      final now = DateTime.now().toUtc();
      await Synapse.db.insertRow(sessionBuilder.build(), Synapse(a: a, b: b, weight: w, fires: 1, lastFired: now));
    }

    test('neurons and synapses come from the real network, and firings run along drawn synapses', () async {
      await synapse('knowledge', 'retrieval', 0.9);
      await synapse('retrieval', 'agents', 0.7);
      await synapse('rain', 'cloud', 0.05);
      await ReasoningNote.db.insertRow(sessionBuilder.build(), ReasoningNote(
        timestamp: DateTime.now().toUtc(), kind: 'firing',
        content: jsonEncode({'seed': 'knowledge', 'path': ['knowledge', 'retrieval', 'agents']}),
      ));

      final map = await endpoints.brain.getMap(sessionBuilder);
      final ids = map.neurons.map((n) => n.id).toSet();
      expect(ids, containsAll(['knowledge', 'retrieval', 'agents', 'rain', 'cloud']));
      expect(map.neurons.first.id, 'retrieval'); // the most connected comes first
      expect(map.firings.single.path, ['knowledge', 'retrieval', 'agents']);
      final drawn = map.synapses.map((s) => '${s.a}-${s.b}').toSet();
      expect(drawn, containsAll(['knowledge-retrieval', 'retrieval-agents']));
    });

    test('an empty mind gives an empty brain, not an error', () async {
      final map = await endpoints.brain.getMap(sessionBuilder);
      expect(map.neurons, isEmpty);
      expect(map.firings, isEmpty);
    });
  });
}
