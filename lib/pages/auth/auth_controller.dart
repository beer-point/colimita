import 'dart:async';

import 'package:colimita/pages/auth/i_auth_repository.dart';

class AuthController {
  final IAuthRepository authRepository;

  AuthController(this.authRepository);

  void signInWithUsernameAndPassword(String email, String password) async {
    await authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    await authRepository.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await authRepository.sendPasswordResetEmail(email);
  }

  Future<void> signInAnonymously() {
    return authRepository.signInAnonymously();
  }

  Future<void> signInWithGoogle() {
    return authRepository.signInWithGoogle();
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    return authRepository.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signInWithApple() {
    return authRepository.signInWithApple();
  }

  Future<void> signInWithFacebook() {
    throw UnimplementedError();
  }
}
