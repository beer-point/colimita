import 'package:colimita/pages/auth/auth_provider.dart';
import 'package:colimita/pages/auth/login/social_sign_in_button.dart';
import 'package:colimita/pages/auth/use_auth_controller.dart';
import 'package:colimita/pages/auth/use_auth_state.dart';
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
    final authState = useAuthState(ref);
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

    void signInWithFacebook() {
      authController.signInWithFacebook();
    }

    void signInAnonymously() {
      authController.signInAnonymously();
    }

    // final localizedStrings = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: screenWidth / 2,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              TextField(
                controller: usernameInputController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: passwordInputController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: onLogin,
                  child: AppTypography.body(
                    // localizedStrings.loginScreenLoginButton,
                    'Ingresar',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: goToSignup,
                  child: AppTypography.body(
                    // localizedStrings.loginScreenLoginButton,
                    'Registrarse',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: goToForgotPassord,
                  child: AppTypography.body(
                    // localizedStrings.loginScreenLoginButton,
                    'Me olvide la contraseña',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SocialSignInButton(
                onPress: signInAnonymously,
                socialProvider: SocialAuthProvider.anonymously,
              ),
              SocialSignInButton(
                onPress: signInWithGoogle,
                socialProvider: SocialAuthProvider.google,
              ),
              SocialSignInButton(
                onPress: signInWithApple,
                socialProvider: SocialAuthProvider.apple,
              ),
              SocialSignInButton(
                onPress: signInWithFacebook,
                socialProvider: SocialAuthProvider.facebook,
              ),
              if (authState.user != null)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: AppTypography.body(
                    // localizedStrings.loginScreenLoginButton,
                    'Hola ${authState.user.toString()}',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
