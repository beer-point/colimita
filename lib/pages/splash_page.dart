import 'package:colimita/pages/auth/use_auth_state.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useRedirectToInitialRoute(context, ref);
    return Scaffold(
        body: Center(child: AppTypography.title('splash screen :D')));
  }
}

void useRedirectToInitialRoute(BuildContext context, WidgetRef ref) {
  final authState = useAuthState(ref);
  useEffect(() {
    if (authState.hasCheckAuthentication) {
      /// Delay the Navigator push since this might trigger before the build
      /// method finish running.
      Future.delayed(Duration.zero, () {
        if (authState.user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }
  }, [authState]);
}
