import 'package:colimita/providers/auth_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_controller.dart';

AuthController useAuthController(WidgetRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final authController = AuthController(authRepository);
  return authController;
}
