import 'package:colimita/domain/failure.dart';
import 'package:colimita/domain/user.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Stream<Either<Failure, User>?> authStateChanges();
  Future<void> signInAnonymously();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithFacebook();
}
