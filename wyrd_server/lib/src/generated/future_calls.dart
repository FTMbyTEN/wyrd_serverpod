/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../agent/agent_future_call.dart' as _ieeb687e;
import '../mind/diary_future_call.dart' as _i749zoke;
import '../mind/dream_future_call.dart' as _itvv5t5m;
import '../mind/feed_future_call.dart' as _irvvfdmu;
import '../mind/growth_future_call.dart' as _i0cg22dz;
import '../mind/lexicon_future_call.dart' as _ik7k7qni;
import '../mind/reasoning_future_call.dart' as _ipbl5psg;
import '../mind/self_config_future_call.dart' as _ishes48l;
import '../mind/self_question_future_call.dart' as _i51wt927;
import '../mind/sleep_future_call.dart' as _iunmcnpr;
import '../mind/synthesis_future_call.dart' as _i5fxv39a;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'AgentTickFutureCall': AgentTickFutureCall(),
      'DiaryCheckAndWriteFutureCall': DiaryCheckAndWriteFutureCall(),
      'DreamCheckIdleFutureCall': DreamCheckIdleFutureCall(),
      'FeedTickFutureCall': FeedTickFutureCall(),
      'GrowthTakeSnapshotFutureCall': GrowthTakeSnapshotFutureCall(),
      'LexiconTickFutureCall': LexiconTickFutureCall(),
      'ReasoningTickFutureCall': ReasoningTickFutureCall(),
      'SelfConfigTickFutureCall': SelfConfigTickFutureCall(),
      'SelfQuestionTickFutureCall': SelfQuestionTickFutureCall(),
      'SleepTickFutureCall': SleepTickFutureCall(),
      'SynthesisTickFutureCall': SynthesisTickFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final agent = _AgentFutureCallDispatcher(_invokeFutureCall);

  late final diary = _DiaryFutureCallDispatcher(_invokeFutureCall);

  late final dream = _DreamFutureCallDispatcher(_invokeFutureCall);

  late final feed = _FeedFutureCallDispatcher(_invokeFutureCall);

  late final growth = _GrowthFutureCallDispatcher(_invokeFutureCall);

  late final lexicon = _LexiconFutureCallDispatcher(_invokeFutureCall);

  late final reasoning = _ReasoningFutureCallDispatcher(_invokeFutureCall);

  late final selfConfig = _SelfConfigFutureCallDispatcher(_invokeFutureCall);

  late final selfQuestion = _SelfQuestionFutureCallDispatcher(
    _invokeFutureCall,
  );

  late final sleep = _SleepFutureCallDispatcher(_invokeFutureCall);

  late final synthesis = _SynthesisFutureCallDispatcher(_invokeFutureCall);
}

class _AgentFutureCallDispatcher {
  _AgentFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'AgentTickFutureCall',
      null,
    );
  }
}

class _DiaryFutureCallDispatcher {
  _DiaryFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> checkAndWrite() {
    return _invokeFutureCall(
      'DiaryCheckAndWriteFutureCall',
      null,
    );
  }
}

class _DreamFutureCallDispatcher {
  _DreamFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> checkIdle() {
    return _invokeFutureCall(
      'DreamCheckIdleFutureCall',
      null,
    );
  }
}

class _FeedFutureCallDispatcher {
  _FeedFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'FeedTickFutureCall',
      null,
    );
  }
}

class _GrowthFutureCallDispatcher {
  _GrowthFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> takeSnapshot() {
    return _invokeFutureCall(
      'GrowthTakeSnapshotFutureCall',
      null,
    );
  }
}

class _LexiconFutureCallDispatcher {
  _LexiconFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'LexiconTickFutureCall',
      null,
    );
  }
}

class _ReasoningFutureCallDispatcher {
  _ReasoningFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'ReasoningTickFutureCall',
      null,
    );
  }
}

class _SelfConfigFutureCallDispatcher {
  _SelfConfigFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'SelfConfigTickFutureCall',
      null,
    );
  }
}

class _SelfQuestionFutureCallDispatcher {
  _SelfQuestionFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'SelfQuestionTickFutureCall',
      null,
    );
  }
}

class _SleepFutureCallDispatcher {
  _SleepFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'SleepTickFutureCall',
      null,
    );
  }
}

class _SynthesisFutureCallDispatcher {
  _SynthesisFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick() {
    return _invokeFutureCall(
      'SynthesisTickFutureCall',
      null,
    );
  }
}

class AgentTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _ieeb687e.AgentFutureCall().tick(session);
  }
}

class DiaryCheckAndWriteFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _i749zoke.DiaryFutureCall().checkAndWrite(session);
  }
}

class DreamCheckIdleFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _itvv5t5m.DreamFutureCall().checkIdle(session);
  }
}

class FeedTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _irvvfdmu.FeedFutureCall().tick(session);
  }
}

class GrowthTakeSnapshotFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _i0cg22dz.GrowthFutureCall().takeSnapshot(session);
  }
}

class LexiconTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _ik7k7qni.LexiconFutureCall().tick(session);
  }
}

class ReasoningTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _ipbl5psg.ReasoningFutureCall().tick(session);
  }
}

class SelfConfigTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _ishes48l.SelfConfigFutureCall().tick(session);
  }
}

class SelfQuestionTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _i51wt927.SelfQuestionFutureCall().tick(session);
  }
}

class SleepTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _iunmcnpr.SleepFutureCall().tick(session);
  }
}

class SynthesisTickFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _i5fxv39a.SynthesisFutureCall().tick(session);
  }
}
