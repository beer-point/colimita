import 'package:colimita/pages/auth/auth_provider.dart';
import 'package:colimita/pages/auth/use_auth_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void useReplaceRouteOnAuthChange(
  BuildContext context,
  WidgetRef ref,
  AuthStates state,
  String route,
) {
  final authState = useAuthState(ref);
  useEffect(() {
    if (authState.hasCheckAuthentication) {
      /// Delay the Navigator push since this might trigger before the build
      /// method finish running.
      Future.delayed(Duration.zero, () {
        if (authState.state == state) {
          Navigator.pushReplacementNamed(context, route);
        }
      });
    }
  }, [authState]);
}
