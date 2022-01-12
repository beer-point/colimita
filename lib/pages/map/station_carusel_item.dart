import 'package:colimita/domain/beer.dart';
import 'package:colimita/domain/station.dart';
import 'package:colimita/domain/store.dart';
import 'package:flutter/material.dart';

class StationCaruselItem extends StatelessWidget {
  Station station;
  StationCaruselItem(this.station);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            if (station.managedBy != null) _StoreDetailsRow(station.managedBy!),
            _BeerDetailsRow(station.beer),
          ],
        ),
      ),
    );
  }
}

class _BeerDetailsRow extends StatelessWidget {
  Beer beer;

  _BeerDetailsRow(this.beer);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, '/beer', arguments: beer);
      },
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(beer.photoUrl,
                    headers: {'Cache-Control': 'max-age=200'}),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(beer.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  beer.brewer.name,
                ),
              ],
            ),
          ),
          Row(
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                '\$${beer.costPerLt.toString()}',
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 2.0),
                child: Text('/ lt'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _StoreDetailsRow extends StatelessWidget {
  Store store;

  _StoreDetailsRow(this.store);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(store.photoUrl,
                  headers: {'Cache-Control': 'max-age=200'}),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          store.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
