import 'dart:async';

import 'package:colimita/domain/user.dart';
import 'package:colimita/domain/failure.dart';
import 'package:colimita/pages/auth/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepository implements IAuthRepository {
  final StreamController<Either<Failure, User>?> _streamController =
      StreamController<Either<Failure, User>?>();

  AuthRepository() : super() {
    Future.delayed(const Duration(seconds: 5), () {
      var user = generateEitherUser();
      _streamController.add(user);
    });
  }

  @override
  Stream<Either<Failure, User>?> authStateChanges() {
    return _streamController.stream;
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signInAnonymously() {
    // TODO: implement signInAnonymously
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    _streamController.add(null);
  }
}

Either<Failure, User> generateEitherUser() {
  var user = User(
    id: "id",
    fullName: "fullName",
  );
  return Right(user);
}
