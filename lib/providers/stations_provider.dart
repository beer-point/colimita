import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colimita/domain/beer.dart';
import 'package:colimita/domain/brewer.dart';
import 'package:colimita/domain/station.dart';
import 'package:colimita/utils/deep_merge.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';

final stationsProvider =
    StateNotifierProvider<StationsStateNotifier, AsyncValue<KtList<Station>>>(
  (ref) {
    return StationsStateNotifier();
  },
);

class StationsStateNotifier extends StateNotifier<AsyncValue<KtList<Station>>> {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      _stationsChangeStreamSusbscription;

  StationsStateNotifier() : super(const AsyncLoading()) {
    final stationsCollectionRef =
        FirebaseFirestore.instance.collection('stations');

    _stationsChangeStreamSusbscription =
        stationsCollectionRef.snapshots().listen((event) async {
      final futureStationsMap = event.docs.map(
        (stationEvent) async {
          DocumentReference<Map<String, dynamic>> beerRef =
              stationEvent.data()['beerRef'];
          final beerMap = (await beerRef.get()).data();
          final brewerMap = (await beerRef.parent.parent?.get())?.data();
          final brewer = Brewer.fromMap(brewerMap);
          print(beerMap);
          final beer = Beer.fromMap(
            deepMerge({"brewer": brewer}, beerMap!),
          );
          return Station.fromMap(
              deepMerge(stationEvent.data(), {"beer": beer}))!;
        },
      );
      final stations = await Future.wait(futureStationsMap);
      state = AsyncData(
        KtList.from(stations),
      );
    });
  }

  @override
  void dispose() {
    _stationsChangeStreamSusbscription?.cancel();
    super.dispose();
  }
}
