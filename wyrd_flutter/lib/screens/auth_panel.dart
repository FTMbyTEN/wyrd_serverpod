import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../theme.dart';
import 'wyrd_shell.dart' show FaceMark;

/// Sign in, create an account, or reset a forgotten password -- the main app's card (AuthPanel.tsx):
/// a terracotta strip along the top, WYRD's face mark and name, a Sign in / Create account switch,
/// and for sign-up and reset three steps (email -> emailed code -> password) with a step indicator.
/// It uses Serverpod's email sign-in (emailIdp) directly.
class AuthPanel extends StatefulWidget {
  final VoidCallback? onClose;
  final VoidCallback? onActivity; // a step taken: the gate's vortex blooms
  const AuthPanel({super.key, this.onClose, this.onActivity});

  @override
  State<AuthPanel> createState() => _AuthPanelState();
}

enum _Mode { signin, signup, reset }

class _AuthPanelState extends State<AuthPanel> {
  _Mode _mode = _Mode.signin;
  int _step = 1; // sign-up and reset: 1 email, 2 code, 3 password
  bool _busy = false;
  bool _showPassword = false;
  String? _error;
  UuidValue? _requestId;
  String? _token;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  final _callMe = TextEditingController();

  @override
  void dispose() {
    for (final c in [_email, _password, _code, _callMe]) {
      c.dispose();
    }
    super.dispose();
  }

  void _switch(_Mode m) => setState(() {
    _mode = m;
    _step = 1;
    _error = null;
    _code.clear();
    _password.clear();
  });

  String get _heading => switch (_mode) {
    _Mode.signin => 'Welcome back',
    _Mode.signup => 'Create your account',
    _Mode.reset => 'Reset your password',
  };

  String get _blurb {
    if (_mode == _Mode.signin) {
      return 'Sign in to continue your private thread with WYRD.';
    }
    return switch (_step) {
      1 =>
        _mode == _Mode.signup
            ? 'Enter your email and we’ll send you a one-time code.'
            : 'Enter your account email and we’ll send you a reset code.',
      2 => 'Enter the code we sent to ${_email.text.trim()}.',
      _ =>
        _mode == _Mode.signup
            ? 'Choose a password for your account.'
            : 'Choose a new password. You’ll be signed in right after.',
    };
  }

  String get _action {
    if (_mode == _Mode.signin) return 'SIGN IN';
    return switch (_step) {
      1 => 'SEND CODE',
      2 => 'VERIFY CODE',
      _ => _mode == _Mode.signup ? 'CREATE ACCOUNT' : 'SET NEW PASSWORD',
    };
  }

  String _friendly(Object e) {
    final m = e.toString().toLowerCase();
    if (m.contains('invalid') && m.contains('credential') ||
        m.contains('password')) {
      return 'That email and password don’t match.';
    }
    if (m.contains('code')) return 'That code isn’t right, or it has expired.';
    if (m.contains('socket') ||
        m.contains('fetch') ||
        m.contains('connection')) {
      return 'Couldn’t reach WYRD just now. Try again in a moment.';
    }
    return 'That didn’t work. Check the details and try again.';
  }

