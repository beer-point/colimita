import 'package:colimita/pages/auth/use_auth_controller.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailInputController = useTextEditingController(text: '');
    final passwordInputController = useTextEditingController(text: '');
    final authController = useAuthController(ref);

    Future<void> handleSignup() async {
      await authController.createUserWithEmailAndPassword(
          emailInputController.text, passwordInputController.text);
    }

    // final localizedStrings = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: screenWidth / 2,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              TextField(
                controller: emailInputController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: passwordInputController,
                decoration: const InputDecoration(
                  labelText: 'Contrasena',
                ),
              ),
              ElevatedButton(
                onPressed: handleSignup,
                child: AppTypography.body(
                  'Crear usuario',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
