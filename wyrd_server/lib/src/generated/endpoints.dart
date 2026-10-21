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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:wyrd_server/src/generated/drone/drone_state.dart' as _ivnf8vdp;
import 'package:wyrd_server/src/generated/future_calls.dart' as _ix7un2io;
import '../agent/agent_endpoint.dart' as _i6aufbii;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../drone/drone_bridge_endpoint.dart' as _igomlm42;
import '../drone/drone_endpoint.dart' as _iec5mi4p;
import '../games/games_endpoint.dart' as _ittu6d2n;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../island/island_auth_endpoint.dart' as _ifhwc3xe;
import '../island/island_endpoint.dart' as _i1elbils;
import '../island/island_me_endpoint.dart' as _ixszl6xq;
import '../konnectly/konnectly_endpoint.dart' as _i79gaqir;
import '../mind/account_endpoint.dart' as _i45717np;
import '../mind/alerts_endpoint.dart' as _impqu952;
import '../mind/brain_endpoint.dart' as _iskgx6uk;
import '../mind/chat_endpoint.dart' as _i2b8uve4;
import '../mind/curriculum_endpoint.dart' as _i7sq3i85;
import '../mind/dashboard_endpoint.dart' as _iqbis52t;
import '../mind/diary_endpoint.dart' as _i71dg2tj;
import '../mind/document_endpoint.dart' as _i7txdnsa;
import '../mind/dream_endpoint.dart' as _inxbi04j;
import '../mind/feed_endpoint.dart' as _in0i7e4k;
import '../mind/gate_shape_endpoint.dart' as _ix7nnscc;
import '../mind/growth_endpoint.dart' as _idrisijy;
import '../mind/lexicon_endpoint.dart' as _i3c3oo5r;
import '../mind/library_endpoint.dart' as _ifaqo2up;
import '../mind/memory_endpoint.dart' as _ibdzbeap;
import '../mind/mind_endpoint.dart' as _i2dwy8oi;
import '../mind/owner_endpoint.dart' as _i5tlqn06;
import '../mind/photo_endpoint.dart' as _ij44nk8s;
import '../mind/profile_endpoint.dart' as _in0jvng1;
import '../mind/reasoning_endpoint.dart' as _iovbjp1a;
import '../mind/self_config_endpoint.dart' as _iuprx8k1;
import '../mind/self_question_endpoint.dart' as _i4qouglj;
import '../mind/status_endpoint.dart' as _ik9coqrp;
import '../mind/synthesis_endpoint.dart' as _i6ave7v9;
import '../mind/topic_endpoint.dart' as _i2t0sh8b;
import '../mind/training_endpoint.dart' as _igyenhzn;
import '../mind/world_endpoint.dart' as _iaj95ngr;
import '../partner/partner_admin_endpoint.dart' as _iaek1pkr;
import '../world/city_endpoint.dart' as _ifkdhb4n;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'agent': _i6aufbii.AgentEndpoint()
        ..initialize(
          server,
          'agent',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'droneBridge': _igomlm42.DroneBridgeEndpoint()
        ..initialize(
          server,
          'droneBridge',
          null,
        ),
      'drone': _iec5mi4p.DroneEndpoint()
        ..initialize(
          server,
          'drone',
          null,
        ),
      'games': _ittu6d2n.GamesEndpoint()
        ..initialize(
          server,
          'games',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'islandAuth': _ifhwc3xe.IslandAuthEndpoint()
        ..initialize(
          server,
          'islandAuth',
          null,
        ),
      'island': _i1elbils.IslandEndpoint()
        ..initialize(
          server,
          'island',
          null,
        ),
      'islandMe': _ixszl6xq.IslandMeEndpoint()
        ..initialize(
          server,
          'islandMe',
          null,
        ),
      'konnectly': _i79gaqir.KonnectlyEndpoint()
        ..initialize(
          server,
          'konnectly',
          null,
        ),
      'account': _i45717np.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'alerts': _impqu952.AlertsEndpoint()
        ..initialize(
          server,
          'alerts',
          null,
        ),
      'brain': _iskgx6uk.BrainEndpoint()
        ..initialize(
          server,
          'brain',
          null,
        ),
      'chat': _i2b8uve4.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'curriculum': _i7sq3i85.CurriculumEndpoint()
        ..initialize(
          server,
          'curriculum',
          null,
        ),
      'dashboard': _iqbis52t.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'diary': _i71dg2tj.DiaryEndpoint()
        ..initialize(
          server,
          'diary',
          null,
        ),
      'document': _i7txdnsa.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'dream': _inxbi04j.DreamEndpoint()
        ..initialize(
          server,
          'dream',
          null,
        ),
      'feed': _in0i7e4k.FeedEndpoint()
        ..initialize(
          server,
          'feed',
          null,
        ),
      'gateShape': _ix7nnscc.GateShapeEndpoint()
        ..initialize(
          server,
          'gateShape',
          null,
        ),
      'growth': _idrisijy.GrowthEndpoint()
        ..initialize(
          server,
          'growth',
          null,
        ),
      'lexicon': _i3c3oo5r.LexiconEndpoint()
        ..initialize(
          server,
          'lexicon',
          null,
        ),
      'library': _ifaqo2up.LibraryEndpoint()
        ..initialize(
          server,
          'library',
          null,
        ),
      'memory': _ibdzbeap.MemoryEndpoint()
        ..initialize(
          server,
          'memory',
          null,
        ),
      'mind': _i2dwy8oi.MindEndpoint()
        ..initialize(
          server,
          'mind',
          null,
        ),
      'owner': _i5tlqn06.OwnerEndpoint()
        ..initialize(
          server,
          'owner',
          null,
        ),
      'photo': _ij44nk8s.PhotoEndpoint()
        ..initialize(
          server,
          'photo',
          null,
        ),
      'profile': _in0jvng1.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'reasoning': _iovbjp1a.ReasoningEndpoint()
        ..initialize(
          server,
          'reasoning',
          null,
        ),
      'selfConfig': _iuprx8k1.SelfConfigEndpoint()
        ..initialize(
          server,
          'selfConfig',
          null,
        ),
      'selfQuestion': _i4qouglj.SelfQuestionEndpoint()
        ..initialize(
          server,
          'selfQuestion',
          null,
        ),
      'status': _ik9coqrp.StatusEndpoint()
        ..initialize(
          server,
          'status',
          null,
        ),
      'synthesis': _i6ave7v9.SynthesisEndpoint()
        ..initialize(
          server,
          'synthesis',
          null,
        ),
      'topic': _i2t0sh8b.TopicEndpoint()
        ..initialize(
          server,
          'topic',
          null,
        ),
      'training': _igyenhzn.TrainingEndpoint()
        ..initialize(
          server,
          'training',
          null,
        ),
      'world': _iaj95ngr.WorldEndpoint()
        ..initialize(
          server,
          'world',
          null,
        ),
      'partnerAdmin': _iaek1pkr.PartnerAdminEndpoint()
        ..initialize(
          server,
          'partnerAdmin',
          null,
        ),
      'city': _ifkdhb4n.CityEndpoint()
        ..initialize(
          server,
          'city',
          null,
        ),
    };
    connectors['agent'] = _is.EndpointConnector(
      name: 'agent',
      endpoint: endpoints['agent']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'goal': _is.ParameterDescription(
              name: 'goal',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'everyHours': _is.ParameterDescription(
              name: 'everyHours',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i6aufbii.AgentEndpoint).create(
                session,
                params['goal'],
                params['everyHours'],
              ),
        ),
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i6aufbii.AgentEndpoint).mine(session),
        ),
        'steps': _is.MethodConnector(
          name: 'steps',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i6aufbii.AgentEndpoint).steps(
                session,
                params['taskId'],
              ),
        ),
        'decide': _is.MethodConnector(
          name: 'decide',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approve': _is.ParameterDescription(
              name: 'approve',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i6aufbii.AgentEndpoint).decide(
                session,
                params['taskId'],
                params['approve'],
              ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i6aufbii.AgentEndpoint).cancel(
                session,
                params['taskId'],
              ),
        ),
        'runNow': _is.MethodConnector(
          name: 'runNow',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i6aufbii.AgentEndpoint).runNow(
                session,
                params['taskId'],
              ),
        ),
        'markRead': _is.MethodConnector(
          name: 'markRead',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i6aufbii.AgentEndpoint).markRead(
                    session,
                    params['taskId'],
                  ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['droneBridge'] = _is.EndpointConnector(
      name: 'droneBridge',
      endpoint: endpoints['droneBridge']!,
      methodConnectors: {
        'report': _is.MethodConnector(
          name: 'report',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'state': _is.ParameterDescription(
              name: 'state',
              type: _is.getType<_ivnf8vdp.DroneState>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['droneBridge'] as _igomlm42.DroneBridgeEndpoint)
                      .report(
                        session,
                        params['token'],
                        params['state'],
                      ),
        ),
        'missionUpdate': _is.MethodConnector(
          name: 'missionUpdate',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['droneBridge'] as _igomlm42.DroneBridgeEndpoint)
                      .missionUpdate(
                        session,
                        params['token'],
                        params['missionId'],
                        params['status'],
                        params['reason'],
                      ),
        ),
      },
    );
    connectors['drone'] = _is.EndpointConnector(
      name: 'drone',
      endpoint: endpoints['drone']!,
      methodConnectors: {
        'getState': _is.MethodConnector(
          name: 'getState',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['drone'] as _iec5mi4p.DroneEndpoint)
                  .getState(session),
        ),
        'getMissions': _is.MethodConnector(
          name: 'getMissions',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['drone'] as _iec5mi4p.DroneEndpoint).getMissions(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'isOperator': _is.MethodConnector(
          name: 'isOperator',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['drone'] as _iec5mi4p.DroneEndpoint)
                  .isOperator(session),
        ),
        'plan': _is.MethodConnector(
          name: 'plan',
          params: {
            'instruction': _is.ParameterDescription(
              name: 'instruction',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['drone'] as _iec5mi4p.DroneEndpoint).plan(
                session,
                params['instruction'],
              ),
        ),
        'abort': _is.MethodConnector(
          name: 'abort',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['drone'] as _iec5mi4p.DroneEndpoint).abort(
                session,
              ),
        ),
      },
    );
    connectors['games'] = _is.EndpointConnector(
      name: 'games',
      endpoint: endpoints['games']!,
      methodConnectors: {
        'myGames': _is.MethodConnector(
          name: 'myGames',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint)
                  .myGames(session),
        ),
        'deleteGame': _is.MethodConnector(
          name: 'deleteGame',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).deleteGame(
                    session,
                    params['id'],
                  ),
        ),
        'readyForWyrd': _is.MethodConnector(
          name: 'readyForWyrd',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).readyForWyrd(
                    session,
                    params['id'],
                  ),
        ),
        'wyrdRound': _is.MethodConnector(
          name: 'wyrdRound',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'score': _is.ParameterDescription(
              name: 'score',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'params': _is.ParameterDescription(
              name: 'params',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).wyrdRound(
                    session,
                    params['id'],
                    params['score'],
                    params['params'],
                    params['note'],
                  ),
        ),
        'myRatings': _is.MethodConnector(
          name: 'myRatings',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint)
                  .myRatings(session),
        ),
        'leaderboard': _is.MethodConnector(
          name: 'leaderboard',
          params: {
            'game': _is.ParameterDescription(
              name: 'game',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).leaderboard(
                    session,
                    params['game'],
                  ),
        ),
        'active': _is.MethodConnector(
          name: 'active',
          params: {
            'game': _is.ParameterDescription(
              name: 'game',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).active(
                session,
                params['game'],
              ),
        ),
        'start': _is.MethodConnector(
          name: 'start',
          params: {
            'game': _is.ParameterDescription(
              name: 'game',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'side': _is.ParameterDescription(
              name: 'side',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).start(
                session,
                params['game'],
                params['side'],
              ),
        ),
        'move': _is.MethodConnector(
          name: 'move',
          params: {
            'matchId': _is.ParameterDescription(
              name: 'matchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'move': _is.ParameterDescription(
              name: 'move',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).move(
                session,
                params['matchId'],
                params['move'],
              ),
        ),
        'resign': _is.MethodConnector(
          name: 'resign',
          params: {
            'matchId': _is.ParameterDescription(
              name: 'matchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).resign(
                session,
                params['matchId'],
              ),
        ),
        'wyrdChallenge': _is.MethodConnector(
          name: 'wyrdChallenge',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint)
                  .wyrdChallenge(session),
        ),
        'startChess': _is.MethodConnector(
          name: 'startChess',
          params: {
            'side': _is.ParameterDescription(
              name: 'side',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).startChess(
                    session,
                    params['side'],
                  ),
        ),
        'moveChess': _is.MethodConnector(
          name: 'moveChess',
          params: {
            'matchId': _is.ParameterDescription(
              name: 'matchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'promotion': _is.ParameterDescription(
              name: 'promotion',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).moveChess(
                    session,
                    params['matchId'],
                    params['from'],
                    params['to'],
                    params['promotion'],
                  ),
        ),
        'challenge': _is.MethodConnector(
          name: 'challenge',
          params: {
            'game': _is.ParameterDescription(
              name: 'game',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['games'] as _ittu6d2n.GamesEndpoint).challenge(
                    session,
                    params['game'],
                  ),
        ),
        'openChallenges': _is.MethodConnector(
          name: 'openChallenges',
          params: {
            'game': _is.ParameterDescription(
              name: 'game',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint)
                  .openChallenges(
                    session,
                    params['game'],
                  ),
        ),
        'accept': _is.MethodConnector(
          name: 'accept',
          params: {
            'matchId': _is.ParameterDescription(
              name: 'matchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).accept(
                session,
                params['matchId'],
              ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'matchId': _is.ParameterDescription(
              name: 'matchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).cancel(
                session,
                params['matchId'],
              ),
        ),
        'myPvp': _is.MethodConnector(
          name: 'myPvp',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).myPvp(
                session,
              ),
        ),
        'poll': _is.MethodConnector(
          name: 'poll',
          params: {
            'matchId': _is.ParameterDescription(
              name: 'matchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['games'] as _ittu6d2n.GamesEndpoint).poll(
                session,
                params['matchId'],
                params['version'],
              ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['islandAuth'] = _is.EndpointConnector(
      name: 'islandAuth',
      endpoint: endpoints['islandAuth']!,
      methodConnectors: {
        'available': _is.MethodConnector(
          name: 'available',
          params: {
            'username': _is.ParameterDescription(
              name: 'username',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandAuth'] as _ifhwc3xe.IslandAuthEndpoint)
                      .available(
                        session,
                        params['username'],
                      ),
        ),
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'username': _is.ParameterDescription(
              name: 'username',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandAuth'] as _ifhwc3xe.IslandAuthEndpoint)
                      .register(
                        session,
                        params['username'],
                        params['email'],
                        params['password'],
                      ),
        ),
        'emailFree': _is.MethodConnector(
          name: 'emailFree',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandAuth'] as _ifhwc3xe.IslandAuthEndpoint)
                      .emailFree(
                        session,
                        params['email'],
                      ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'username': _is.ParameterDescription(
              name: 'username',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandAuth'] as _ifhwc3xe.IslandAuthEndpoint)
                      .login(
                        session,
                        params['username'],
                        params['password'],
                      ),
        ),
      },
    );
    connectors['island'] = _is.EndpointConnector(
      name: 'island',
      endpoint: endpoints['island']!,
      methodConnectors: {
        'housing': _is.MethodConnector(
          name: 'housing',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['island'] as _i1elbils.IslandEndpoint)
                  .housing(session),
        ),
        'hangars': _is.MethodConnector(
          name: 'hangars',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['island'] as _i1elbils.IslandEndpoint)
                  .hangars(session),
        ),
        'tick': _is.MethodConnector(
          name: 'tick',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'x': _is.ParameterDescription(
              name: 'x',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'z': _is.ParameterDescription(
              name: 'z',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'since': _is.ParameterDescription(
              name: 'since',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'look': _is.ParameterDescription(
              name: 'look',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'car': _is.ParameterDescription(
              name: 'car',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['island'] as _i1elbils.IslandEndpoint).tick(
                session,
                params['id'],
                params['name'],
                params['color'],
                params['x'],
                params['z'],
                params['since'],
                params['room'],
                params['look'],
                params['car'],
              ),
        ),
        'online': _is.MethodConnector(
          name: 'online',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['island'] as _i1elbils.IslandEndpoint)
                  .online(session),
        ),
        'spin': _is.MethodConnector(
          name: 'spin',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'club': _is.ParameterDescription(
              name: 'club',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'url': _is.ParameterDescription(
              name: 'url',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'artist': _is.ParameterDescription(
              name: 'artist',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'art': _is.ParameterDescription(
              name: 'art',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['island'] as _i1elbils.IslandEndpoint).spin(
                session,
                params['id'],
                params['club'],
                params['url'],
                params['title'],
                params['artist'],
                params['art'],
              ),
        ),
        'say': _is.MethodConnector(
          name: 'say',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['island'] as _i1elbils.IslandEndpoint).say(
                session,
                params['id'],
                params['text'],
              ),
        ),
      },
    );
    connectors['islandMe'] = _is.EndpointConnector(
      name: 'islandMe',
      endpoint: endpoints['islandMe']!,
      methodConnectors: {
        'setEmail': _is.MethodConnector(
          name: 'setEmail',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .setEmail(
                    session,
                    params['email'],
                  ),
        ),
        'confirmPhone': _is.MethodConnector(
          name: 'confirmPhone',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .confirmPhone(
                    session,
                    params['email'],
                    params['password'],
                  ),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .me(session),
        ),
        'setProfile': _is.MethodConnector(
          name: 'setProfile',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'skills': _is.ParameterDescription(
              name: 'skills',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'openToWork': _is.ParameterDescription(
              name: 'openToWork',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'pubKey': _is.ParameterDescription(
              name: 'pubKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .setProfile(
                    session,
                    params['handle'],
                    params['skills'],
                    params['openToWork'],
                    params['pubKey'],
                  ),
        ),
        'setLook': _is.MethodConnector(
          name: 'setLook',
          params: {
            'look': _is.ParameterDescription(
              name: 'look',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).setLook(
                    session,
                    params['look'],
                  ),
        ),
        'keyOf': _is.MethodConnector(
          name: 'keyOf',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).keyOf(
                    session,
                    params['handle'],
                  ),
        ),
        'work': _is.MethodConnector(
          name: 'work',
          params: {
            'place': _is.ParameterDescription(
              name: 'place',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).work(
                    session,
                    params['place'],
                  ),
        ),
        'earnBoard': _is.MethodConnector(
          name: 'earnBoard',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .earnBoard(session),
        ),
        'gridCareer': _is.MethodConnector(
          name: 'gridCareer',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .gridCareer(session),
        ),
        'gridStart': _is.MethodConnector(
          name: 'gridStart',
          params: {
            'track': _is.ParameterDescription(
              name: 'track',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .gridStart(
                    session,
                    params['track'],
                  ),
        ),
        'gridFinish': _is.MethodConnector(
          name: 'gridFinish',
          params: {
            'workId': _is.ParameterDescription(
              name: 'workId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'results': _is.ParameterDescription(
              name: 'results',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .gridFinish(
                    session,
                    params['workId'],
                    params['results'],
                  ),
        ),
        'gridExamStart': _is.MethodConnector(
          name: 'gridExamStart',
          params: {
            'track': _is.ParameterDescription(
              name: 'track',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .gridExamStart(
                    session,
                    params['track'],
                  ),
        ),
        'gridExamAnswer': _is.MethodConnector(
          name: 'gridExamAnswer',
          params: {
            'workId': _is.ParameterDescription(
              name: 'workId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'answers': _is.ParameterDescription(
              name: 'answers',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .gridExamAnswer(
                    session,
                    params['workId'],
                    params['answers'],
                  ),
        ),
        'gridShift': _is.MethodConnector(
          name: 'gridShift',
          params: {
            'level': _is.ParameterDescription(
              name: 'level',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'score': _is.ParameterDescription(
              name: 'score',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .gridShift(
                    session,
                    params['level'],
                    params['score'],
                  ),
        ),
        'receipts': _is.MethodConnector(
          name: 'receipts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .receipts(session),
        ),
        'send': _is.MethodConnector(
          name: 'send',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'amount': _is.ParameterDescription(
              name: 'amount',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).send(
                    session,
                    params['handle'],
                    params['amount'],
                    params['note'],
                  ),
        ),
        'casino': _is.MethodConnector(
          name: 'casino',
          params: {
            'game': _is.ParameterDescription(
              name: 'game',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bet': _is.ParameterDescription(
              name: 'bet',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'stake': _is.ParameterDescription(
              name: 'stake',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).casino(
                    session,
                    params['game'],
                    params['bet'],
                    params['stake'],
                  ),
        ),
        'jobs': _is.MethodConnector(
          name: 'jobs',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .jobs(session),
        ),
        'postJob': _is.MethodConnector(
          name: 'postJob',
          params: {
            'company': _is.ParameterDescription(
              name: 'company',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'pay': _is.ParameterDescription(
              name: 'pay',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'skills': _is.ParameterDescription(
              name: 'skills',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'about': _is.ParameterDescription(
              name: 'about',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'contact': _is.ParameterDescription(
              name: 'contact',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).postJob(
                    session,
                    params['company'],
                    params['title'],
                    params['pay'],
                    params['skills'],
                    params['location'],
                    params['about'],
                    params['contact'],
                  ),
        ),
        'apply': _is.MethodConnector(
          name: 'apply',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).apply(
                    session,
                    params['jobId'],
                    params['note'],
                  ),
        ),
        'myJobs': _is.MethodConnector(
          name: 'myJobs',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .myJobs(session),
        ),
        'closeJob': _is.MethodConnector(
          name: 'closeJob',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .closeJob(
                    session,
                    params['jobId'],
                  ),
        ),
        'pendingJobs': _is.MethodConnector(
          name: 'pendingJobs',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .pendingJobs(session),
        ),
        'reviewJob': _is.MethodConnector(
          name: 'reviewJob',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approve': _is.ParameterDescription(
              name: 'approve',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .reviewJob(
                    session,
                    params['jobId'],
                    params['approve'],
                  ),
        ),
        'createGroup': _is.MethodConnector(
          name: 'createGroup',
          params: {
            'nameCt': _is.ParameterDescription(
              name: 'nameCt',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'wrapperPub': _is.ParameterDescription(
              name: 'wrapperPub',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'members': _is.ParameterDescription(
              name: 'members',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .createGroup(
                    session,
                    params['nameCt'],
                    params['wrapperPub'],
                    params['members'],
                  ),
        ),
        'postOnce': _is.MethodConnector(
          name: 'postOnce',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'ct': _is.ParameterDescription(
              name: 'ct',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'cid': _is.ParameterDescription(
              name: 'cid',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .postOnce(
                    session,
                    params['groupId'],
                    params['ct'],
                    params['cid'],
                  ),
        ),
        'addMember': _is.MethodConnector(
          name: 'addMember',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'wrappedKey': _is.ParameterDescription(
              name: 'wrappedKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'wrapperPub': _is.ParameterDescription(
              name: 'wrapperPub',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .addMember(
                    session,
                    params['groupId'],
                    params['handle'],
                    params['wrappedKey'],
                    params['wrapperPub'],
                  ),
        ),
        'leaveGroup': _is.MethodConnector(
          name: 'leaveGroup',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .leaveGroup(
                    session,
                    params['groupId'],
                  ),
        ),
        'groups': _is.MethodConnector(
          name: 'groups',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .groups(session),
        ),
        'inbox': _is.MethodConnector(
          name: 'inbox',
          params: {
            'seenJson': _is.ParameterDescription(
              name: 'seenJson',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).inbox(
                    session,
                    params['seenJson'],
                  ),
        ),
        'post': _is.MethodConnector(
          name: 'post',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'ct': _is.ParameterDescription(
              name: 'ct',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).post(
                    session,
                    params['groupId'],
                    params['ct'],
                  ),
        ),
        'messages': _is.MethodConnector(
          name: 'messages',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'since': _is.ParameterDescription(
              name: 'since',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .messages(
                    session,
                    params['groupId'],
                    params['since'],
                  ),
        ),
        'live': _is.MethodConnector(
          name: 'live',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'since': _is.ParameterDescription(
              name: 'since',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'ver': _is.ParameterDescription(
              name: 'ver',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).live(
                    session,
                    params['groupId'],
                    params['since'],
                    params['ver'],
                  ),
        ),
        'typing': _is.MethodConnector(
          name: 'typing',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).typing(
                    session,
                    params['groupId'],
                  ),
        ),
        'read': _is.MethodConnector(
          name: 'read',
          params: {
            'groupId': _is.ParameterDescription(
              name: 'groupId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'upTo': _is.ParameterDescription(
              name: 'upTo',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).read(
                    session,
                    params['groupId'],
                    params['upTo'],
                  ),
        ),
        'setHq': _is.MethodConnector(
          name: 'setHq',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'locked': _is.ParameterDescription(
              name: 'locked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'invites': _is.ParameterDescription(
              name: 'invites',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).setHq(
                    session,
                    params['name'],
                    params['color'],
                    params['locked'],
                    params['invites'],
                  ),
        ),
        'hqRow': _is.MethodConnector(
          name: 'hqRow',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .hqRow(session),
        ),
        'askHq': _is.MethodConnector(
          name: 'askHq',
          params: {
            'slot': _is.ParameterDescription(
              name: 'slot',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).askHq(
                    session,
                    params['slot'],
                  ),
        ),
        'hqRequests': _is.MethodConnector(
          name: 'hqRequests',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .hqRequests(session),
        ),
        'answerHq': _is.MethodConnector(
          name: 'answerHq',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'grant': _is.ParameterDescription(
              name: 'grant',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .answerHq(
                    session,
                    params['id'],
                    params['grant'],
                  ),
        ),
        'rideQuote': _is.MethodConnector(
          name: 'rideQuote',
          params: {
            'fi': _is.ParameterDescription(
              name: 'fi',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'fj': _is.ParameterDescription(
              name: 'fj',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'ti': _is.ParameterDescription(
              name: 'ti',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'tj': _is.ParameterDescription(
              name: 'tj',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .rideQuote(
                    session,
                    params['fi'],
                    params['fj'],
                    params['ti'],
                    params['tj'],
                  ),
        ),
        'requestRide': _is.MethodConnector(
          name: 'requestRide',
          params: {
            'fi': _is.ParameterDescription(
              name: 'fi',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'fj': _is.ParameterDescription(
              name: 'fj',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'ti': _is.ParameterDescription(
              name: 'ti',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'tj': _is.ParameterDescription(
              name: 'tj',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .requestRide(
                    session,
                    params['fi'],
                    params['fj'],
                    params['ti'],
                    params['tj'],
                    params['kind'],
                  ),
        ),
        'payRide': _is.MethodConnector(
          name: 'payRide',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).payRide(
                    session,
                    params['id'],
                  ),
        ),
        'cancelRide': _is.MethodConnector(
          name: 'cancelRide',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .cancelRide(
                    session,
                    params['id'],
                  ),
        ),
        'cars': _is.MethodConnector(
          name: 'cars',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .cars(session),
        ),
        'myCars': _is.MethodConnector(
          name: 'myCars',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .myCars(session),
        ),
        'buyCar': _is.MethodConnector(
          name: 'buyCar',
          params: {
            'model': _is.ParameterDescription(
              name: 'model',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).buyCar(
                    session,
                    params['model'],
                    params['color'],
                  ),
        ),
        'driveCar': _is.MethodConnector(
          name: 'driveCar',
          params: {
            'carId': _is.ParameterDescription(
              name: 'carId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .driveCar(
                    session,
                    params['carId'],
                  ),
        ),
        'buyOutfit': _is.MethodConnector(
          name: 'buyOutfit',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .buyOutfit(
                    session,
                    params['item'],
                  ),
        ),
        'myOutfits': _is.MethodConnector(
          name: 'myOutfits',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .myOutfits(session),
        ),
        'buyFurniture': _is.MethodConnector(
          name: 'buyFurniture',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .buyFurniture(
                    session,
                    params['item'],
                  ),
        ),
        'myFurniture': _is.MethodConnector(
          name: 'myFurniture',
          params: {
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .myFurniture(
                    session,
                    params['room'],
                  ),
        ),
        'homes': _is.MethodConnector(
          name: 'homes',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .homes(session),
        ),
        'buyHome': _is.MethodConnector(
          name: 'buyHome',
          params: {
            'plot': _is.ParameterDescription(
              name: 'plot',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).buyHome(
                    session,
                    params['plot'],
                  ),
        ),
        'startParty': _is.MethodConnector(
          name: 'startParty',
          params: {
            'key': _is.ParameterDescription(
              name: 'key',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'theme': _is.ParameterDescription(
              name: 'theme',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'minutes': _is.ParameterDescription(
              name: 'minutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'open': _is.ParameterDescription(
              name: 'open',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'guests': _is.ParameterDescription(
              name: 'guests',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .startParty(
                    session,
                    params['key'],
                    params['theme'],
                    params['minutes'],
                    params['open'],
                    params['guests'],
                  ),
        ),
        'endParty': _is.MethodConnector(
          name: 'endParty',
          params: {
            'key': _is.ParameterDescription(
              name: 'key',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .endParty(
                    session,
                    params['key'],
                  ),
        ),
        'parties': _is.MethodConnector(
          name: 'parties',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .parties(session),
        ),
        'charterYacht': _is.MethodConnector(
          name: 'charterYacht',
          params: {
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .charterYacht(
                    session,
                    params['kind'],
                  ),
        ),
        'bookFlight': _is.MethodConnector(
          name: 'bookFlight',
          params: {
            'dest': _is.ParameterDescription(
              name: 'dest',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .bookFlight(
                    session,
                    params['dest'],
                  ),
        ),
        'myJet': _is.MethodConnector(
          name: 'myJet',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .myJet(session),
        ),
        'buyJet': _is.MethodConnector(
          name: 'buyJet',
          params: {
            'model': _is.ParameterDescription(
              name: 'model',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'livery': _is.ParameterDescription(
              name: 'livery',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).buyJet(
                    session,
                    params['model'],
                    params['livery'],
                  ),
        ),
        'setJet': _is.MethodConnector(
          name: 'setJet',
          params: {
            'livery': _is.ParameterDescription(
              name: 'livery',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'showName': _is.ParameterDescription(
              name: 'showName',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).setJet(
                    session,
                    params['livery'],
                    params['showName'],
                  ),
        ),
        'flyJet': _is.MethodConnector(
          name: 'flyJet',
          params: {
            'dest': _is.ParameterDescription(
              name: 'dest',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).flyJet(
                    session,
                    params['dest'],
                  ),
        ),
        'publicProfile': _is.MethodConnector(
          name: 'publicProfile',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .publicProfile(
                    session,
                    params['handle'],
                  ),
        ),
        'people': _is.MethodConnector(
          name: 'people',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).people(
                    session,
                    params['query'],
                  ),
        ),
        'pushSubscribe': _is.MethodConnector(
          name: 'pushSubscribe',
          params: {
            'endpoint': _is.ParameterDescription(
              name: 'endpoint',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .pushSubscribe(
                    session,
                    params['endpoint'],
                  ),
        ),
        'wake': _is.MethodConnector(
          name: 'wake',
          params: {
            'ver': _is.ParameterDescription(
              name: 'ver',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).wake(
                    session,
                    params['ver'],
                  ),
        ),
        'friendRequest': _is.MethodConnector(
          name: 'friendRequest',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .friendRequest(
                    session,
                    params['handle'],
                    params['note'],
                  ),
        ),
        'friendRespond': _is.MethodConnector(
          name: 'friendRespond',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accept': _is.ParameterDescription(
              name: 'accept',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .friendRespond(
                    session,
                    params['handle'],
                    params['accept'],
                  ),
        ),
        'unfriend': _is.MethodConnector(
          name: 'unfriend',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .unfriend(
                    session,
                    params['handle'],
                  ),
        ),
        'friends': _is.MethodConnector(
          name: 'friends',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .friends(session),
        ),
        'room': _is.MethodConnector(
          name: 'room',
          params: {
            'key': _is.ParameterDescription(
              name: 'key',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).room(
                    session,
                    params['key'],
                  ),
        ),
        'saveRoom': _is.MethodConnector(
          name: 'saveRoom',
          params: {
            'key': _is.ParameterDescription(
              name: 'key',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'layout': _is.ParameterDescription(
              name: 'layout',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .saveRoom(
                    session,
                    params['key'],
                    params['layout'],
                  ),
        ),
        'deliverFurniture': _is.MethodConnector(
          name: 'deliverFurniture',
          params: {
            'key': _is.ParameterDescription(
              name: 'key',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'layout': _is.ParameterDescription(
              name: 'layout',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mode': _is.ParameterDescription(
              name: 'mode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .deliverFurniture(
                    session,
                    params['key'],
                    params['layout'],
                    params['mode'],
                  ),
        ),
        'topUpInfo': _is.MethodConnector(
          name: 'topUpInfo',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .topUpInfo(session),
        ),
        'topUpStart': _is.MethodConnector(
          name: 'topUpStart',
          params: {
            'pack': _is.ParameterDescription(
              name: 'pack',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'returnTo': _is.ParameterDescription(
              name: 'returnTo',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .topUpStart(
                    session,
                    params['pack'],
                    params['returnTo'],
                  ),
        ),
        'payoutBanks': _is.MethodConnector(
          name: 'payoutBanks',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutBanks(session),
        ),
        'payoutAccount': _is.MethodConnector(
          name: 'payoutAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutAccount(session),
        ),
        'payoutAccountSet': _is.MethodConnector(
          name: 'payoutAccountSet',
          params: {
            'bankCode': _is.ParameterDescription(
              name: 'bankCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accountNumber': _is.ParameterDescription(
              name: 'accountNumber',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'legalName': _is.ParameterDescription(
              name: 'legalName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'dateOfBirth': _is.ParameterDescription(
              name: 'dateOfBirth',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutAccountSet(
                    session,
                    params['bankCode'],
                    params['accountNumber'],
                    params['legalName'],
                    params['email'],
                    params['dateOfBirth'],
                    params['password'],
                  ),
        ),
        'payoutAccountVerify': _is.MethodConnector(
          name: 'payoutAccountVerify',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutAccountVerify(
                    session,
                    params['code'],
                  ),
        ),
        'payoutAccountResend': _is.MethodConnector(
          name: 'payoutAccountResend',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutAccountResend(session),
        ),
        'payoutAcceptTerms': _is.MethodConnector(
          name: 'payoutAcceptTerms',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutAcceptTerms(session),
        ),
        'withdrawToBank': _is.MethodConnector(
          name: 'withdrawToBank',
          params: {
            'amountKobo': _is.ParameterDescription(
              name: 'amountKobo',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'requestKey': _is.ParameterDescription(
              name: 'requestKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .withdrawToBank(
                    session,
                    params['amountKobo'],
                    params['requestKey'],
                  ),
        ),
        'payoutQueue': _is.MethodConnector(
          name: 'payoutQueue',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutQueue(session),
        ),
        'payoutStop': _is.MethodConnector(
          name: 'payoutStop',
          params: {
            'ref': _is.ParameterDescription(
              name: 'ref',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .payoutStop(
                    session,
                    params['ref'],
                  ),
        ),
        'treasury2': _is.MethodConnector(
          name: 'treasury2',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .treasury2(session),
        ),
        'topUpHistory': _is.MethodConnector(
          name: 'topUpHistory',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .topUpHistory(session),
        ),
        'topUpCheck': _is.MethodConnector(
          name: 'topUpCheck',
          params: {
            'ref': _is.ParameterDescription(
              name: 'ref',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .topUpCheck(
                    session,
                    params['ref'],
                  ),
        ),
        'shows': _is.MethodConnector(
          name: 'shows',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .shows(session),
        ),
        'hostShow': _is.MethodConnector(
          name: 'hostShow',
          params: {
            'artist': _is.ParameterDescription(
              name: 'artist',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startsAt': _is.ParameterDescription(
              name: 'startsAt',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'minutes': _is.ParameterDescription(
              name: 'minutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'price': _is.ParameterDescription(
              name: 'price',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .hostShow(
                    session,
                    params['artist'],
                    params['title'],
                    params['startsAt'],
                    params['minutes'],
                    params['price'],
                  ),
        ),
        'pendingShows': _is.MethodConnector(
          name: 'pendingShows',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .pendingShows(session),
        ),
        'reviewShow': _is.MethodConnector(
          name: 'reviewShow',
          params: {
            'showId': _is.ParameterDescription(
              name: 'showId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approve': _is.ParameterDescription(
              name: 'approve',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .reviewShow(
                    session,
                    params['showId'],
                    params['approve'],
                  ),
        ),
        'buyTicket': _is.MethodConnector(
          name: 'buyTicket',
          params: {
            'showId': _is.ParameterDescription(
              name: 'showId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint)
                  .buyTicket(
                    session,
                    params['showId'],
                  ),
        ),
        'stage': _is.MethodConnector(
          name: 'stage',
          params: {
            'showId': _is.ParameterDescription(
              name: 'showId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'since': _is.ParameterDescription(
              name: 'since',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).stage(
                    session,
                    params['showId'],
                    params['since'],
                  ),
        ),
        'perform': _is.MethodConnector(
          name: 'perform',
          params: {
            'showId': _is.ParameterDescription(
              name: 'showId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).perform(
                    session,
                    params['showId'],
                    params['text'],
                  ),
        ),
        'askWyrd': _is.MethodConnector(
          name: 'askWyrd',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'district': _is.ParameterDescription(
              name: 'district',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['islandMe'] as _ixszl6xq.IslandMeEndpoint).askWyrd(
                    session,
                    params['text'],
                    params['district'],
                  ),
        ),
      },
    );
    connectors['konnectly'] = _is.EndpointConnector(
      name: 'konnectly',
      endpoint: endpoints['konnectly']!,
      methodConnectors: {
        'status': _is.MethodConnector(
          name: 'status',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['konnectly'] as _i79gaqir.KonnectlyEndpoint)
                  .status(session),
        ),
        'writeListing': _is.MethodConnector(
          name: 'writeListing',
          params: {
            'imageBase64Jpeg': _is.ParameterDescription(
              name: 'imageBase64Jpeg',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'campus': _is.ParameterDescription(
              name: 'campus',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['konnectly'] as _i79gaqir.KonnectlyEndpoint)
                  .writeListing(
                    session,
                    params['imageBase64Jpeg'],
                    note: params['note'],
                    campus: params['campus'],
                  ),
        ),
        'care': _is.MethodConnector(
          name: 'care',
          params: {
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lastTopic': _is.ParameterDescription(
              name: 'lastTopic',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['konnectly'] as _i79gaqir.KonnectlyEndpoint).care(
                    session,
                    params['message'],
                    lastTopic: params['lastTopic'],
                  ),
        ),
        'checkReceipt': _is.MethodConnector(
          name: 'checkReceipt',
          params: {
            'imageBase64Jpeg': _is.ParameterDescription(
              name: 'imageBase64Jpeg',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'expectedAmount': _is.ParameterDescription(
              name: 'expectedAmount',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'expectedAccount': _is.ParameterDescription(
              name: 'expectedAccount',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['konnectly'] as _i79gaqir.KonnectlyEndpoint)
                  .checkReceipt(
                    session,
                    params['imageBase64Jpeg'],
                    expectedAmount: params['expectedAmount'],
                    expectedAccount: params['expectedAccount'],
                  ),
        ),
      },
    );
    connectors['account'] = _is.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'exportData': _is.MethodConnector(
          name: 'exportData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i45717np.AccountEndpoint)
                  .exportData(session),
        ),
        'deleteMyData': _is.MethodConnector(
          name: 'deleteMyData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i45717np.AccountEndpoint)
                  .deleteMyData(session),
        ),
      },
    );
    connectors['alerts'] = _is.EndpointConnector(
      name: 'alerts',
      endpoint: endpoints['alerts']!,
      methodConnectors: {
        'getAlerts': _is.MethodConnector(
          name: 'getAlerts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['alerts'] as _impqu952.AlertsEndpoint)
                  .getAlerts(session),
        ),
      },
    );
    connectors['brain'] = _is.EndpointConnector(
      name: 'brain',
      endpoint: endpoints['brain']!,
      methodConnectors: {
        'getMap': _is.MethodConnector(
          name: 'getMap',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['brain'] as _iskgx6uk.BrainEndpoint).getMap(
                session,
              ),
        ),
      },
    );
    connectors['chat'] = _is.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'sendMessage': _is.MethodConnector(
          name: 'sendMessage',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'passages': _is.ParameterDescription(
              name: 'passages',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'screen': _is.ParameterDescription(
              name: 'screen',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i2b8uve4.ChatEndpoint).sendMessage(
                    session,
                    params['text'],
                    passages: params['passages'],
                    screen: params['screen'],
                  ),
        ),
        'getHistory': _is.MethodConnector(
          name: 'getHistory',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i2b8uve4.ChatEndpoint).getHistory(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'chats': _is.MethodConnector(
          name: 'chats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i2b8uve4.ChatEndpoint).chats(session),
        ),
        'newChat': _is.MethodConnector(
          name: 'newChat',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i2b8uve4.ChatEndpoint).newChat(
                session,
              ),
        ),
        'openChat': _is.MethodConnector(
          name: 'openChat',
          params: {
            'chatId': _is.ParameterDescription(
              name: 'chatId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i2b8uve4.ChatEndpoint).openChat(
                session,
                params['chatId'],
              ),
        ),
        'rate': _is.MethodConnector(
          name: 'rate',
          params: {
            'turnId': _is.ParameterDescription(
              name: 'turnId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'rating': _is.ParameterDescription(
              name: 'rating',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i2b8uve4.ChatEndpoint).rate(
                session,
                params['turnId'],
                params['rating'],
              ),
        ),
      },
    );
    connectors['curriculum'] = _is.EndpointConnector(
      name: 'curriculum',
      endpoint: endpoints['curriculum']!,
      methodConnectors: {
        'getStatus': _is.MethodConnector(
          name: 'getStatus',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['curriculum'] as _i7sq3i85.CurriculumEndpoint)
                      .getStatus(session),
        ),
      },
    );
    connectors['dashboard'] = _is.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _iqbis52t.DashboardEndpoint)
                  .get(session),
        ),
        'runEval': _is.MethodConnector(
          name: 'runEval',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _iqbis52t.DashboardEndpoint)
                  .runEval(session),
        ),
        'evalRun': _is.MethodConnector(
          name: 'evalRun',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _iqbis52t.DashboardEndpoint)
                  .evalRun(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['diary'] = _is.EndpointConnector(
      name: 'diary',
      endpoint: endpoints['diary']!,
      methodConnectors: {
        'getEntries': _is.MethodConnector(
          name: 'getEntries',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['diary'] as _i71dg2tj.DiaryEndpoint).getEntries(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['diary'] as _i71dg2tj.DiaryEndpoint)
                  .trigger(session),
        ),
      },
    );
    connectors['document'] = _is.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'upload': _is.MethodConnector(
          name: 'upload',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'pages': _is.ParameterDescription(
              name: 'pages',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'staged': _is.ParameterDescription(
              name: 'staged',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'words': _is.ParameterDescription(
              name: 'words',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _i7txdnsa.DocumentEndpoint).upload(
                    session,
                    params['name'],
                    params['kind'],
                    params['text'],
                    pages: params['pages'],
                    staged: params['staged'],
                    words: params['words'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i7txdnsa.DocumentEndpoint)
                  .list(session),
        ),
        'remove': _is.MethodConnector(
          name: 'remove',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _i7txdnsa.DocumentEndpoint).remove(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['dream'] = _is.EndpointConnector(
      name: 'dream',
      endpoint: endpoints['dream']!,
      methodConnectors: {
        'getEntries': _is.MethodConnector(
          name: 'getEntries',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dream'] as _inxbi04j.DreamEndpoint).getEntries(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dream'] as _inxbi04j.DreamEndpoint)
                  .trigger(session),
        ),
        'getStars': _is.MethodConnector(
          name: 'getStars',
          params: {
            'dreamId': _is.ParameterDescription(
              name: 'dreamId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dream'] as _inxbi04j.DreamEndpoint).getStars(
                    session,
                    params['dreamId'],
                  ),
        ),
      },
    );
    connectors['feed'] = _is.EndpointConnector(
      name: 'feed',
      endpoint: endpoints['feed']!,
      methodConnectors: {
        'getRecent': _is.MethodConnector(
          name: 'getRecent',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _in0i7e4k.FeedEndpoint)
                  .getRecent(session),
        ),
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _in0i7e4k.FeedEndpoint).trigger(
                session,
              ),
        ),
        'getFilterReport': _is.MethodConnector(
          name: 'getFilterReport',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _in0i7e4k.FeedEndpoint)
                  .getFilterReport(session),
        ),
        'getTrust': _is.MethodConnector(
          name: 'getTrust',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _in0i7e4k.FeedEndpoint).getTrust(
                session,
              ),
        ),
        'getJudgementReport': _is.MethodConnector(
          name: 'getJudgementReport',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _in0i7e4k.FeedEndpoint)
                  .getJudgementReport(session),
        ),
      },
    );
    connectors['gateShape'] = _is.EndpointConnector(
      name: 'gateShape',
      endpoint: endpoints['gateShape']!,
      methodConnectors: {
        'next': _is.MethodConnector(
          name: 'next',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['gateShape'] as _ix7nnscc.GateShapeEndpoint)
                  .next(session),
        ),
      },
    );
    connectors['growth'] = _is.EndpointConnector(
      name: 'growth',
      endpoint: endpoints['growth']!,
      methodConnectors: {
        'getSnapshots': _is.MethodConnector(
          name: 'getSnapshots',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['growth'] as _idrisijy.GrowthEndpoint)
                  .getSnapshots(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getHistory': _is.MethodConnector(
          name: 'getHistory',
          params: {
            'range': _is.ParameterDescription(
              name: 'range',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['growth'] as _idrisijy.GrowthEndpoint).getHistory(
                    session,
                    params['range'],
                  ),
        ),
        'getLearning': _is.MethodConnector(
          name: 'getLearning',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['growth'] as _idrisijy.GrowthEndpoint)
                  .getLearning(session),
        ),
      },
    );
    connectors['lexicon'] = _is.EndpointConnector(
      name: 'lexicon',
      endpoint: endpoints['lexicon']!,
      methodConnectors: {
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lexicon'] as _i3c3oo5r.LexiconEndpoint)
                  .trigger(session),
        ),
        'wordnetStatus': _is.MethodConnector(
          name: 'wordnetStatus',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lexicon'] as _i3c3oo5r.LexiconEndpoint)
                  .wordnetStatus(session),
        ),
        'getStats': _is.MethodConnector(
          name: 'getStats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lexicon'] as _i3c3oo5r.LexiconEndpoint)
                  .getStats(session),
        ),
        'getWord': _is.MethodConnector(
          name: 'getWord',
          params: {
            'word': _is.ParameterDescription(
              name: 'word',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['lexicon'] as _i3c3oo5r.LexiconEndpoint).getWord(
                    session,
                    params['word'],
                  ),
        ),
      },
    );
    connectors['library'] = _is.EndpointConnector(
      name: 'library',
      endpoint: endpoints['library']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _ifaqo2up.LibraryEndpoint)
                  .list(session),
        ),
        'readOn': _is.MethodConnector(
          name: 'readOn',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'restart': _is.ParameterDescription(
              name: 'restart',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'part': _is.ParameterDescription(
              name: 'part',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).readOn(
                    session,
                    params['id'],
                    restart: params['restart'],
                    part: params['part'],
                  ),
        ),
        'current': _is.MethodConnector(
          name: 'current',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).current(
                    session,
                    params['id'],
                  ),
        ),
        'quiz': _is.MethodConnector(
          name: 'quiz',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'passage': _is.ParameterDescription(
              name: 'passage',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).quiz(
                    session,
                    params['id'],
                    params['passage'],
                  ),
        ),
        'quizDone': _is.MethodConnector(
          name: 'quizDone',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'correct': _is.ParameterDescription(
              name: 'correct',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'total': _is.ParameterDescription(
              name: 'total',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'missed': _is.ParameterDescription(
              name: 'missed',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).quizDone(
                    session,
                    params['id'],
                    params['correct'],
                    params['total'],
                    params['missed'],
                  ),
        ),
        'quizStats': _is.MethodConnector(
          name: 'quizStats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _ifaqo2up.LibraryEndpoint)
                  .quizStats(session),
        ),
        'contents': _is.MethodConnector(
          name: 'contents',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).contents(
                    session,
                    params['id'],
                  ),
        ),
        'openBook': _is.MethodConnector(
          name: 'openBook',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).openBook(
                    session,
                    params['query'],
                  ),
        ),
        'openWork': _is.MethodConnector(
          name: 'openWork',
          params: {
            'source': _is.ParameterDescription(
              name: 'source',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).openWork(
                    session,
                    params['source'],
                    params['id'],
                  ),
        ),
        'textbooks': _is.MethodConnector(
          name: 'textbooks',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _ifaqo2up.LibraryEndpoint)
                  .textbooks(session),
        ),
        'searchWikisource': _is.MethodConnector(
          name: 'searchWikisource',
          params: {
            'lang': _is.ParameterDescription(
              name: 'lang',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _ifaqo2up.LibraryEndpoint)
                  .searchWikisource(
                    session,
                    params['lang'],
                    params['query'],
                  ),
        ),
        'wikisourceLanguages': _is.MethodConnector(
          name: 'wikisourceLanguages',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _ifaqo2up.LibraryEndpoint)
                  .wikisourceLanguages(session),
        ),
        'searchBooks': _is.MethodConnector(
          name: 'searchBooks',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _ifaqo2up.LibraryEndpoint)
                  .searchBooks(
                    session,
                    params['query'],
                  ),
        ),
        'remove': _is.MethodConnector(
          name: 'remove',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _ifaqo2up.LibraryEndpoint).remove(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['memory'] = _is.EndpointConnector(
      name: 'memory',
      endpoint: endpoints['memory']!,
      methodConnectors: {
        'getMemory': _is.MethodConnector(
          name: 'getMemory',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['memory'] as _ibdzbeap.MemoryEndpoint)
                  .getMemory(session),
        ),
        'getConcepts': _is.MethodConnector(
          name: 'getConcepts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['memory'] as _ibdzbeap.MemoryEndpoint)
                  .getConcepts(session),
        ),
        'getConceptDetail': _is.MethodConnector(
          name: 'getConceptDetail',
          params: {
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['memory'] as _ibdzbeap.MemoryEndpoint)
                  .getConceptDetail(
                    session,
                    params['topic'],
                  ),
        ),
        'embeddingStatus': _is.MethodConnector(
          name: 'embeddingStatus',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['memory'] as _ibdzbeap.MemoryEndpoint)
                  .embeddingStatus(session),
        ),
      },
    );
    connectors['mind'] = _is.EndpointConnector(
      name: 'mind',
      endpoint: endpoints['mind']!,
      methodConnectors: {
        'getMind': _is.MethodConnector(
          name: 'getMind',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mind'] as _i2dwy8oi.MindEndpoint).getMind(
                session,
              ),
        ),
      },
    );
    connectors['owner'] = _is.EndpointConnector(
      name: 'owner',
      endpoint: endpoints['owner']!,
      methodConnectors: {
        'userStats': _is.MethodConnector(
          name: 'userStats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['owner'] as _i5tlqn06.OwnerEndpoint)
                  .userStats(session),
        ),
      },
    );
    connectors['photo'] = _is.EndpointConnector(
      name: 'photo',
      endpoint: endpoints['photo']!,
      methodConnectors: {
        'describe': _is.MethodConnector(
          name: 'describe',
          params: {
            'imageBase64Jpeg': _is.ParameterDescription(
              name: 'imageBase64Jpeg',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'caption': _is.ParameterDescription(
              name: 'caption',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'trackingNote': _is.ParameterDescription(
              name: 'trackingNote',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'thumb': _is.ParameterDescription(
              name: 'thumb',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['photo'] as _ij44nk8s.PhotoEndpoint).describe(
                    session,
                    params['imageBase64Jpeg'],
                    caption: params['caption'],
                    trackingNote: params['trackingNote'],
                    thumb: params['thumb'],
                  ),
        ),
        'getSightings': _is.MethodConnector(
          name: 'getSightings',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['photo'] as _ij44nk8s.PhotoEndpoint).getSightings(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getProfile': _is.MethodConnector(
          name: 'getProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _in0jvng1.ProfileEndpoint)
                  .getProfile(session),
        ),
        'touchVisit': _is.MethodConnector(
          name: 'touchVisit',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _in0jvng1.ProfileEndpoint)
                  .touchVisit(session),
        ),
        'forgetFact': _is.MethodConnector(
          name: 'forgetFact',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _in0jvng1.ProfileEndpoint)
                  .forgetFact(
                    session,
                    params['text'],
                  ),
        ),
        'setUsername': _is.MethodConnector(
          name: 'setUsername',
          params: {
            'username': _is.ParameterDescription(
              name: 'username',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _in0jvng1.ProfileEndpoint)
                  .setUsername(
                    session,
                    params['username'],
                  ),
        ),
        'setAvatar': _is.MethodConnector(
          name: 'setAvatar',
          params: {
            'dataUrl': _is.ParameterDescription(
              name: 'dataUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _in0jvng1.ProfileEndpoint).setAvatar(
                    session,
                    params['dataUrl'],
                  ),
        ),
      },
    );
    connectors['reasoning'] = _is.EndpointConnector(
      name: 'reasoning',
      endpoint: endpoints['reasoning']!,
      methodConnectors: {
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reasoning'] as _iovbjp1a.ReasoningEndpoint)
                  .trigger(session),
        ),
        'getNotes': _is.MethodConnector(
          name: 'getNotes',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reasoning'] as _iovbjp1a.ReasoningEndpoint)
                  .getNotes(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getNetwork': _is.MethodConnector(
          name: 'getNetwork',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reasoning'] as _iovbjp1a.ReasoningEndpoint)
                  .getNetwork(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['selfConfig'] = _is.EndpointConnector(
      name: 'selfConfig',
      endpoint: endpoints['selfConfig']!,
      methodConnectors: {
        'getConfig': _is.MethodConnector(
          name: 'getConfig',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['selfConfig'] as _iuprx8k1.SelfConfigEndpoint)
                      .getConfig(session),
        ),
        'getCopLog': _is.MethodConnector(
          name: 'getCopLog',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['selfConfig'] as _iuprx8k1.SelfConfigEndpoint)
                      .getCopLog(
                        session,
                        limit: params['limit'],
                      ),
        ),
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['selfConfig'] as _iuprx8k1.SelfConfigEndpoint)
                      .trigger(session),
        ),
      },
    );
    connectors['selfQuestion'] = _is.EndpointConnector(
      name: 'selfQuestion',
      endpoint: endpoints['selfQuestion']!,
      methodConnectors: {
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['selfQuestion'] as _i4qouglj.SelfQuestionEndpoint)
                      .trigger(session),
        ),
      },
    );
    connectors['status'] = _is.EndpointConnector(
      name: 'status',
      endpoint: endpoints['status']!,
      methodConnectors: {
        'getStatus': _is.MethodConnector(
          name: 'getStatus',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['status'] as _ik9coqrp.StatusEndpoint)
                  .getStatus(session),
        ),
      },
    );
    connectors['synthesis'] = _is.EndpointConnector(
      name: 'synthesis',
      endpoint: endpoints['synthesis']!,
      methodConnectors: {
        'trigger': _is.MethodConnector(
          name: 'trigger',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['synthesis'] as _i6ave7v9.SynthesisEndpoint)
                  .trigger(session),
        ),
      },
    );
    connectors['topic'] = _is.EndpointConnector(
      name: 'topic',
      endpoint: endpoints['topic']!,
      methodConnectors: {
        'getTopic': _is.MethodConnector(
          name: 'getTopic',
          params: {
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['topic'] as _i2t0sh8b.TopicEndpoint).getTopic(
                    session,
                    params['topic'],
                  ),
        ),
      },
    );
    connectors['training'] = _is.EndpointConnector(
      name: 'training',
      endpoint: endpoints['training']!,
      methodConnectors: {
        'stats': _is.MethodConnector(
          name: 'stats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _igyenhzn.TrainingEndpoint)
                  .stats(session),
        ),
        'export': _is.MethodConnector(
          name: 'export',
          params: {
            'part': _is.ParameterDescription(
              name: 'part',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _igyenhzn.TrainingEndpoint).export(
                    session,
                    params['part'],
                  ),
        ),
      },
    );
    connectors['world'] = _is.EndpointConnector(
      name: 'world',
      endpoint: endpoints['world']!,
      methodConnectors: {
        'getCountries': _is.MethodConnector(
          name: 'getCountries',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['world'] as _iaj95ngr.WorldEndpoint)
                  .getCountries(session),
        ),
        'getCountry': _is.MethodConnector(
          name: 'getCountry',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['world'] as _iaj95ngr.WorldEndpoint).getCountry(
                    session,
                    params['code'],
                  ),
        ),
      },
    );
    connectors['partnerAdmin'] = _is.EndpointConnector(
      name: 'partnerAdmin',
      endpoint: endpoints['partnerAdmin']!,
      methodConnectors: {
        'issueKey': _is.MethodConnector(
          name: 'issueKey',
          params: {
            'partner': _is.ParameterDescription(
              name: 'partner',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'env': _is.ParameterDescription(
              name: 'env',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'label': _is.ParameterDescription(
              name: 'label',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['partnerAdmin'] as _iaek1pkr.PartnerAdminEndpoint)
                      .issueKey(
                        session,
                        params['partner'],
                        params['env'],
                        params['label'],
                      ),
        ),
        'revokeKey': _is.MethodConnector(
          name: 'revokeKey',
          params: {
            'prefix': _is.ParameterDescription(
              name: 'prefix',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['partnerAdmin'] as _iaek1pkr.PartnerAdminEndpoint)
                      .revokeKey(
                        session,
                        params['prefix'],
                      ),
        ),
        'openStaging': _is.MethodConnector(
          name: 'openStaging',
          params: {
            'partner': _is.ParameterDescription(
              name: 'partner',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['partnerAdmin'] as _iaek1pkr.PartnerAdminEndpoint)
                      .openStaging(
                        session,
                        params['partner'],
                        params['note'],
                      ),
        ),
        'selfTest': _is.MethodConnector(
          name: 'selfTest',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['partnerAdmin'] as _iaek1pkr.PartnerAdminEndpoint)
                      .selfTest(session),
        ),
        'keys': _is.MethodConnector(
          name: 'keys',
          params: {
            'partner': _is.ParameterDescription(
              name: 'partner',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['partnerAdmin'] as _iaek1pkr.PartnerAdminEndpoint)
                      .keys(
                        session,
                        params['partner'],
                      ),
        ),
      },
    );
    connectors['city'] = _is.EndpointConnector(
      name: 'city',
      endpoint: endpoints['city']!,
      methodConnectors: {
        'address': _is.MethodConnector(
          name: 'address',
          params: {
            'channel': _is.ParameterDescription(
              name: 'channel',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'situation': _is.ParameterDescription(
              name: 'situation',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).address(
                session,
                params['channel'],
                params['text'],
                params['situation'],
              ),
        ),
        'wallet': _is.MethodConnector(
          name: 'wallet',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).wallet(session),
        ),
        'homes': _is.MethodConnector(
          name: 'homes',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).homes(session),
        ),
        'takeHome': _is.MethodConnector(
          name: 'takeHome',
          params: {
            'slug': _is.ParameterDescription(
              name: 'slug',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mode': _is.ParameterDescription(
              name: 'mode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).takeHome(
                session,
                params['slug'],
                params['mode'],
              ),
        ),
        'leaveHome': _is.MethodConnector(
          name: 'leaveHome',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .leaveHome(session),
        ),
        'pay': _is.MethodConnector(
          name: 'pay',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).pay(
                session,
                params['reason'],
              ),
        ),
        'missionPaid': _is.MethodConnector(
          name: 'missionPaid',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).missionPaid(
                    session,
                    params['id'],
                  ),
        ),
        'placeActivities': _is.MethodConnector(
          name: 'placeActivities',
          params: {
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).placeActivities(
                    session,
                    params['kind'],
                  ),
        ),
        'visit': _is.MethodConnector(
          name: 'visit',
          params: {
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'activity': _is.ParameterDescription(
              name: 'activity',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'place': _is.ParameterDescription(
              name: 'place',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).visit(
                session,
                params['kind'],
                params['activity'],
                params['place'],
              ),
        ),
        'jobStart': _is.MethodConnector(
          name: 'jobStart',
          params: {
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).jobStart(
                session,
                params['type'],
              ),
        ),
        'jobFinish': _is.MethodConnector(
          name: 'jobFinish',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'dist': _is.ParameterDescription(
              name: 'dist',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'passengers': _is.ParameterDescription(
              name: 'passengers',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limitS': _is.ParameterDescription(
              name: 'limitS',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).jobFinish(
                    session,
                    params['id'],
                    params['dist'],
                    params['passengers'],
                    params['limitS'],
                  ),
        ),
        'guideMark': _is.MethodConnector(
          name: 'guideMark',
          params: {
            'step': _is.ParameterDescription(
              name: 'step',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).guideMark(
                    session,
                    params['step'],
                  ),
        ),
        'guideSkip': _is.MethodConnector(
          name: 'guideSkip',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .guideSkip(session),
        ),
        'pulse': _is.MethodConnector(
          name: 'pulse',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).pulse(session),
        ),
        'stats': _is.MethodConnector(
          name: 'stats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).stats(session),
        ),
        'status': _is.MethodConnector(
          name: 'status',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).status(session),
        ),
        'wire': _is.MethodConnector(
          name: 'wire',
          params: {
            'since': _is.ParameterDescription(
              name: 'since',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).wire(
                session,
                params['since'],
              ),
        ),
        'signals': _is.MethodConnector(
          name: 'signals',
          params: {
            'batch': _is.ParameterDescription(
              name: 'batch',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).signals(
                session,
                params['batch'],
              ),
        ),
        'charter': _is.MethodConnector(
          name: 'charter',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).charter(
                session,
              ),
        ),
        'design': _is.MethodConnector(
          name: 'design',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).design(session),
        ),
        'setTraining': _is.MethodConnector(
          name: 'setTraining',
          params: {
            'optIn': _is.ParameterDescription(
              name: 'optIn',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).setTraining(
                    session,
                    params['optIn'],
                  ),
        ),
        'myCharacter': _is.MethodConnector(
          name: 'myCharacter',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .myCharacter(session),
        ),
        'saveCharacter': _is.MethodConnector(
          name: 'saveCharacter',
          params: {
            'character': _is.ParameterDescription(
              name: 'character',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).saveCharacter(
                    session,
                    params['character'],
                  ),
        ),
        'canDesign': _is.MethodConnector(
          name: 'canDesign',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .canDesign(session),
        ),
        'designChat': _is.MethodConnector(
          name: 'designChat',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).designChat(
                    session,
                    params['text'],
                  ),
        ),
        'designNotes': _is.MethodConnector(
          name: 'designNotes',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .designNotes(session),
        ),
        'policeReport': _is.MethodConnector(
          name: 'policeReport',
          params: {
            'report': _is.ParameterDescription(
              name: 'report',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).policeReport(
                    session,
                    params['report'],
                  ),
        ),
        'policeTick': _is.MethodConnector(
          name: 'policeTick',
          params: {
            'tick': _is.ParameterDescription(
              name: 'tick',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).policeTick(
                    session,
                    params['tick'],
                  ),
        ),
        'policeCall': _is.MethodConnector(
          name: 'policeCall',
          params: {
            'contact': _is.ParameterDescription(
              name: 'contact',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).policeCall(
                    session,
                    params['contact'],
                  ),
        ),
        'policeCitations': _is.MethodConnector(
          name: 'policeCitations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .policeCitations(session),
        ),
        'policeAppeal': _is.MethodConnector(
          name: 'policeAppeal',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).policeAppeal(
                    session,
                    params['id'],
                    params['reason'],
                  ),
        ),
        'policeSettings': _is.MethodConnector(
          name: 'policeSettings',
          params: {
            'calm': _is.ParameterDescription(
              name: 'calm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).policeSettings(
                    session,
                    params['calm'],
                  ),
        ),
        'refundRide': _is.MethodConnector(
          name: 'refundRide',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .refundRide(session),
        ),
        'dispute': _is.MethodConnector(
          name: 'dispute',
          params: {
            'ref': _is.ParameterDescription(
              name: 'ref',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).dispute(
                session,
                params['ref'],
                params['reason'],
              ),
        ),
        'receipts': _is.MethodConnector(
          name: 'receipts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).receipts(
                session,
              ),
        ),
        'ledgerAudit': _is.MethodConnector(
          name: 'ledgerAudit',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint)
                  .ledgerAudit(session),
        ),
        'story': _is.MethodConnector(
          name: 'story',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).story(session),
        ),
        'storyAct': _is.MethodConnector(
          name: 'storyAct',
          params: {
            'mission': _is.ParameterDescription(
              name: 'mission',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'move': _is.ParameterDescription(
              name: 'move',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['city'] as _ifkdhb4n.CityEndpoint).storyAct(
                session,
                params['mission'],
                params['move'],
              ),
        ),
        'designDecide': _is.MethodConnector(
          name: 'designDecide',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approve': _is.ParameterDescription(
              name: 'approve',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['city'] as _ifkdhb4n.CityEndpoint).designDecide(
                    session,
                    params['id'],
                    params['approve'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ix7un2io.FutureCalls();
  }
}
