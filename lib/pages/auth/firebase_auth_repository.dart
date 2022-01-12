import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colimita/domain/failure.dart';
import 'package:colimita/domain/user.dart';
import 'package:colimita/pages/auth/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final firebaseAuthProvider = Provider<firebase_auth.FirebaseAuth>(
    (ref) => firebase_auth.FirebaseAuth.instance);

class FirebaseAuthRepository implements IAuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;

  const FirebaseAuthRepository(this.firebaseAuth);

  @override
  Stream<Either<Failure, User>?> authStateChanges() {
    final userStreamController = StreamController<Either<Failure, User>?>();

    firebaseAuth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        Either<Failure, User>? eitherUserOrFailure =
            await _getUser(firebaseUser);
        eitherUserOrFailure.fold((failure) async {
          userStreamController.add(null);
        }, (user) {
          userStreamController.add(eitherUserOrFailure);
        });
      } else {
        userStreamController.add(null);
      }
    });

    return userStreamController.stream;
  }

  @override
  Future<void> signInAnonymously() async {
    await firebaseAuth.signInAnonymously();
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> sendPasswordResetEmail(email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// IMPORTANT: Google doesn't allow authenticating via non registered urls.
  /// This means that we might get the error:
  ///  `PlatformException(idpiframe_initialization_failed, Not a valid origin for the client: http://localhost:53840`
  /// when tryin to authenticate with google in web.
  /// This is because when running flutter locally in chrome it assings a random port everytime, making the url invalid, since we don't have every port registered.
  /// a work around is to run `flutter run -d chrome --web-port 56151` or using vscode press ctl + F5 (see `.vscode/launch.json`)
  ///
  /// To register a new domian go to:
  /// Google cloud console > Api & Services > Credentials  and under Oauth2.0 Client Ids > web client
  ///
  @override
  Future<firebase_auth.UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }

  /// This method doesn't work on ios simulator
  /// https://stackoverflow.com/questions/64178940/flutter-sign-in-with-apple-not-working-on-ios-simulator-infinite-loader
  @override
  Future<firebase_auth.UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = firebase_auth.OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return await firebaseAuth.signInWithCredential(oauthCredential);
  }

  @override
  Future<void> signInWithFacebook() {
    throw UnimplementedError();
  }

  Future<Either<Failure, User>> _getUser(
      firebase_auth.User firebaseUser) async {
    var userDoc =
        FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
    try {
      var userSnapshot =
          await userDoc.snapshots().timeout(const Duration(seconds: 15)).first;
      final userData = userSnapshot.data();
      print(userData);
      final user = User.fromMap(
        firebaseUser.uid,
        userData,
      );
      if (user != null) {
        return Right(user);
      }
    } catch (e) {
      print(e);
    }
    return Left(Failure.unexpected());
  }
}

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
