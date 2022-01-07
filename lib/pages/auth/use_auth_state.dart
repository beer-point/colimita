import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_provider.dart';

AuthState useAuthState(WidgetRef ref) {
  return ref.watch(authProvider);
}
