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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wyrd_client/src/protocol/greetings/greeting.dart' as _i06jqtw9;
import 'package:wyrd_client/src/protocol/mind/chat_reply.dart' as _is592ckh;
import 'package:wyrd_client/src/protocol/mind/concept_graph.dart' as _i3megjmi;
import 'package:wyrd_client/src/protocol/mind/conversation_turn.dart'
    as _ie2belbc;
import 'package:wyrd_client/src/protocol/mind/cop_log_entry.dart' as _iudx1gwn;
import 'package:wyrd_client/src/protocol/mind/curriculum_status.dart'
    as _i8wsch3q;
import 'package:wyrd_client/src/protocol/mind/diary_entry.dart' as _iz65e3oe;
import 'package:wyrd_client/src/protocol/mind/dream_entry.dart' as _igmpa92d;
import 'package:wyrd_client/src/protocol/mind/feed_ingest.dart' as _ipp6qnor;
import 'package:wyrd_client/src/protocol/mind/growth_snapshot.dart'
    as _ikfbn3bp;
import 'package:wyrd_client/src/protocol/mind/lexicon_entry.dart' as _izjkulc1;
import 'package:wyrd_client/src/protocol/mind/lexicon_stats.dart' as _i85rewab;
import 'package:wyrd_client/src/protocol/mind/memory_block.dart' as _ij6z6xwm;
import 'package:wyrd_client/src/protocol/mind/mind.dart' as _i45d730y;
import 'package:wyrd_client/src/protocol/mind/self_config.dart' as _i2gzn8r6;
import 'package:wyrd_client/src/protocol/mind/self_config_change.dart'
    as _ifqisoc8;