  Future<void> _submit() async {
    if (_busy) return;
    widget.onActivity?.call();
    final email = _email.text.trim();
    final idp = client.emailIdp;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_mode == _Mode.signin) {
        if (email.isEmpty || _password.text.isEmpty) return;
        final auth = await idp.login(email: email, password: _password.text);
        await client.auth.updateSignedInUser(auth);
        client.profile.touchVisit().ignore();
      } else if (_mode == _Mode.signup) {
        if (_step == 1 && email.isNotEmpty) {
          _requestId = await idp.startRegistration(email: email);
          setState(() => _step = 2);
        } else if (_step == 2 && _code.text.trim().isNotEmpty) {
          _token = await idp.verifyRegistrationCode(
            accountRequestId: _requestId!,
            verificationCode: _code.text.trim(),
          );
          setState(() => _step = 3);
        } else if (_step == 3 &&
            _password.text.isNotEmpty &&
            _callMe.text.trim().isNotEmpty) {
          final auth = await idp.finishRegistration(
            registrationToken: _token!,
            password: _password.text,
          );
          await client.auth.updateSignedInUser(auth);
          // tell WYRD what to call them
          client.profile.setUsername(_callMe.text.trim()).ignore();
          client.profile.touchVisit().ignore();
        }
      } else {
        if (_step == 1 && email.isNotEmpty) {
          _requestId = await idp.startPasswordReset(email: email);
          setState(() => _step = 2);
        } else if (_step == 2 && _code.text.trim().isNotEmpty) {
          _token = await idp.verifyPasswordResetCode(
            passwordResetRequestId: _requestId!,
            verificationCode: _code.text.trim(),
          );
          setState(() => _step = 3);
        } else if (_step == 3 && _password.text.isNotEmpty) {
          await idp.finishPasswordReset(
            finishPasswordResetToken: _token!,
            newPassword: _password.text,
          );
          // straight in with the new password
          final auth = await idp.login(email: email, password: _password.text);
          await client.auth.updateSignedInUser(auth);
        }
      }
    } catch (e) {
      if (mounted) setState(() => _error = _friendly(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = _mode != _Mode.signin;
    final needsEmail = _mode == _Mode.signin || _step == 1;
    final needsCode = steps && _step == 2;
    final needsPassword = _mode == _Mode.signin || _step == 3;

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: WyrdColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WyrdColors.greenBorder),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5A3018).withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 5, color: WyrdColors.signal),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const FaceMark(size: 30),
                    const SizedBox(width: 10),
                    Text(
                      'WYRD',
                      style: WyrdText.display(
                        fontSize: 26,
                        color: WyrdColors.indigo,
                      ).copyWith(letterSpacing: 5),
                    ),
                    if (widget.onClose != null) ...[
                      const Spacer(),
                      GestureDetector(
                        onTap: widget.onClose,
                        child: Text(
                          '×',
                          style: WyrdText.mono(
                            fontSize: 24,
                            color: WyrdColors.greenDim,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (_mode != _Mode.reset) ...[
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: WyrdColors.sand,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        for (final m in [_Mode.signin, _Mode.signup])
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _switch(m),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _mode == m
                                      ? WyrdColors.signal
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  m == _Mode.signin
                                      ? 'SIGN IN'
                                      : 'CREATE ACCOUNT',
                                  style: WyrdText.mono(
                                    fontSize: 11,
                                    color: _mode == m
                                        ? WyrdColors.onSignal
                                        : WyrdColors.greenDim,
                                  ).copyWith(letterSpacing: 1.8),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Text(
                  _heading,
                  style: WyrdText.display(fontSize: 36).copyWith(height: 1.05),
                ),
                const SizedBox(height: 4),
                Text(
                  _blurb,
                  style: WyrdText.mono(
                    fontSize: 12.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(height: 1.5),
                ),
                if (steps) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: WyrdColors.bg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final (i, label) in const [
                          'EMAIL',
                          'CODE',
                          'PASSWORD',
                        ].indexed)
                          Row(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i + 1 <= _step
                                      ? WyrdColors.signal
                                      : WyrdColors.card,
                                  border: Border.all(
                                    color: i + 1 <= _step
                                        ? WyrdColors.signal
                                        : WyrdColors.greenBorder,
                                  ),
                                ),
                                child: Text(
                                  i + 1 < _step ? '✓' : '${i + 1}',
                                  style: WyrdText.mono(
                                    fontSize: 10,
                                    color: i + 1 <= _step
                                        ? WyrdColors.onSignal
                                        : WyrdColors.greenDim,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                label,
                                style: WyrdText.mono(
                                  fontSize: 9.5,
                                  color: i + 1 == _step
                                      ? WyrdColors.signal
                                      : WyrdColors.greenDim,
                                ).copyWith(letterSpacing: 1.5),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                if (needsEmail)
                  _field(
                    'EMAIL',
                    _email,
                    hint: 'you@example.com',
                    keyboard: TextInputType.emailAddress,
                  ),
                if (needsCode) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: WyrdColors.indigo.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Check your inbox for a 6-digit code. Not there after a minute? Look in Spam or Promotions.',
                      style: WyrdText.mono(
                        fontSize: 11.5,
                        color: WyrdColors.indigo,
                      ).copyWith(height: 1.5),
                    ),
                  ),
                  _field(
                    'CODE FROM YOUR EMAIL',
                    _code,
                    hint: '123456',
                    keyboard: TextInputType.number,
                    big: true,
                  ),
                ],
                if (_mode == _Mode.signup && _step == 3)
                  _field(
                    'WHAT SHOULD WYRD CALL YOU?',
                    _callMe,
                    hint: 'your name, or a nickname',
                  ),
                if (needsPassword)
                  _field(
                    _mode == _Mode.signin ? 'PASSWORD' : 'NEW PASSWORD',
                    _password,
                    hint: _mode == _Mode.signin
                        ? 'your password'
                        : 'at least 8 characters',
                    secret: !_showPassword,
                    right: GestureDetector(
                      onTap: () =>
                          setState(() => _showPassword = !_showPassword),
                      child: Text(
                        _showPassword ? 'HIDE' : 'SHOW',
                        style: WyrdText.mono(
                          fontSize: 10,
                          color: WyrdColors.signal,
                        ).copyWith(letterSpacing: 1.5),
                      ),
                    ),
                  ),
                if (_mode == _Mode.signin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _switch(_Mode.reset),
                      child: Text(
                        'Forgot password?',
                        style: WyrdText.mono(
                          fontSize: 12,
                          color: WyrdColors.signal,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                if (_error != null)
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: WyrdColors.danger.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: WyrdColors.danger.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Text(
                      _error!,
                      style: WyrdText.mono(
                        fontSize: 12,
                        color: WyrdColors.danger,
                      ),
                    ),
                  ),
                const SizedBox(height: 18),
                Material(
                  color: WyrdColors.signal,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: _busy ? null : _submit,
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: _busy
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: WyrdColors.onSignal,
                                ),
                              )
                            : Text(
                                _action,
                                style: WyrdText.mono(
                                  fontSize: 14,
                                  color: WyrdColors.onSignal,
                                ).copyWith(letterSpacing: 2.5),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_mode == _Mode.reset)
                  Center(
                    child: GestureDetector(
                      onTap: () => _switch(_Mode.signin),
                      child: Text(
                        '← Back to sign in',
                        style: WyrdText.mono(
                          fontSize: 12,
                          color: WyrdColors.signal,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                else
                  Text(
                    'Every account gets its own private conversation with WYRD.',
                    textAlign: TextAlign.center,
                    style: WyrdText.mono(
                      fontSize: 11,
                      color: WyrdColors.greenDim,
                    ).copyWith(height: 1.5),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController c, {
    String? hint,
    TextInputType? keyboard,
    bool secret = false,
    bool big = false,
    Widget? right,
  }) {
    OutlineInputBorder b(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: 1.5),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                label,
                style: WyrdText.mono(
                  fontSize: 10,
                  color: WyrdColors.greenDim,
                ).copyWith(letterSpacing: 2),
              ),
              const Spacer(),
              ?right,
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: c,
            obscureText: secret,
            keyboardType: keyboard,
            autocorrect: false,
            textAlign: big ? TextAlign.center : TextAlign.start,
            style: WyrdText.mono(
              fontSize: big ? 24 : 15,
            ).copyWith(letterSpacing: big ? 10 : 0),
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: WyrdText.mono(
                fontSize: big ? 24 : 15,
                color: WyrdColors.greenBorder,
              ),
              filled: true,
              fillColor: WyrdColors.bg,
              enabledBorder: b(WyrdColors.greenBorder),
              focusedBorder: b(WyrdColors.signal),
              border: b(WyrdColors.greenBorder),
            ),
          ),
        ],
      ),
    );
  }
}
