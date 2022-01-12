import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colimita/domain/beer.dart';

class Session {
  final int beerCostPerLt;
  final int ml;
  final Beer beer;
  final DateTime startedAt;
  final DateTime endedAt;
  final DocumentReference stationRef;
  final DocumentReference? transactionRef;

  Session({
    required this.beerCostPerLt,
    required this.ml,
    required this.beer,
    required this.startedAt,
    required this.endedAt,
    required this.stationRef,
    this.transactionRef,
  });

  static Session? fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      return Session(
        beerCostPerLt: (map['beerCostPerLt'] as num).toInt(),
        ml: (map['ml'] as num).toInt(),
        beer: map['beer'],
        startedAt: map['startedAt'].toDate(),
        endedAt: map['endedAt'].toDate(),
        stationRef: map['stationRef'],
        transactionRef: map['transactionRef'],
      );
    }
  }
}
