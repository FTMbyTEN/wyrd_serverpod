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
import 'package:wyrd_client/src/protocol/agent/agent_step.dart' as _i6j2kf10;
import 'package:wyrd_client/src/protocol/agent/agent_task.dart' as _i2gts05o;
import 'package:wyrd_client/src/protocol/drone/drone_mission.dart' as _ik7hqtb1;
import 'package:wyrd_client/src/protocol/drone/drone_plan_result.dart'
    as _ibjo0dmj;
import 'package:wyrd_client/src/protocol/drone/drone_state.dart' as _i9y70wfa;
import 'package:wyrd_client/src/protocol/games/game_match.dart' as _io9n6mg3;
import 'package:wyrd_client/src/protocol/games/player_rating.dart' as _ibpm8r25;
import 'package:wyrd_client/src/protocol/greetings/greeting.dart' as _i06jqtw9;
import 'package:wyrd_client/src/protocol/mind/account_export.dart' as _izg4k2n4;
import 'package:wyrd_client/src/protocol/mind/alert_note.dart' as _i4c7ehki;
import 'package:wyrd_client/src/protocol/mind/brain_map.dart' as _isea6qhw;
import 'package:wyrd_client/src/protocol/mind/chat_reply.dart' as _is592ckh;
import 'package:wyrd_client/src/protocol/mind/concept_detail.dart' as _iea588cs;
import 'package:wyrd_client/src/protocol/mind/concept_example.dart'
    as _ihzd15h8;
import 'package:wyrd_client/src/protocol/mind/concept_graph.dart' as _i3megjmi;
import 'package:wyrd_client/src/protocol/mind/conversation_turn.dart'
    as _ie2belbc;
import 'package:wyrd_client/src/protocol/mind/cop_log_entry.dart' as _iudx1gwn;
import 'package:wyrd_client/src/protocol/mind/country_detail.dart' as _i3byid52;
import 'package:wyrd_client/src/protocol/mind/curriculum_status.dart'
    as _i8wsch3q;
import 'package:wyrd_client/src/protocol/mind/diary_entry.dart' as _iz65e3oe;
import 'package:wyrd_client/src/protocol/mind/document_upload.dart'
    as _ineqvy2e;
import 'package:wyrd_client/src/protocol/mind/dream_entry.dart' as _igmpa92d;
import 'package:wyrd_client/src/protocol/mind/feed_ingest.dart' as _ipp6qnor;
import 'package:wyrd_client/src/protocol/mind/filter_report.dart' as _iikqy3kr;
import 'package:wyrd_client/src/protocol/mind/gate_shape.dart' as _id49marq;
import 'package:wyrd_client/src/protocol/mind/growth_snapshot.dart'
    as _ikfbn3bp;
import 'package:wyrd_client/src/protocol/mind/judgement_report.dart'
    as _iirmh60o;
import 'package:wyrd_client/src/protocol/mind/learning_stats.dart' as _i41i9jez;
import 'package:wyrd_client/src/protocol/mind/lexicon_entry.dart' as _izjkulc1;
import 'package:wyrd_client/src/protocol/mind/lexicon_stats.dart' as _i85rewab;
import 'package:wyrd_client/src/protocol/mind/memory_block.dart' as _ij6z6xwm;
import 'package:wyrd_client/src/protocol/mind/mind.dart' as _i45d730y;
import 'package:wyrd_client/src/protocol/mind/neural_network.dart' as _idlunu5o;
import 'package:wyrd_client/src/protocol/mind/quiz_question.dart' as _i0wujsep;
import 'package:wyrd_client/src/protocol/mind/quiz_stats.dart' as _iopav0ef;
import 'package:wyrd_client/src/protocol/mind/reading_item.dart' as _iqdaexua;
import 'package:wyrd_client/src/protocol/mind/reading_slice.dart' as _ihcpac93;
import 'package:wyrd_client/src/protocol/mind/reasoning_note.dart' as _ii1bv1u2;
import 'package:wyrd_client/src/protocol/mind/self_config.dart' as _i2gzn8r6;
import 'package:wyrd_client/src/protocol/mind/self_config_change.dart'
    as _ifqisoc8;
import 'package:wyrd_client/src/protocol/mind/sighting.dart' as _ijttkw09;
import 'package:wyrd_client/src/protocol/mind/system_status.dart' as _i97zx8uk;
import 'package:wyrd_client/src/protocol/mind/topic_info.dart' as _il2rvv3i;
import 'package:wyrd_client/src/protocol/mind/trust_report.dart' as _iv8ct9z9;
import 'package:wyrd_client/src/protocol/mind/user_document.dart' as _imstbkek;
import 'package:wyrd_client/src/protocol/mind/user_profile.dart' as _ig38dtlp;
import 'package:wyrd_client/src/protocol/mind/work_hit.dart' as _iv7njdft;
import 'package:wyrd_client/src/protocol/mind/work_part_info.dart' as _iepby0e1;
import 'package:wyrd_client/src/protocol/mind/world_country.dart' as _iakrxk0g;
import 'protocol.dart' as _il2as5qe;

/// WYRD's agent tasks: give it a goal, watch it work, approve or decline what it wants to do.
/// {@category Endpoint}
class EndpointAgent extends _isc.EndpointRef {
  EndpointAgent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'agent';

  /// A new task. [everyHours]: null for once, otherwise it runs again on that schedule.
  _ida.Future<_i2gts05o.AgentTask> create(
    String goal,
    int? everyHours,
  ) => caller.callServerEndpoint<_i2gts05o.AgentTask>(
    'agent',
    'create',
    {
      'goal': goal,
      'everyHours': everyHours,
    },
  );

