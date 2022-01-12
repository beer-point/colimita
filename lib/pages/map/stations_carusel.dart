import 'package:carousel_slider/carousel_slider.dart';
import 'package:colimita/domain/station.dart';
import 'package:colimita/pages/map/station_carusel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';

class StationsCarusel extends HookConsumerWidget {
  KtList<Station> stations;
  void Function(Station) onStationChange;
  Station? selectedStation;

  StationsCarusel({
    required this.stations,
    required this.onStationChange,
    required this.selectedStation,
  });

  Widget build(BuildContext context, WidgetRef ref) {
    final carouselController = useRef(CarouselController());

    useEffect(() {
      if (selectedStation != null) {
        carouselController.value
            .animateToPage(_findStationIndex(selectedStation!));
      }
    }, [selectedStation]);

    void handleStationChange(int index, CarouselPageChangedReason reason) {
      onStationChange(stations[index]);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: handleStationChange,
            aspectRatio: 1,
            initialPage: _findStationIndex(selectedStation!),
            enableInfiniteScroll: false,
          ),
          carouselController: carouselController.value,
          items:
              stations.map((station) => StationCaruselItem(station)).asList(),
        )
      ],
    );
  }

  int _findStationIndex(Station station) {
    for (var i = 0; i < stations.size; i++) {
      if (station == stations[i]) return i;
    }
    return 0;
  }
}
