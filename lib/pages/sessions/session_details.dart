import 'package:colimita/domain/session.dart';
import 'package:colimita/utils/datetime.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';

class SessionDetails extends StatelessWidget {
  Session session;

  SessionDetails(this.session);
  @override
  Widget build(BuildContext context) {
    void handleBeerPressed() {
      Navigator.pushNamed(context, '/beer', arguments: session.beer);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(
            child: AppTypography.subtitle(
              'Detalle',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _ListViewItem(
            label: 'Fecha',
            value: formatDateTime(session.startedAt),
          ),
          _ListViewItem(
            label: 'Cerveza',
            onPressed: handleBeerPressed,
            value: session.beer.name,
          ),
          _ListViewItem(
            label: 'Servido',
            value: '${session.ml.toString()} ml',
          ),
          _ListViewItem(
              label: 'Costo',
              value: '\$ ${session.beerCostPerLt.toString()} / lt'),
        ],
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  String label;
  String value;
  void Function()? onPressed;

  _ListViewItem({required this.label, required this.value, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTypography.body(label),
                AppTypography.body(value,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
