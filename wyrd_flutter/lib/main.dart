import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'client.dart';
import 'screens/auth_panel.dart';
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
    // Warm Lagos, as in the main app: day or night from the device, switched by the header's
    // sun/moon button; every screen is redrawn in the new colours (theme.dart)
    return ValueListenableBuilder<bool>(
      valueListenable: WyrdColors.night,
      builder: (context, night, _) => MaterialApp(
        key: ValueKey(night),
        title: 'WYRD',
        debugShowCheckedModeBanner: false,
        theme: buildWyrdTheme(),
        home: const AuthGate(),
      ),
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
                  constraints: const BoxConstraints(maxWidth: 440),
                  // the main app's sign-in card (screens/auth_panel.dart)
                  child: const SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: AuthPanel(),
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
