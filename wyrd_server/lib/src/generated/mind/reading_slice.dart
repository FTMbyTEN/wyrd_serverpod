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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;
import '../mind/reading_item.dart' as _iq1pc8u4;

abstract class ReadingSlice
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ReadingSlice._({
    required this.item,
    required this.text,
    required this.offset,
    required this.finished,
  });

  factory ReadingSlice({
    required _iq1pc8u4.ReadingItem item,
    required String text,
    required int offset,
    required bool finished,
  }) = _ReadingSliceImpl;

  factory ReadingSlice.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadingSlice(
      item: _i9sln91s.Protocol().deserialize<_iq1pc8u4.ReadingItem>(
        jsonSerialization['item'],
      ),
      text: jsonSerialization['text'] as String,
      offset: jsonSerialization['offset'] as int,
      finished: _is.BoolJsonExtension.fromJson(jsonSerialization['finished']),
    );
  }

  _iq1pc8u4.ReadingItem item;

  String text;

  int offset;

  bool finished;

  /// Returns a shallow copy of this [ReadingSlice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReadingSlice copyWith({
    _iq1pc8u4.ReadingItem? item,
    String? text,
    int? offset,
    bool? finished,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingSlice',
      'item': item.toJson(),
      'text': text,
      'offset': offset,
      'finished': finished,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadingSlice',
      'item': item.toJsonForProtocol(),
      'text': text,
      'offset': offset,
      'finished': finished,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ReadingSliceImpl extends ReadingSlice {
  _ReadingSliceImpl({
    required _iq1pc8u4.ReadingItem item,
    required String text,
    required int offset,
    required bool finished,
  }) : super._(
         item: item,
         text: text,
         offset: offset,
         finished: finished,
       );

  /// Returns a shallow copy of this [ReadingSlice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReadingSlice copyWith({
    _iq1pc8u4.ReadingItem? item,
    String? text,
    int? offset,
    bool? finished,
  }) {
    return ReadingSlice(
      item: item ?? this.item.copyWith(),
      text: text ?? this.text,
      offset: offset ?? this.offset,
      finished: finished ?? this.finished,
    );
  }
}
