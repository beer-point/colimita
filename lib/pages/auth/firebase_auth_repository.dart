// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';

// import 'package:app/shared/user/infrastructure/user_repository_provider.dart';
// import 'package:app/shared/user/domain/i_user_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:colimita/domain/failure.dart';
// import 'package:colimita/domain/user.dart';
// import 'package:colimita/pages/auth/i_auth_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:google_sign_in/google_sign_in.dart';

// import 'package:crypto/crypto.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// final firebaseAuthProvider = Provider<firebase_auth.FirebaseAuth>(
//     (ref) => firebase_auth.FirebaseAuth.instance);

// final authRepositoryProvider = Provider<IAuthRepository>((ref) {
//   var instance = ref.read(firebaseAuthProvider);
//   var userRepo = ref.read(userRepositoryProvider);
//   return FirebaseAuthRepository(instance, userRepo);
// });

// class FirebaseAuthRepository implements IAuthRepository {
//   final firebase_auth.FirebaseAuth firebaseAuth;
//   final IUserRepository userRepository;

//   const FirebaseAuthRepository(this.firebaseAuth, this.userRepository);

//   @override
//   Stream<Either<Failure, User>?> authStateChanges() {
//     final userStreamController = StreamController<Either<Failure, User>?>();

//     firebaseAuth.authStateChanges().listen((firebaseUser) async {
//       if (firebaseUser != null) {
//         Either<Failure, User>? eitherUserOrFailure =
//             await userRepository.getUserByExternalId(firebaseUser.uid);
//         eitherUserOrFailure.fold((failure) async {
//           eitherUserOrFailure = await _createUser(firebaseUser);
//           userStreamController.add(eitherUserOrFailure);
//         }, (user) {
//           userStreamController.add(eitherUserOrFailure);
//         });
//       } else {
//         userStreamController.add(null);
//       }
//     });

//     return userStreamController.stream;
//   }

//   @override
//   Future<void> signInAnonymously() async {
//     await firebaseAuth.signInAnonymously();
//   }

//   @override
//   Future<void> signOut() async {
//     await firebaseAuth.signOut();
//   }

//   @override
//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     await firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//   }

//   @override
//   Future<void> createUserWithEmailAndPassword(
//       String email, String password) async {
//     await firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//   }

//   @override
//   Future<void> sendPasswordResetEmail(email) async {
//     await firebaseAuth.sendPasswordResetEmail(email: email);
//   }

//   /// IMPORTANT: Google doesn't allow authenticating via non registered urls.
//   /// This means that we might get the error:
//   ///  `PlatformException(idpiframe_initialization_failed, Not a valid origin for the client: http://localhost:53840`
//   /// when tryin to authenticate with google in web.
//   /// This is because when running flutter locally in chrome it assings a random port everytime, making the url invalid, since we don't have every port registered.
//   /// a work around is to run `flutter run -d chrome --web-port 56151` or using vscode press ctl + F5 (see `.vscode/launch.json`)
//   ///
//   /// To register a new domian go to:
//   /// Google cloud console > Api & Services > Credentials  and under Oauth2.0 Client Ids > web client
//   ///
//   @override
//   Future<firebase_auth.UserCredential> signInWithGoogle() async {
//     final googleUser = await GoogleSignIn().signIn();
//     final googleAuth = await googleUser?.authentication;
//     final credential = firebase_auth.GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     return await firebaseAuth.signInWithCredential(credential);
//   }

//   /// This method doesn't work on ios simulator
//   /// https://stackoverflow.com/questions/64178940/flutter-sign-in-with-apple-not-working-on-ios-simulator-infinite-loader
//   @override
//   Future<firebase_auth.UserCredential> signInWithApple() async {
//     // To prevent replay attacks with the credential returned from Apple, we
//     // include a nonce in the credential request. When signing in with
//     // Firebase, the nonce in the id token returned by Apple, is expected to
//     // match the sha256 hash of `rawNonce`.
//     final rawNonce = generateNonce();
//     final nonce = sha256ofString(rawNonce);
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//       nonce: nonce,
//     );

//     // Create an `OAuthCredential` from the credential returned by Apple.
//     final oauthCredential = firebase_auth.OAuthProvider('apple.com').credential(
//       idToken: appleCredential.identityToken,
//       rawNonce: rawNonce,
//     );
//     return await firebaseAuth.signInWithCredential(oauthCredential);
//   }

//   @override
//   Future<void> signInWithFacebook() {
//     throw UnimplementedError();
//   }

//   /// Creates a either `EntityFailure` or `User`.
//   ///
//   /// Abstracts the complex logic of subscribing
//   /// to Firestore `metadata/user.uid` and converts a stream into a Future
//   /// since we expect this to run just once.
//   Future<Either<Failure, User>?> _createUser(firebase_auth.User user) async {
//     var eitherUserStreamController = StreamController<Either<Failure, User>?>();

//     CollectionReference metadata =
//         FirebaseFirestore.instance.collection('metadata');

//     var firebaseUserMetadataDoc = metadata.doc(user.uid);
//     var snapshotStream = firebaseUserMetadataDoc.snapshots();
//     StreamSubscription<dynamic>? snapshotStreamSubscription;
//     snapshotStreamSubscription = snapshotStream.listen((event) {
//       user.getIdTokenResult(true).then((result) async {
//         Either<Failure, User>? eitherUser;
//         // TODO(lg): check calims in token before trying to create user.
//         eitherUser = await userRepository.createUser(
//           fullName: user.displayName ?? '',
//           externalId: user.uid,
//           email: user.email ?? '',
//         );
//         eitherUserStreamController.add(eitherUser);
//         snapshotStreamSubscription?.cancel();
//       });
//     });

//     var eitherUser = await eitherUserStreamController.stream.first;
//     eitherUserStreamController.close();
//     return eitherUser;
//   }
// }

// /// Generates a cryptographically secure random nonce, to be included in a
// /// credential request.
// String generateNonce([int length = 32]) {
//   const charset =
//       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//   final random = Random.secure();
//   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//       .join();
// }

// /// Returns the sha256 hash of [input] in hex notation.
// String sha256ofString(String input) {
//   final bytes = utf8.encode(input);
//   final digest = sha256.convert(bytes);
//   return digest.toString();
// }
