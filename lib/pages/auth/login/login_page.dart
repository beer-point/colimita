import 'package:colimita/pages/auth/auth_provider.dart';
import 'package:colimita/pages/auth/login/social_sign_in_button.dart';
import 'package:colimita/pages/auth/use_auth_controller.dart';
import 'package:colimita/shared/use_replace_route_on_auth_change.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameInputController = useTextEditingController(text: '');
    final passwordInputController = useTextEditingController(text: '');
    final authController = useAuthController(ref);
    useReplaceRouteOnAuthChange(
      context,
      ref,
      AuthStates.authenticated,
      '/home',
    );

    void onLogin() {
      authController.signInWithUsernameAndPassword(
          usernameInputController.text, passwordInputController.text);
    }

    void goToSignup() {
      Navigator.pushNamed(context, '/signup');
    }

    void goToForgotPassord() {
      Navigator.pushNamed(context, '/forgot-password');
    }

    void signInWithGoogle() async {
      authController.signInWithGoogle();
    }

    void signInWithApple() {
      authController.signInWithApple();
    }

    // final localizedStrings = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      TextField(
                        controller: usernameInputController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: passwordInputController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: onLogin,
                  child: Text(
                    'Ingresar',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: goToSignup,
                  child: Text(
                    'Registrarse',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: goToForgotPassord,
                  child: AppTypography.body(
                    // localizedStrings.loginScreenLoginButton,
                    'Me olvide la contraseña',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const Divider(),
              SocialSignInButton(
                onPress: signInWithGoogle,
                socialProvider: SocialAuthProvider.google,
              ),
              SocialSignInButton(
                onPress: signInWithApple,
                socialProvider: SocialAuthProvider.apple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