import 'package:wyrd_client/src/protocol/mind/user_profile.dart' as _ig38dtlp;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_i06jqtw9.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i06jqtw9.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Ports /api/chat from server.js (the core reply path -- see chat_service.dart for what's
/// intentionally not ported yet). Requires login, matching Node's requireAuth. Node's
/// per-user rate limiting (30 messages/min) is not ported yet either.
/// {@category Endpoint}
class EndpointChat extends _isc.EndpointRef {
  EndpointChat(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  _ida.Future<_is592ckh.ChatReply> sendMessage(String text) =>
      caller.callServerEndpoint<_is592ckh.ChatReply>(
        'chat',
        'sendMessage',
        {'text': text},
      );

  _ida.Future<List<_ie2belbc.ConversationTurn>> getHistory({int? limit}) =>
      caller.callServerEndpoint<List<_ie2belbc.ConversationTurn>>(
        'chat',
        'getHistory',
        {'limit': limit},
      );
}

/// Ports /api/curriculum from server.js. Public/unauthenticated, matching Node.
/// {@category Endpoint}
class EndpointCurriculum extends _isc.EndpointRef {
  EndpointCurriculum(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'curriculum';

  _ida.Future<_i8wsch3q.CurriculumStatus> getStatus() =>
      caller.callServerEndpoint<_i8wsch3q.CurriculumStatus>(
        'curriculum',
        'getStatus',
        {},
      );
}

/// Ports /api/diary and /api/diary/trigger from server.js. Public/unauthenticated, matching
/// Node -- WYRD's diary is a single shared journal, not per-user.
/// {@category Endpoint}
class EndpointDiary extends _isc.EndpointRef {
  EndpointDiary(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'diary';

  _ida.Future<List<_iz65e3oe.DiaryEntry>> getEntries({int? limit}) =>
      caller.callServerEndpoint<List<_iz65e3oe.DiaryEntry>>(
        'diary',
        'getEntries',
        {'limit': limit},
      );

  _ida.Future<_iz65e3oe.DiaryEntry> trigger() =>
      caller.callServerEndpoint<_iz65e3oe.DiaryEntry>(
        'diary',
        'trigger',
        {},
      );
}

/// Ports /api/dreams and /api/dreams/trigger from server.js. Public/unauthenticated, matching
/// Node. See dream_service.dart for what's intentionally not ported yet (automatic idle-tick
/// scheduling, which needs real chat-activity tracking).
/// {@category Endpoint}
class EndpointDream extends _isc.EndpointRef {
  EndpointDream(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dream';

  _ida.Future<List<_igmpa92d.DreamEntry>> getEntries({int? limit}) =>
      caller.callServerEndpoint<List<_igmpa92d.DreamEntry>>(
        'dream',
        'getEntries',
        {'limit': limit},
      );

  _ida.Future<_igmpa92d.DreamEntry?> trigger() =>
      caller.callServerEndpoint<_igmpa92d.DreamEntry?>(
        'dream',
        'trigger',
        {},
      );
}

/// Ports /api/feed/recent and /api/feed/trigger from server.js. Public/unauthenticated,
/// matching Node. /api/feed/next (nextTickAt/cycleMs) is not ported -- it depended on Node's
/// TURBO_FACTOR speed-scaling, which isn't ported either (see feed_future_call.dart).
/// {@category Endpoint}
class EndpointFeed extends _isc.EndpointRef {
  EndpointFeed(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'feed';

  _ida.Future<List<_ipp6qnor.FeedIngest>> getRecent() =>
      caller.callServerEndpoint<List<_ipp6qnor.FeedIngest>>(
        'feed',
        'getRecent',
        {},
      );

  _ida.Future<bool> trigger() => caller.callServerEndpoint<bool>(
    'feed',
    'trigger',
    {},
  );
}

/// Ports /api/growth (read) from server.js. Public/unauthenticated, matching Node. There is
/// no manual /trigger for growth in Node -- snapshots are purely wall-clock (see
/// growth_future_call.dart) -- so this endpoint is read-only.
/// {@category Endpoint}
class EndpointGrowth extends _isc.EndpointRef {
  EndpointGrowth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'growth';

  _ida.Future<List<_ikfbn3bp.GrowthSnapshot>> getSnapshots({int? limit}) =>
      caller.callServerEndpoint<List<_ikfbn3bp.GrowthSnapshot>>(
        'growth',
        'getSnapshots',
        {'limit': limit},
      );
}

/// Ports the read side of server.js's /api/lexicon/stats and /api/lexicon/word/:word.
/// /api/lexicon/trigger (the LLM-backed word-learning tick) is not ported yet — it belongs
/// with the rest of the autonomous engine, not this read-only batch. Public/unauthenticated,
/// matching Node.
/// {@category Endpoint}
class EndpointLexicon extends _isc.EndpointRef {
  EndpointLexicon(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'lexicon';

  _ida.Future<_i85rewab.LexiconStats> getStats() =>
      caller.callServerEndpoint<_i85rewab.LexiconStats>(
        'lexicon',
        'getStats',
        {},
      );

  _ida.Future<_izjkulc1.LexiconEntry?> getWord(String word) =>
      caller.callServerEndpoint<_izjkulc1.LexiconEntry?>(
        'lexicon',
        'getWord',
        {'word': word},
      );
}

/// Ports /api/memory and /api/concepts from server.js. Public/unauthenticated, matching Node.
/// Node trims memory.json to the last 5000 blocks on every write (MAX_BLOCKS); rather than
/// enforce that at write time here too, both reads below just cap the query to the newest 5000
/// rows, so the trimming behavior is equivalent without needing a separate cleanup job yet.
/// {@category Endpoint}
class EndpointMemory extends _isc.EndpointRef {
  EndpointMemory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'memory';

  _ida.Future<List<_ij6z6xwm.MemoryBlock>> getMemory() =>
      caller.callServerEndpoint<List<_ij6z6xwm.MemoryBlock>>(
        'memory',
        'getMemory',
        {},
      );

  _ida.Future<_i3megjmi.ConceptGraph> getConcepts() =>
      caller.callServerEndpoint<_i3megjmi.ConceptGraph>(
        'memory',
        'getConcepts',
        {},
      );
}

/// Real GET /mind, backed by the persisted singleton row (see [MindService]) instead of the
/// earlier hardcoded placeholder. Public/unauthenticated, matching server.js's /api/mind.
/// {@category Endpoint}
class EndpointMind extends _isc.EndpointRef {
  EndpointMind(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mind';

  _ida.Future<_i45d730y.Mind> getMind() =>
      caller.callServerEndpoint<_i45d730y.Mind>(
        'mind',
        'getMind',
        {},
      );
}

/// Ports /api/profile + the getProfile/touchProfileVisit pair from server.js. Node touched the
/// visit counter server-side at register/login; here that hook doesn't exist (the built-in email
/// IDP endpoints aren't ours to modify), so the Flutter client calls [touchVisit] right after a
/// successful sign-in instead.
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  _ida.Future<_ig38dtlp.UserProfile> getProfile() =>
      caller.callServerEndpoint<_ig38dtlp.UserProfile>(
        'profile',
        'getProfile',
        {},
      );

  _ida.Future<_ig38dtlp.UserProfile> touchVisit() =>
      caller.callServerEndpoint<_ig38dtlp.UserProfile>(
        'profile',
        'touchVisit',
        {},
      );

  _ida.Future<_ig38dtlp.UserProfile> setUsername(String username) =>
      caller.callServerEndpoint<_ig38dtlp.UserProfile>(
        'profile',
        'setUsername',
        {'username': username},
      );
}

/// Ports /api/reasoning/trigger from server.js. Public/unauthenticated, matching Node.
/// GET /api/reasoning (the human-readable .md log) is not ported -- see reasoning_service.dart.
/// {@category Endpoint}
class EndpointReasoning extends _isc.EndpointRef {
  EndpointReasoning(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reasoning';

  _ida.Future<bool> trigger() => caller.callServerEndpoint<bool>(
    'reasoning',
    'trigger',
    {},
  );
}

/// Ports /api/self-config, /api/cop-log, and /api/self-modify/trigger from server.js.
/// Public/unauthenticated, matching Node.
/// {@category Endpoint}
class EndpointSelfConfig extends _isc.EndpointRef {
  EndpointSelfConfig(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'selfConfig';

  _ida.Future<_i2gzn8r6.SelfConfig> getConfig() =>
      caller.callServerEndpoint<_i2gzn8r6.SelfConfig>(
        'selfConfig',
        'getConfig',
        {},
      );

  _ida.Future<List<_iudx1gwn.CopLogEntry>> getCopLog({int? limit}) =>
      caller.callServerEndpoint<List<_iudx1gwn.CopLogEntry>>(
        'selfConfig',
        'getCopLog',
        {'limit': limit},
      );

  _ida.Future<_ifqisoc8.SelfConfigChange?> trigger() =>
      caller.callServerEndpoint<_ifqisoc8.SelfConfigChange?>(
        'selfConfig',
        'trigger',
        {},
      );
}

/// Ports /api/self/trigger from server.js. Public/unauthenticated, matching Node.
/// {@category Endpoint}
class EndpointSelfQuestion extends _isc.EndpointRef {
  EndpointSelfQuestion(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'selfQuestion';

  _ida.Future<bool> trigger() => caller.callServerEndpoint<bool>(
    'selfQuestion',
    'trigger',
    {},
  );
}

/// Ports /api/synthesis/trigger from server.js. Public/unauthenticated, matching Node.
/// {@category Endpoint}
class EndpointSynthesis extends _isc.EndpointRef {
  EndpointSynthesis(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'synthesis';

  _ida.Future<bool> trigger() => caller.callServerEndpoint<bool>(
    'synthesis',
    'trigger',
    {},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    greeting = EndpointGreeting(this);
    chat = EndpointChat(this);
    curriculum = EndpointCurriculum(this);
    diary = EndpointDiary(this);
    dream = EndpointDream(this);
    feed = EndpointFeed(this);
    growth = EndpointGrowth(this);
    lexicon = EndpointLexicon(this);
    memory = EndpointMemory(this);
    mind = EndpointMind(this);
    profile = EndpointProfile(this);
    reasoning = EndpointReasoning(this);
    selfConfig = EndpointSelfConfig(this);
    selfQuestion = EndpointSelfQuestion(this);
    synthesis = EndpointSynthesis(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointGreeting greeting;

  late final EndpointChat chat;

  late final EndpointCurriculum curriculum;

  late final EndpointDiary diary;

  late final EndpointDream dream;

  late final EndpointFeed feed;

  late final EndpointGrowth growth;

  late final EndpointLexicon lexicon;

  late final EndpointMemory memory;

  late final EndpointMind mind;

  late final EndpointProfile profile;

  late final EndpointReasoning reasoning;

  late final EndpointSelfConfig selfConfig;

  late final EndpointSelfQuestion selfQuestion;

  late final EndpointSynthesis synthesis;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'greeting': greeting,
    'chat': chat,
    'curriculum': curriculum,
    'diary': diary,
    'dream': dream,
    'feed': feed,
    'growth': growth,
    'lexicon': lexicon,
    'memory': memory,
    'mind': mind,
    'profile': profile,
    'reasoning': reasoning,
    'selfConfig': selfConfig,
    'selfQuestion': selfQuestion,
    'synthesis': synthesis,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
