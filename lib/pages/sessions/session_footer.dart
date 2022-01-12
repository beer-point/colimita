import 'package:colimita/pages/sessions/order_like_border_painter.dart';
import 'package:flutter/material.dart';

class SessionFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 16,
          child: CustomPaint(
            painter:
                OrderLikeBorderPainter(scaffoldBackgroundColor, Colors.amber),
          ),
        ),
        Container(
          width: double.infinity,
          height: 32,
          decoration: const BoxDecoration(color: Colors.amber),
        ),
      ],
    );
  }
}
