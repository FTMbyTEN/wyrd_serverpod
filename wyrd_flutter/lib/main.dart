import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'client.dart';
import 'screens/wyrd_shell.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const WyrdApp());
}

class WyrdApp extends StatelessWidget {
  const WyrdApp({super.key});

  @override
  Widget build(BuildContext context) {
    // WYRD's terminal-green aesthetic is always dark -- there is no light variant, same as the
    // React Native app.
    return MaterialApp(
      title: 'WYRD',
      theme: buildWyrdTheme(),
      themeMode: ThemeMode.dark,
      home: const AuthGate(),
    );
  }
}

/// Shows the email sign-in flow until the session is authenticated, then the main app shell.
/// [client.authSessionManager] is a [ValueListenable], so this rebuilds automatically the
/// moment sign-in/sign-out completes -- no manual navigation needed either way.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: client.authSessionManager.authInfoListenable,
      builder: (context, authInfo, _) {
        if (authInfo == null) {
          return Scaffold(
            backgroundColor: WyrdColors.bg,
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: EmailSignInWidget(
                      client: client,
                      onAuthenticated: () {
                        // fire-and-forget: mirrors server.js's touchProfileVisit on
                        // register/login, which has no direct hook in the built-in IDP flow.
                        client.profile.touchVisit();
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const WyrdShell();
      },
    );
  }
}
