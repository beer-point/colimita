import 'package:colimita/domain/session.dart';
import 'package:colimita/pages/sessions/order_like_border_painter.dart';
import 'package:flutter/material.dart';

class SessionHeader extends StatelessWidget {
  Session session;
  SessionHeader(this.session);
  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.amber),
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Theme(
                  data: ThemeData(
                      textTheme: const TextTheme(
                          bodyText1: TextStyle(color: Colors.white))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BackButton(
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        '\$ ${(session.ml * session.beerCostPerLt / 1000).toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 16,
          child: CustomPaint(
            painter: OrderLikeBorderPainter(
              Colors.amber,
              scaffoldBackgroundColor,
            ),
          ),
        )
      ],
    );
  }
}
