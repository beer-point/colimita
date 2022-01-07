import 'dart:async';

import 'package:colimita/domain/failure.dart';
import 'package:colimita/domain/user.dart';
import 'package:colimita/pages/auth/firebase_auth_repository.dart';
import 'package:colimita/pages/auth/i_auth_repository.dart';
import 'package:colimita/providers/auth_repository_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Represents the different states in which the auth is.
/// When the app first load we show the splash screen, and since
/// we don't have any information about the previous authentication sessions
/// the auth state is `unknown`.
///
/// We then check this state and change it accordingly to `authenticated` or `unauthenticated`
enum AuthStates {
  unknown,
  error,
  authenticating,
  authenticated,
  unauthenticated,
}

class AuthState {
  User? user;
  AuthStates state;
  AuthState({required this.user, this.state = AuthStates.unknown});

  bool get hasCheckAuthentication => state != AuthStates.unknown;
  bool get isAuthenticated => state == AuthStates.authenticated;
}

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) {
    var authRepository = ref.read(authRepositoryProvider);
    return AuthStateNotifier(authRepository);
  },
);

class AuthStateNotifier extends StateNotifier<AuthState> {
  final IAuthRepository authRepository;

  StreamSubscription<Either<Failure, User>?>? _authStateChangesSubscription;

  AuthStateNotifier(this.authRepository) : super(AuthState(user: null)) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        authRepository.authStateChanges().listen((eitherUser) async {
      if (eitherUser != null) {
        eitherUser.fold((l) {
          state = AuthState(user: null, state: AuthStates.error);
        }, (user) {
          state = AuthState(user: user, state: AuthStates.authenticated);
        });
      } else {
        // unauthenticate.
        state = AuthState(user: null, state: AuthStates.unauthenticated);
      }
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }
}
