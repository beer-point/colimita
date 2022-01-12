import 'package:colimita/domain/station.dart';
import 'package:colimita/pages/map/stations_carusel.dart';
import 'package:colimita/providers/stations_provider.dart';
import 'package:colimita/widgets/loading_full_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStations = ref.watch(stationsProvider);
    return asyncStations.when(
      data: (stations) => _MapPage(stations),
      loading: () => LoadingScreen(),
      error: (err, stack) {
        print(err);
        print(stack);
        return Text('Error');
      },
    );
  }
}

class _MapPage extends StatefulWidget {
  final KtList<Station> stations;

  _MapPage(this.stations);
  @override
  __MapPageState createState() => __MapPageState();
}

class __MapPageState extends State<_MapPage> with TickerProviderStateMixin {
  MapController mapController = MapController();
  Station? selectedStation;

  @override
  void initState() {
    selectedStation = null;
    super.initState();
  }

  bool _isStationSelected(Station station) {
    return station == selectedStation;
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animationController.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });

    animationController.forward();
  }

  void handleOnStationChange(Station station) {
    setState(() {
      selectedStation = station;
    });
    _animatedMapMove(station.latlng, 13.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(-34.92, -54.94),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: widget.stations
                    .asList()
                    .map(
                      (station) => Marker(
                        rotate: true,
                        width: 64,
                        height: 64,
                        point: station.latlng,
                        builder: (ctx) => IconButton(
                          icon: Icon(
                            Icons.location_on_rounded,
                            size: 64,
                            color: _isStationSelected(station)
                                ? Colors.amber[700]
                                : Colors.amber,
                          ),
                          onPressed: () {
                            if (_isStationSelected(station)) {
                              setState(() {
                                selectedStation = null;
                              });
                            } else {
                              handleOnStationChange(station);
                            }
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          if (selectedStation != null)
            StationsCarusel(
              stations: widget.stations,
              onStationChange: handleOnStationChange,
              selectedStation: selectedStation,
            ),
          SafeArea(
            child: Row(
              children: const [
                BackButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
