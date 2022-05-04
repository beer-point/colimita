import 'package:colimita/pages/auth/use_auth_controller.dart';
import 'package:colimita/providers/user_provider.dart';
import 'package:colimita/widgets/b_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = useAuthController(ref);
    final user = ref.watch(userProvider);

    void handleSignout() {
      authController.signOut();
    }

    return Scaffold(
      appBar: BAppBar(title: user?.name),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: handleSignout,
                child: const Text('Cerrar session'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
