import 'package:colimita/pages/auth/auth_repository.dart';
import 'package:colimita/pages/auth/i_auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // var instance = ref.read(firebaseAuthProvider);
  // var userRepo = ref.read(userRepositoryProvider);
  return AuthRepository();
});
