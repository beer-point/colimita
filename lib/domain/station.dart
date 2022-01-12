import 'package:colimita/domain/beer.dart';
import 'package:colimita/domain/store.dart';
import 'package:latlong2/latlong.dart';

class Station {
  final LatLng latlng;
  final Beer beer;
  final Store? managedBy;

  Station({
    required this.latlng,
    required this.beer,
    this.managedBy,
  });

  static Station? fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      final geopoint = map['latlng'];
      final latlng = LatLng(geopoint.latitude, geopoint.longitude);

      return Station(
          latlng: latlng,
          beer: map['beer'],
          managedBy: Store.fromMap(map['managedBy']));
    }
  }
}
