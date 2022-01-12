import 'package:colimita/pages/auth/use_auth_controller.dart';
import 'package:colimita/providers/user_provider.dart';
import 'package:colimita/widgets/app_typography.dart';
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: const [BackButton()],
                ),
                Center(
                  child: AppTypography.title('${user?.name}'),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: handleSignout,
                child: Text('Cerrar session'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
