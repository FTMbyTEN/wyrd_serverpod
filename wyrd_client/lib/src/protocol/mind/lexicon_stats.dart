/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wyrd_client/src/protocol/protocol.dart' as _i2pladzn;
import '../mind/lexicon_word_summary.dart' as _iqsf86sl;

abstract class LexiconStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LexiconStats._({
    required this.learned,
    required this.attempted,
    required this.recentWords,
  });

  factory LexiconStats({
    required int learned,
    required int attempted,
    required List<_iqsf86sl.LexiconWordSummary> recentWords,
  }) = _LexiconStatsImpl;

  factory LexiconStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return LexiconStats(
      learned: jsonSerialization['learned'] as int,
      attempted: jsonSerialization['attempted'] as int,
      recentWords: _i2pladzn.Protocol()
          .deserialize<List<_iqsf86sl.LexiconWordSummary>>(
            jsonSerialization['recentWords'],
          ),
    );
  }

  int learned;

  int attempted;

  List<_iqsf86sl.LexiconWordSummary> recentWords;

  /// Returns a shallow copy of this [LexiconStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LexiconStats copyWith({
    int? learned,
    int? attempted,
    List<_iqsf86sl.LexiconWordSummary>? recentWords,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LexiconStats',
      'learned': learned,
      'attempted': attempted,
      'recentWords': recentWords.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LexiconStats',
      'learned': learned,
      'attempted': attempted,
      'recentWords': recentWords.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LexiconStatsImpl extends LexiconStats {
  _LexiconStatsImpl({
    required int learned,
    required int attempted,
    required List<_iqsf86sl.LexiconWordSummary> recentWords,
  }) : super._(
         learned: learned,
         attempted: attempted,
         recentWords: recentWords,
       );

  /// Returns a shallow copy of this [LexiconStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LexiconStats copyWith({
    int? learned,
    int? attempted,
    List<_iqsf86sl.LexiconWordSummary>? recentWords,
  }) {
    return LexiconStats(
      learned: learned ?? this.learned,
      attempted: attempted ?? this.attempted,
      recentWords:
          recentWords ?? this.recentWords.map((e0) => e0.copyWith()).toList(),
    );
  }
}