  _ida.Future<List<_i2gts05o.AgentTask>> mine() =>
      caller.callServerEndpoint<List<_i2gts05o.AgentTask>>(
        'agent',
        'mine',
        {},
      );

  _ida.Future<List<_i6j2kf10.AgentStep>> steps(int taskId) =>
      caller.callServerEndpoint<List<_i6j2kf10.AgentStep>>(
        'agent',
        'steps',
        {'taskId': taskId},
      );

  _ida.Future<_i2gts05o.AgentTask> decide(
    int taskId,
    bool approve,
  ) => caller.callServerEndpoint<_i2gts05o.AgentTask>(
    'agent',
    'decide',
    {
      'taskId': taskId,
      'approve': approve,
    },
  );

  _ida.Future<_i2gts05o.AgentTask> cancel(int taskId) =>
      caller.callServerEndpoint<_i2gts05o.AgentTask>(
        'agent',
        'cancel',
        {'taskId': taskId},
      );

  _ida.Future<_i2gts05o.AgentTask> runNow(int taskId) =>
      caller.callServerEndpoint<_i2gts05o.AgentTask>(
        'agent',
        'runNow',
        {'taskId': taskId},
      );

  _ida.Future<_i2gts05o.AgentTask> markRead(int taskId) =>
      caller.callServerEndpoint<_i2gts05o.AgentTask>(
        'agent',
        'markRead',
        {'taskId': taskId},
      );
}

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

