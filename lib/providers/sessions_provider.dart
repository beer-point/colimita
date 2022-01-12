import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colimita/domain/beer.dart';
import 'package:colimita/domain/brewer.dart';
import 'package:colimita/domain/session.dart';
import 'package:colimita/domain/user.dart';
import 'package:colimita/providers/user_provider.dart';
import 'package:colimita/utils/deep_merge.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';

final sessionsProvider =
    StateNotifierProvider<SessionsStateNotifier, AsyncValue<KtList<Session>>>(
  (ref) {
    var user = ref.watch(userProvider);
    return SessionsStateNotifier(user);
  },
);

class SessionsStateNotifier extends StateNotifier<AsyncValue<KtList<Session>>> {
  final User? user;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      _sessionsChangeStreamSusbscription;

  SessionsStateNotifier(this.user) : super(const AsyncLoading()) {
    if (user != null) {
      final userId = user?.id;
      final sessionsCollectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('sessions');

      _sessionsChangeStreamSusbscription =
          sessionsCollectionRef.snapshots().listen((event) async {
        final futureSessionsMap = event.docs.map(
          (sessionEvent) async {
            DocumentReference<Map<String, dynamic>> beerRef =
                sessionEvent.data()['beerRef'];
            final beerMap = (await beerRef.get()).data();
            final brewerMap = (await beerRef.parent.parent?.get())?.data();
            final brewer = Brewer.fromMap(brewerMap);
            final beer = Beer.fromMap(
              deepMerge({"brewer": brewer}, beerMap!),
            );
            return Session.fromMap(
                deepMerge(sessionEvent.data(), {"beer": beer}))!;
          },
        );
        final sessions = await Future.wait(futureSessionsMap);
        sessions.sort((a, b) => b.startedAt.compareTo(a.startedAt));
        state = AsyncData(
          KtList.from(sessions),
        );
      });
    }
  }

  @override
  void dispose() {
    _sessionsChangeStreamSusbscription?.cancel();
    super.dispose();
  }
}
