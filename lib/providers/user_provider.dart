import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colimita/domain/user.dart';
import 'package:colimita/pages/auth/auth_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, User?>(
  (ref) {
    var authState = ref.watch(authProvider);
    return UserStateNotifier(authState);
  },
);

class UserStateNotifier extends StateNotifier<User?> {
  final AuthState authState;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _userChangeSubscription;

  UserStateNotifier(this.authState) : super(authState.user) {
    if (authState.user != null) {
      final userId = authState.user!.id;
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      _userChangeSubscription = userDoc.snapshots().listen((event) {
        final userData = event.data();
        state = User.fromMap(event.id, userData);
      });
    } else {
      state = null;
    }
  }

  @override
  void dispose() {
    _userChangeSubscription?.cancel();
    super.dispose();
  }
}