/// What the drone bridge (drone/bridge in the consciousness-bot repo) calls. The bridge isn't a
/// user, so instead of a login it presents the shared secret set with
/// `scloud password set droneBridgeToken <long random value>` (same value in the bridge's
/// WYRD_BRIDGE_TOKEN). Without that secret configured, every call is refused.
/// {@category Endpoint}
class EndpointDroneBridge extends _isc.EndpointRef {
  EndpointDroneBridge(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'droneBridge';

  /// Upserts the drone's latest telemetry and hands back the oldest waiting mission (marking it
  /// sent), or null. Called every ~2s.
  _ida.Future<_ik7hqtb1.DroneMission?> report(
    String token,
    _i9y70wfa.DroneState state,
  ) => caller.callServerEndpoint<_ik7hqtb1.DroneMission?>(
    'droneBridge',
    'report',
    {
      'token': token,
      'state': state,
    },
  );

  /// The bridge reporting what happened to a mission: running, done, aborted, or rejected (its
  /// own safety check refused it).
  _ida.Future<void> missionUpdate(
    String token,
    int missionId,
    String status,
    String? reason,
  ) => caller.callServerEndpoint<void>(
    'droneBridge',
    'missionUpdate',
    {
      'token': token,
      'missionId': missionId,
      'status': status,
      'reason': reason,
    },
  );
}

/// The app's side of the drone, for operators only -- the accounts whose emails are set with
/// `scloud password set droneOperatorEmail a@example.com,b@example.com`. Nobody else can watch, plan
/// or abort, and the app doesn't show them the drone at all. The logic lives in DroneService, shared
/// with WYRD's chat tool.
/// {@category Endpoint}
class EndpointDrone extends _isc.EndpointRef {
  EndpointDrone(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'drone';

  _ida.Future<_i9y70wfa.DroneState?> getState() =>
      caller.callServerEndpoint<_i9y70wfa.DroneState?>(
        'drone',
        'getState',
        {},
      );

  _ida.Future<List<_ik7hqtb1.DroneMission>> getMissions({required int limit}) =>
      caller.callServerEndpoint<List<_ik7hqtb1.DroneMission>>(
        'drone',
        'getMissions',
        {'limit': limit},
      );

  _ida.Future<bool> isOperator() => caller.callServerEndpoint<bool>(
    'drone',
    'isOperator',
    {},
  );

  /// WYRD plans a flight from [instruction]; see DroneService.plan.
  _ida.Future<_ibjo0dmj.DronePlanResult> plan(String instruction) =>
      caller.callServerEndpoint<_ibjo0dmj.DronePlanResult>(
        'drone',
        'plan',
        {'instruction': instruction},
      );

  /// Cancels whatever is flying and brings the drone home. Always allowed for the operator.
  _ida.Future<_ik7hqtb1.DroneMission> abort() =>
      caller.callServerEndpoint<_ik7hqtb1.DroneMission>(
        'drone',
        'abort',
        {},
      );
}

/// Games: against WYRD (chess, Connect Four, Reversi, Tic-tac-toe) and between players, with
/// ratings and a leaderboard per game. Every game sent back carries viewerSide: the side of the
/// person asking, so the app knows which way round to draw the board.
/// {@category Endpoint}
class EndpointGames extends _isc.EndpointRef {
  EndpointGames(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'games';

  _ida.Future<List<_ibpm8r25.PlayerRating>> myRatings() =>
      caller.callServerEndpoint<List<_ibpm8r25.PlayerRating>>(
        'games',
        'myRatings',
        {},
      );

  _ida.Future<List<_ibpm8r25.PlayerRating>> leaderboard(String game) =>
      caller.callServerEndpoint<List<_ibpm8r25.PlayerRating>>(
        'games',
        'leaderboard',
        {'game': game},
      );

  /// The game against WYRD in progress for [game], if any.
  _ida.Future<_io9n6mg3.GameMatch?> active(String game) =>
      caller.callServerEndpoint<_io9n6mg3.GameMatch?>(
        'games',
        'active',
        {'game': game},
      );

  /// A new game against WYRD. [side]: 'w', 'b' or 'random'.
  _ida.Future<_io9n6mg3.GameMatch> start(
    String game,
    String side,
  ) => caller.callServerEndpoint<_io9n6mg3.GameMatch>(
    'games',
    'start',
    {
      'game': game,
      'side': side,
    },
  );

  /// A move in any game: chess "e2e4" (or "e7e8q"), Connect Four a column "0".."6", Tic-tac-toe a
  /// square "0".."8", Reversi a square "0".."63".
  _ida.Future<_io9n6mg3.GameMatch> move(
    int matchId,
    String move,
  ) => caller.callServerEndpoint<_io9n6mg3.GameMatch>(
    'games',
    'move',
    {
      'matchId': matchId,
      'move': move,
    },
  );

  _ida.Future<_io9n6mg3.GameMatch> resign(int matchId) =>
      caller.callServerEndpoint<_io9n6mg3.GameMatch>(
        'games',
        'resign',
        {'matchId': matchId},
      );

  _ida.Future<_io9n6mg3.GameMatch> startChess(String side) =>
      caller.callServerEndpoint<_io9n6mg3.GameMatch>(
        'games',
        'startChess',
        {'side': side},
      );

  _ida.Future<_io9n6mg3.GameMatch> moveChess(
    int matchId,
    String from,
    String to,
    String? promotion,
  ) => caller.callServerEndpoint<_io9n6mg3.GameMatch>(
    'games',
    'moveChess',
    {
      'matchId': matchId,
      'from': from,
      'to': to,
      'promotion': promotion,
    },
  );

  _ida.Future<_io9n6mg3.GameMatch> challenge(String game) =>
      caller.callServerEndpoint<_io9n6mg3.GameMatch>(
        'games',
        'challenge',
        {'game': game},
      );

  _ida.Future<List<_io9n6mg3.GameMatch>> openChallenges(String game) =>
      caller.callServerEndpoint<List<_io9n6mg3.GameMatch>>(
        'games',
        'openChallenges',
        {'game': game},
      );

  _ida.Future<_io9n6mg3.GameMatch> accept(int matchId) =>
      caller.callServerEndpoint<_io9n6mg3.GameMatch>(
        'games',
        'accept',
        {'matchId': matchId},
      );

  _ida.Future<void> cancel(int matchId) => caller.callServerEndpoint<void>(
    'games',
    'cancel',
    {'matchId': matchId},
  );

  _ida.Future<List<_io9n6mg3.GameMatch>> myPvp() =>
      caller.callServerEndpoint<List<_io9n6mg3.GameMatch>>(
        'games',
        'myPvp',
        {},
      );

  /// The game if it changed since [version], else null -- answered from memory almost always.
  _ida.Future<_io9n6mg3.GameMatch?> poll(
    int matchId,
    int version,
  ) => caller.callServerEndpoint<_io9n6mg3.GameMatch?>(
    'games',
    'poll',
    {
      'matchId': matchId,
      'version': version,
    },
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

/// Ports /api/account/export and /api/account/delete from server.js. Node's delete required
/// re-entering the password and removed the login credential itself, not just app data --
/// with Serverpod's built-in email auth, credential deletion isn't something this project's
/// own endpoints can safely do (that lives inside serverpod_auth_idp_server, with no public
/// self-service delete-account method exposed), so [deleteMyData] wipes everything this app
/// owns about the person (profile, conversations, photos, memories and answers learned from them,
/// the conversation thread) but leaves
/// their login credential intact -- a real, documented gap versus Node's full account wipe.
/// {@category Endpoint}
class EndpointAccount extends _isc.EndpointRef {
  EndpointAccount(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _ida.Future<_izg4k2n4.AccountExport> exportData() =>
      caller.callServerEndpoint<_izg4k2n4.AccountExport>(
        'account',
        'exportData',
        {},
      );

  _ida.Future<void> deleteMyData() => caller.callServerEndpoint<void>(
    'account',
    'deleteMyData',
    {},
  );
}

/// Ports /api/alerts from server.js. Not a stored feature -- a synthesis of events already
/// logged elsewhere (diary, dreams, COP log, digest milestones), newest first. Public, like Node.
/// {@category Endpoint}
class EndpointAlerts extends _isc.EndpointRef {
  EndpointAlerts(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'alerts';

  _ida.Future<List<_i4c7ehki.AlertNote>> getAlerts() =>
      caller.callServerEndpoint<List<_i4c7ehki.AlertNote>>(
        'alerts',
        'getAlerts',
        {},
      );
}

/// WYRD's real brain for the app to draw: its neurons, synapses and latest thoughts. Public like
/// the diary -- it is WYRD's mind, not anyone's data -- and shared from a 20-second cache.
/// {@category Endpoint}
class EndpointBrain extends _isc.EndpointRef {
  EndpointBrain(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'brain';

  _ida.Future<_isea6qhw.BrainMap> getMap() =>
      caller.callServerEndpoint<_isea6qhw.BrainMap>(
        'brain',
        'getMap',
        {},
      );
}

/// Ports /api/chat from server.js (the core reply path -- see chat_service.dart for what's
/// intentionally not ported yet). Requires login, matching Node's requireAuth.
/// {@category Endpoint}
class EndpointChat extends _isc.EndpointRef {
  EndpointChat(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  /// [passages]: while a file shared in this conversation is open in their browser, the parts of
  /// it relevant to this message (the file itself is never sent whole or stored).
  _ida.Future<_is592ckh.ChatReply> sendMessage(
    String text, {
    List<String>? passages,
  }) => caller.callServerEndpoint<_is592ckh.ChatReply>(
    'chat',
    'sendMessage',
    {
      'text': text,
      'passages': passages,
    },
  );

  _ida.Future<List<_ie2belbc.ConversationTurn>> getHistory({int? limit}) =>
      caller.callServerEndpoint<List<_ie2belbc.ConversationTurn>>(
        'chat',
        'getHistory',
        {'limit': limit},
      );

  /// 👍 (1), 👎 (-1) or clear (0) one of your own conversation turns. Trains the learned answer
  /// behind it, and is kept on the turn as a record of what helped.
  _ida.Future<void> rate(
    int turnId,
    int rating,
  ) => caller.callServerEndpoint<void>(
    'chat',
    'rate',
    {
      'turnId': turnId,
      'rating': rating,
    },
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

/// Files shared in Dialogue Link: stored privately for the person who shared them.
/// {@category Endpoint}
class EndpointDocument extends _isc.EndpointRef {
  EndpointDocument(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  /// Shares a file's text (extracted in the browser) with WYRD. It becomes the file the
  /// conversation is about, and WYRD's first look at it is added to the conversation.
  /// With [staged], the file is only made the subject of the conversation: the message sent with
  /// it asks the question, so no first-look turn is added.
  /// [text] is a sample of the file (its beginning and pieces from throughout) and [words] its
  /// full length: the file itself stays in their browser and is never stored.
  _ida.Future<_ineqvy2e.DocumentUpload> upload(
    String name,
    String kind,
    String text, {
    int? pages,
    required bool staged,
    int? words,
  }) => caller.callServerEndpoint<_ineqvy2e.DocumentUpload>(
    'document',
    'upload',
    {
      'name': name,
      'kind': kind,
      'text': text,
      'pages': pages,
      'staged': staged,
      'words': words,
    },
  );

  /// Your shared files, newest first (without their text).
  _ida.Future<List<_imstbkek.UserDocument>> list() =>
      caller.callServerEndpoint<List<_imstbkek.UserDocument>>(
        'document',
        'list',
        {},
      );

  _ida.Future<void> remove(int id) => caller.callServerEndpoint<void>(
    'document',
    'remove',
    {'id': id},
  );
}

/// Dreams: read them, see what they were made of, or (rate-limited) ask for one. Public, like Node.
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

  /// The memories a dream was made of (its stars), shared knowledge only.
  _ida.Future<List<_ihzd15h8.ConceptExample>> getStars(int dreamId) =>
      caller.callServerEndpoint<List<_ihzd15h8.ConceptExample>>(
        'dream',
        'getStars',
        {'dreamId': dreamId},
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

  /// Today's filter decisions (kept, duplicates skipped, quarantined and why, by category) and
  /// the latest items kept out.
  _ida.Future<_iikqy3kr.FilterReport> getFilterReport() =>
      caller.callServerEndpoint<_iikqy3kr.FilterReport>(
        'feed',
        'getFilterReport',
        {},
      );

  /// Bias 2: the sources and topics WYRD has learned to trust, and to doubt.
  _ida.Future<_iv8ct9z9.TrustReport> getTrust() =>
      caller.callServerEndpoint<_iv8ct9z9.TrustReport>(
        'feed',
        'getTrust',
        {},
      );

  /// Filter + judgement: how many replies the gate checked this week, and what it did (counts
  /// only -- no conversation text leaves).
  _ida.Future<_iirmh60o.JudgementReport> getJudgementReport() =>
      caller.callServerEndpoint<_iirmh60o.JudgementReport>(
        'feed',
        'getJudgementReport',
        {},
      );
}

/// Ports /api/gate-vortex/shape from server.js. Public (the gate is shown before sign-in), so it's
/// rate limited per caller like Node, since each call can cost an LLM request.
/// {@category Endpoint}
class EndpointGateShape extends _isc.EndpointRef {
  EndpointGateShape(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'gateShape';

  _ida.Future<_id49marq.GateShape> next() =>
      caller.callServerEndpoint<_id49marq.GateShape>(
        'gateShape',
        'next',
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

  /// Growth over a readable span -- 'day', 'week', 'month' or 'all' -- averaged into at most
  /// ~120 points, so the panel can show days and weeks instead of only the newest few hours.
  _ida.Future<List<_ikfbn3bp.GrowthSnapshot>> getHistory(String range) =>
      caller.callServerEndpoint<List<_ikfbn3bp.GrowthSnapshot>>(
        'growth',
        'getHistory',
        {'range': range},
      );

  /// How much WYRD has learned from its own answers: kept, shared, reused (AI calls saved), improved.
  _ida.Future<_i41i9jez.LearningStats> getLearning() =>
      caller.callServerEndpoint<_i41i9jez.LearningStats>(
        'growth',
        'getLearning',
        {},
      );
}

/// Ports server.js's /api/lexicon/stats, /api/lexicon/word/:word and /api/lexicon/trigger.
/// The learning tick itself lives in lexicon_service.dart. Public/unauthenticated, matching
/// Node.
/// {@category Endpoint}
class EndpointLexicon extends _isc.EndpointRef {
  EndpointLexicon(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'lexicon';

  /// Runs one learning tick now instead of waiting for the timer. False if there was nothing new
  /// to learn (or the wordlist isn't loaded yet).
  _ida.Future<bool> trigger() => caller.callServerEndpoint<bool>(
    'lexicon',
    'trigger',
    {},
  );

  /// Whether WYRD's own dictionary (WordNet) is loaded, importing, or missing -- and why.
  _ida.Future<String> wordnetStatus() => caller.callServerEndpoint<String>(
    'lexicon',
    'wordnetStatus',
    {},
  );

  /// Two counts and the five newest understood words -- not the whole lexicon, which grows
  /// every 30s and was being loaded in full on every poll.
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

/// The Academy and My Library: free books (Project Gutenberg), open textbooks (OpenStax) and
/// Wikisource's library in many languages, with each person's place kept. Nothing here calls an AI.
/// {@category Endpoint}
class EndpointLibrary extends _isc.EndpointRef {
  EndpointLibrary(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'library';

  _ida.Future<List<_iqdaexua.ReadingItem>> list() =>
      caller.callServerEndpoint<List<_iqdaexua.ReadingItem>>(
        'library',
        'list',
        {},
      );

  /// The next part of item [id] (or its start with [restart], or the start of section [part]).
  _ida.Future<_ihcpac93.ReadingSlice> readOn(
    int id, {
    required bool restart,
    int? part,
  }) => caller.callServerEndpoint<_ihcpac93.ReadingSlice>(
    'library',
    'readOn',
    {
      'id': id,
      'restart': restart,
      'part': part,
    },
  );

  /// The passage shown last for item [id], again, without moving on (Dialogue Link's "open in
  /// the Academy").
  _ida.Future<_ihcpac93.ReadingSlice> current(int id) =>
      caller.callServerEndpoint<_ihcpac93.ReadingSlice>(
        'library',
        'current',
        {'id': id},
      );

  /// Quiz me: questions from [passage] (the part of item [id] just read). Words missed in
  /// recent rounds on this item come back first. No AI.
  _ida.Future<List<_i0wujsep.QuizQuestion>> quiz(
    int id,
    String passage,
  ) => caller.callServerEndpoint<List<_i0wujsep.QuizQuestion>>(
    'library',
    'quiz',
    {
      'id': id,
      'passage': passage,
    },
  );

  /// Records a finished round, so missed words are asked again and progress adds up.
  _ida.Future<_iopav0ef.QuizStats> quizDone(
    int id,
    int correct,
    int total,
    List<String> missed,
  ) => caller.callServerEndpoint<_iopav0ef.QuizStats>(
    'library',
    'quizDone',
    {
      'id': id,
      'correct': correct,
      'total': total,
      'missed': missed,
    },
  );

  _ida.Future<_iopav0ef.QuizStats> quizStats() =>
      caller.callServerEndpoint<_iopav0ef.QuizStats>(
        'library',
        'quizStats',
        {},
      );

  /// A work's table of contents (sections of a textbook, chapters on Wikisource).
  _ida.Future<List<_iepby0e1.WorkPartInfo>> contents(int id) =>
      caller.callServerEndpoint<List<_iepby0e1.WorkPartInfo>>(
        'library',
        'contents',
        {'id': id},
      );

  /// Opens a free public-domain book by title/author (Project Gutenberg), picking up where you
  /// stopped if you've started it. Null when no free copy exists.
  _ida.Future<_ihcpac93.ReadingSlice?> openBook(String query) =>
      caller.callServerEndpoint<_ihcpac93.ReadingSlice?>(
        'library',
        'openBook',
        {'query': query},
      );

  /// Opens a work found through [textbooks], [searchWikisource] or [searchBooks].
  _ida.Future<_ihcpac93.ReadingSlice?> openWork(
    String source,
    String id,
  ) => caller.callServerEndpoint<_ihcpac93.ReadingSlice?>(
    'library',
    'openWork',
    {
      'source': source,
      'id': id,
    },
  );

  /// Every OpenStax open textbook (free, CC BY 4.0), with subjects and covers.
  _ida.Future<List<_iv7njdft.WorkHit>> textbooks() =>
      caller.callServerEndpoint<List<_iv7njdft.WorkHit>>(
        'library',
        'textbooks',
        {},
      );

  /// Wikisource works in [lang] matching [query].
  _ida.Future<List<_iv7njdft.WorkHit>> searchWikisource(
    String lang,
    String query,
  ) => caller.callServerEndpoint<List<_iv7njdft.WorkHit>>(
    'library',
    'searchWikisource',
    {
      'lang': lang,
      'query': query,
    },
  );

  /// The Wikisource languages on offer, as "code|name in its own script".
  _ida.Future<List<String>> wikisourceLanguages() =>
      caller.callServerEndpoint<List<String>>(
        'library',
        'wikisourceLanguages',
        {},
      );

  /// Free books on Project Gutenberg matching [query].
  _ida.Future<List<_iv7njdft.WorkHit>> searchBooks(String query) =>
      caller.callServerEndpoint<List<_iv7njdft.WorkHit>>(
        'library',
        'searchBooks',
        {'query': query},
      );

  _ida.Future<void> remove(int id) => caller.callServerEndpoint<void>(
    'library',
    'remove',
    {'id': id},
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

  /// WYRD's shared knowledge only -- what it read, worked out or connected. This endpoint is
  /// public, and memory rows don't record whose they are, so chat and photo memories (people's
  /// own words and what WYRD saw of them) are never returned here.
  _ida.Future<List<_ij6z6xwm.MemoryBlock>> getMemory() =>
      caller.callServerEndpoint<List<_ij6z6xwm.MemoryBlock>>(
        'memory',
        'getMemory',
        {},
      );

  /// Top topics by how many recent blocks mention them, and how often pairs of those top topics
  /// co-occur. Computed in Postgres: doing it in Dart meant loading 5000 full blocks and counting
  /// every topic pair in each, which blocked the server's single isolate for ~30s -- stalling
  /// every other request while it ran. Cached briefly since the graph changes slowly.
  _ida.Future<_i3megjmi.ConceptGraph> getConcepts() =>
      caller.callServerEndpoint<_i3megjmi.ConceptGraph>(
        'memory',
        'getConcepts',
        {},
      );

  /// Everything the CONCEPT_MAP shows for one concept, in plain terms (see ConceptDetail).
  _ida.Future<_iea588cs.ConceptDetail> getConceptDetail(String topic) =>
      caller.callServerEndpoint<_iea588cs.ConceptDetail>(
        'memory',
        'getConceptDetail',
        {'topic': topic},
      );

  /// Whether search by meaning is working: key seen, share of memory fingerprinted, last problem.
  _ida.Future<String> embeddingStatus() => caller.callServerEndpoint<String>(
    'memory',
    'embeddingStatus',
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

/// For WYRD's owner (the operator accounts) only: where its people actually are. Accounts made
/// through sign-up live in Serverpod's auth tables (serverpod_auth_core_user and
/// serverpod_auth_idp_email_account, auth module v4) -- not in the older serverpod_user_info table
/// some tools still show -- and WYRD's own profile row (user_profile) is made on first sign-in.
/// {@category Endpoint}
class EndpointOwner extends _isc.EndpointRef {
  EndpointOwner(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'owner';

  /// Rows per table (null where a table doesn't exist), plus the newest sign-ups, as JSON.
  _ida.Future<String> userStats() => caller.callServerEndpoint<String>(
    'owner',
    'userStats',
    {},
  );
}

/// Ports /api/chat/photo from server.js. Requires login, matching Node's requireAuth.
/// {@category Endpoint}
class EndpointPhoto extends _isc.EndpointRef {
  EndpointPhoto(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'photo';

  /// [trackingNote] is what the app's on-device face tracking saw (pose, expression, distance);
  /// it helps WYRD read the moment but is never shown as something the person said.
  _ida.Future<_is592ckh.ChatReply> describe(
    String imageBase64Jpeg, {
    String? caption,
    String? trackingNote,
  }) => caller.callServerEndpoint<_is592ckh.ChatReply>(
    'photo',
    'describe',
    {
      'imageBase64Jpeg': imageBase64Jpeg,
      'caption': caption,
      'trackingNote': trackingNote,
    },
  );

  /// What WYRD remembers seeing of the signed-in person (descriptions only), newest first.
  _ida.Future<List<_ijttkw09.Sighting>> getSightings({required int limit}) =>
      caller.callServerEndpoint<List<_ijttkw09.Sighting>>(
        'photo',
        'getSightings',
        {'limit': limit},
      );
}

/// Ports /api/profile + the getProfile/touchProfileVisit pair from server.js. Node touched the
/// visit counter server-side at register/login; here that hook doesn't exist (the built-in email
/// IDP endpoints aren't ours to modify), so the app calls [touchVisit] right after every sign-in,
/// sign-up and session restore -- which is also what creates the person's WYRD profile row and
/// records their email on it.
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

/// Ports /api/reasoning and /api/reasoning/trigger from server.js. Public/unauthenticated,
/// matching Node.
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

  /// Newest first: neural firings (kind 'firing', JSON), self-questions (kind 'self') and older
  /// reasoning traces (kind 'reasoning').
  _ida.Future<List<_ii1bv1u2.ReasoningNote>> getNotes({int? limit}) =>
      caller.callServerEndpoint<List<_ii1bv1u2.ReasoningNote>>(
        'reasoning',
        'getNotes',
        {'limit': limit},
      );

  /// The strongest part of WYRD's neural network of ideas (see ReasoningService).
  _ida.Future<_idlunu5o.NeuralNetwork> getNetwork({required int limit}) =>
      caller.callServerEndpoint<_idlunu5o.NeuralNetwork>(
        'reasoning',
        'getNetwork',
        {'limit': limit},
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

/// Ports server.js's /api/turbo, /api/llm/status and /api/datasets/status as one status call.
/// See system_status.spy.yaml for what's fixed (turbo, datasets) on this backend. Node also
/// returned per-process LLM success/error counters; those aren't tracked here. Public, like Node.
/// {@category Endpoint}
class EndpointStatus extends _isc.EndpointRef {
  EndpointStatus(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'status';

  _ida.Future<_i97zx8uk.SystemStatus> getStatus() =>
      caller.callServerEndpoint<_i97zx8uk.SystemStatus>(
        'status',
        'getStatus',
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

/// Ports /api/topic/:topic from server.js -- what WYRD actually knows about one topic, for
/// click-to-inspect in the brain view. Public, like Node.
/// {@category Endpoint}
class EndpointTopic extends _isc.EndpointRef {
  EndpointTopic(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'topic';

  _ida.Future<_il2rvv3i.TopicInfo> getTopic(String topic) =>
      caller.callServerEndpoint<_il2rvv3i.TopicInfo>(
        'topic',
        'getTopic',
        {'topic': topic},
      );
}

/// The fine-tuning dataset, for WYRD's owner only (the operator account): what would be trained on,
/// and the files themselves, ready to upload to a fine-tuning platform.
/// {@category Endpoint}
class EndpointTraining extends _isc.EndpointRef {
  EndpointTraining(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'training';

  /// How many examples there are per source, and how many were dropped for each reason, as JSON.
  _ida.Future<String> stats() => caller.callServerEndpoint<String>(
    'training',
    'stats',
    {},
  );

  /// One split as JSON Lines: [part] is 'train' or 'validation'.
  _ida.Future<String> export(String part) => caller.callServerEndpoint<String>(
    'training',
    'export',
    {'part': part},
  );
}

/// Ports /api/world/countries and /api/world/country/:code from server.js -- the data behind
/// the globe WYRD opens via the open_world_map tool. Public, like Node.
/// {@category Endpoint}
class EndpointWorld extends _isc.EndpointRef {
  EndpointWorld(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'world';

  _ida.Future<List<_iakrxk0g.WorldCountry>> getCountries() =>
      caller.callServerEndpoint<List<_iakrxk0g.WorldCountry>>(
        'world',
        'getCountries',
        {},
      );

  /// [code] is a cca3 code (e.g. "NGA"). Returns null for an unknown code.
  _ida.Future<_i3byid52.CountryDetail?> getCountry(String code) =>
      caller.callServerEndpoint<_i3byid52.CountryDetail?>(
        'world',
        'getCountry',
        {'code': code},
      );
}

/// The open world's line to WYRD, its Authority.
/// {@category Endpoint}
class EndpointCity extends _isc.EndpointRef {
  EndpointCity(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'city';

  /// Speak to, petition, or report to the Authority. Returns the decree as JSON (see WorldAuthority.address).
  _ida.Future<String> address(
    String channel,
    String text,
    String situation,
  ) => caller.callServerEndpoint<String>(
    'city',
    'address',
    {
      'channel': channel,
      'text': text,
      'situation': situation,
    },
  );

  /// Your naira and your home (rent due is collected first), as JSON {naira, home}.
  _ida.Future<String> wallet() => caller.callServerEndpoint<String>(
    'city',
    'wallet',
    {},
  );

  /// Every home in the city, with whether it's taken and whether it's yours (JSON list).
  _ida.Future<String> homes() => caller.callServerEndpoint<String>(
    'city',
    'homes',
    {},
  );

  /// Rent ('rent') or buy ('own') a home. Returns the wallet, or {error}.
  _ida.Future<String> takeHome(
    String slug,
    String mode,
  ) => caller.callServerEndpoint<String>(
    'city',
    'takeHome',
    {
      'slug': slug,
      'mode': mode,
    },
  );

  /// Move out of your home.
  _ida.Future<String> leaveHome() => caller.callServerEndpoint<String>(
    'city',
    'leaveHome',
    {},
  );

  /// Pay a fare ('maglev' or 'danfo'); the server sets the price.
  _ida.Future<String> pay(String reason) => caller.callServerEndpoint<String>(
    'city',
    'pay',
    {'reason': reason},
  );

  /// A street-board mission done: it pays (once a day each).
  _ida.Future<String> missionPaid(String id) =>
      caller.callServerEndpoint<String>(
        'city',
        'missionPaid',
        {'id': id},
      );

  /// What you can do at a kind of place (JSON list of activities: cost or pay, healing, standing, cooldown).
  _ida.Future<String> placeActivities(String kind) =>
      caller.callServerEndpoint<String>(
        'city',
        'placeActivities',
        {'kind': kind},
      );

  /// Do something at a place. Returns the wallet plus {text, delta, heal, standing}, or {error}.
  _ida.Future<String> visit(
    String kind,
    String activity,
    String place,
  ) => caller.callServerEndpoint<String>(
    'city',
    'visit',
    {
      'kind': kind,
      'activity': activity,
      'place': place,
    },
  );

  /// Start a job ('delivery', 'danfo' or 'chase'). Returns {id, type, limitS}.
  _ida.Future<String> jobStart(String type) =>
      caller.callServerEndpoint<String>(
        'city',
        'jobStart',
        {'type': type},
      );

  /// Finish a job: the server checks the timing and pays. Returns the wallet plus {paid, note}, or {error}.
  _ida.Future<String> jobFinish(
    String id,
    int dist,
    int passengers,
    int limitS,
  ) => caller.callServerEndpoint<String>(
    'city',
    'jobFinish',
    {
      'id': id,
      'dist': dist,
      'passengers': passengers,
      'limitS': limitS,
    },
  );

  /// The first-time guide: mark a step done (pays its bonus once). Returns {guide, paid, naira}, or {error}.
  _ida.Future<String> guideMark(String step) =>
      caller.callServerEndpoint<String>(
        'city',
        'guideMark',
        {'step': step},
      );

  /// Skip the first-time guide.
  _ida.Future<String> guideSkip() => caller.callServerEndpoint<String>(
    'city',
    'guideSkip',
    {},
  );

  /// The game's heartbeat (every 30 s while you play): counts you as online.
  _ida.Future<void> pulse() => caller.callServerEndpoint<void>(
    'city',
    'pulse',
    {},
  );

  /// Who's in the city: online now, joined, missions done, today's talk with WYRD, the leading citizens (JSON).
  _ida.Future<String> stats() => caller.callServerEndpoint<String>(
    'city',
    'stats',
    {},
  );

  /// Your standing with the Authority and any mission it gave you, without asking it anything.
  _ida.Future<String> status() => caller.callServerEndpoint<String>(
    'city',
    'status',
    {},
  );

  /// WYRD's charter for the city (how it means to deal with players, in its words) and the
  /// missions on its board open to you, as JSON: {charter, author, writtenAt, missions}.
  _ida.Future<String> charter() => caller.callServerEndpoint<String>(
    'city',
    'charter',
    {},
  );

  /// The live design (approved tuning, NPC lines, events, missions) the game applies, as JSON.
  _ida.Future<String> design() => caller.callServerEndpoint<String>(
    'city',
    'design',
    {},
  );

  /// Help train WYRD with your play (or stop): asked once in the game, changeable any time.
  _ida.Future<String> setTraining(bool optIn) =>
      caller.callServerEndpoint<String>(
        'city',
        'setTraining',
        {'optIn': optIn},
      );

  /// Your character (JSON), or 'null' if you haven't made one yet.
  _ida.Future<String> myCharacter() => caller.callServerEndpoint<String>(
    'city',
    'myCharacter',
    {},
  );

  /// Save your character from the creator (JSON): base, name, proportions, skin, outfit hue, neon.
  _ida.Future<String> saveCharacter(String character) =>
      caller.callServerEndpoint<String>(
        'city',
        'saveCharacter',
        {'character': character},
      );

  /// Is this person allowed in the design studio?
  _ida.Future<bool> canDesign() => caller.callServerEndpoint<bool>(
    'city',
    'canDesign',
    {},
  );

  /// Say something to WYRD about the game; it answers as co-designer and may propose changes. JSON: {reply, proposals}.
  _ida.Future<String> designChat(String text) =>
      caller.callServerEndpoint<String>(
        'city',
        'designChat',
        {'text': text},
      );

  /// The design log, newest first, as JSON.
  _ida.Future<String> designNotes() => caller.callServerEndpoint<String>(
    'city',
    'designNotes',
    {},
  );

  /// Approve or reject one of WYRD's proposals. Approved live kinds change the game at once.
  _ida.Future<String> designDecide(
    int id,
    bool approve,
  ) => caller.callServerEndpoint<String>(
    'city',
    'designDecide',
    {
      'id': id,
      'approve': approve,
    },
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
    agent = EndpointAgent(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    droneBridge = EndpointDroneBridge(this);
    drone = EndpointDrone(this);
    games = EndpointGames(this);
    greeting = EndpointGreeting(this);
    account = EndpointAccount(this);
    alerts = EndpointAlerts(this);
    brain = EndpointBrain(this);
    chat = EndpointChat(this);
    curriculum = EndpointCurriculum(this);
    diary = EndpointDiary(this);
    document = EndpointDocument(this);
    dream = EndpointDream(this);
    feed = EndpointFeed(this);
    gateShape = EndpointGateShape(this);
    growth = EndpointGrowth(this);
    lexicon = EndpointLexicon(this);
    library = EndpointLibrary(this);
    memory = EndpointMemory(this);
    mind = EndpointMind(this);
    owner = EndpointOwner(this);
    photo = EndpointPhoto(this);
    profile = EndpointProfile(this);
    reasoning = EndpointReasoning(this);
    selfConfig = EndpointSelfConfig(this);
    selfQuestion = EndpointSelfQuestion(this);
    status = EndpointStatus(this);
    synthesis = EndpointSynthesis(this);
    topic = EndpointTopic(this);
    training = EndpointTraining(this);
    world = EndpointWorld(this);
    city = EndpointCity(this);
    modules = Modules(this);
  }

  late final EndpointAgent agent;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointDroneBridge droneBridge;

  late final EndpointDrone drone;

  late final EndpointGames games;

  late final EndpointGreeting greeting;

  late final EndpointAccount account;

  late final EndpointAlerts alerts;

  late final EndpointBrain brain;

  late final EndpointChat chat;

  late final EndpointCurriculum curriculum;

  late final EndpointDiary diary;

  late final EndpointDocument document;

  late final EndpointDream dream;

  late final EndpointFeed feed;

  late final EndpointGateShape gateShape;

  late final EndpointGrowth growth;

  late final EndpointLexicon lexicon;

  late final EndpointLibrary library;

  late final EndpointMemory memory;

  late final EndpointMind mind;

  late final EndpointOwner owner;

  late final EndpointPhoto photo;

  late final EndpointProfile profile;

  late final EndpointReasoning reasoning;

  late final EndpointSelfConfig selfConfig;

  late final EndpointSelfQuestion selfQuestion;

  late final EndpointStatus status;

  late final EndpointSynthesis synthesis;

  late final EndpointTopic topic;

  late final EndpointTraining training;

  late final EndpointWorld world;

  late final EndpointCity city;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'agent': agent,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'droneBridge': droneBridge,
    'drone': drone,
    'games': games,
    'greeting': greeting,
    'account': account,
    'alerts': alerts,
    'brain': brain,
    'chat': chat,
    'curriculum': curriculum,
    'diary': diary,
    'document': document,
    'dream': dream,
    'feed': feed,
    'gateShape': gateShape,
    'growth': growth,
    'lexicon': lexicon,
    'library': library,
    'memory': memory,
    'mind': mind,
    'owner': owner,
    'photo': photo,
    'profile': profile,
    'reasoning': reasoning,
    'selfConfig': selfConfig,
    'selfQuestion': selfQuestion,
    'status': status,
    'synthesis': synthesis,
    'topic': topic,
    'training': training,
    'world': world,
    'city': city,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
