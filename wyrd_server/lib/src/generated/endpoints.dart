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
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../drone/drone_bridge_endpoint.dart' as _igomlm42;
import '../drone/drone_endpoint.dart' as _iec5mi4p;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../mind/account_endpoint.dart' as _i45717np;
import '../mind/alerts_endpoint.dart' as _impqu952;
import '../mind/chat_endpoint.dart' as _i2b8uve4;
import '../mind/curriculum_endpoint.dart' as _i7sq3i85;
import '../mind/diary_endpoint.dart' as _i71dg2tj;
import '../mind/dream_endpoint.dart' as _inxbi04j;
import '../mind/feed_endpoint.dart' as _in0i7e4k;
import '../mind/gate_shape_endpoint.dart' as _ix7nnscc;
import '../mind/growth_endpoint.dart' as _idrisijy;
import '../mind/lexicon_endpoint.dart' as _i3c3oo5r;
import '../mind/memory_endpoint.dart' as _ibdzbeap;
import '../mind/mind_endpoint.dart' as _i2dwy8oi;
import '../mind/photo_endpoint.dart' as _ij44nk8s;
import '../mind/profile_endpoint.dart' as _in0jvng1;
import '../mind/reasoning_endpoint.dart' as _iovbjp1a;
import '../mind/self_config_endpoint.dart' as _iuprx8k1;
import '../mind/self_question_endpoint.dart' as _i4qouglj;
import '../mind/status_endpoint.dart' as _ik9coqrp;
import '../mind/synthesis_endpoint.dart' as _i6ave7v9;
import '../mind/topic_endpoint.dart' as _i2t0sh8b;
import '../mind/world_endpoint.dart' as _iaj95ngr;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
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
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
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
      'diary': _i71dg2tj.DiaryEndpoint()
        ..initialize(
          server,
          'diary',
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
      'world': _iaj95ngr.WorldEndpoint()
        ..initialize(
          server,
          'world',
          null,
        ),
    };
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
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i2b8uve4.ChatEndpoint).sendMessage(
                    session,
                    params['text'],
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
