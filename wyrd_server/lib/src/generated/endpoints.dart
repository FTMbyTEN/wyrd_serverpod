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
import 'package:wyrd_server/src/generated/future_calls.dart' as _ix7un2io;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../mind/chat_endpoint.dart' as _i2b8uve4;
import '../mind/diary_endpoint.dart' as _i71dg2tj;
import '../mind/dream_endpoint.dart' as _inxbi04j;
import '../mind/growth_endpoint.dart' as _idrisijy;
import '../mind/lexicon_endpoint.dart' as _i3c3oo5r;
import '../mind/memory_endpoint.dart' as _ibdzbeap;
import '../mind/mind_endpoint.dart' as _i2dwy8oi;
import '../mind/profile_endpoint.dart' as _in0jvng1;
import '../mind/reasoning_endpoint.dart' as _iovbjp1a;
import '../mind/self_question_endpoint.dart' as _i4qouglj;
import '../mind/synthesis_endpoint.dart' as _i6ave7v9;
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
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'chat': _i2b8uve4.ChatEndpoint()
        ..initialize(
          server,
          'chat',
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
      'selfQuestion': _i4qouglj.SelfQuestionEndpoint()
        ..initialize(
          server,
          'selfQuestion',
          null,
        ),
      'synthesis': _i6ave7v9.SynthesisEndpoint()
        ..initialize(
          server,
          'synthesis',
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
