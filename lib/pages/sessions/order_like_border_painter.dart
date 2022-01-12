import 'package:flutter/material.dart';

class OrderLikeBorderPainter extends CustomPainter {
  final numOfTeeths = 12;
  final Color primaryColor;
  final Color secondaryColor;

  OrderLikeBorderPainter(this.primaryColor, this.secondaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final teethWidth = size.width / numOfTeeths;
    final primaryPaint = Paint()..color = primaryColor;
    final secondaryPaint = Paint()..color = secondaryColor;
    canvas.drawRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width, size.height),
        ),
        secondaryPaint);

    var path = Path()..moveTo(0, 0);
    // ..lineTo(size.width / 2, size.height)
    // ..lineTo(size.width, 0);
    for (var i = 0; i <= numOfTeeths; i++) {
      path.lineTo(i * teethWidth, 0);
      path.lineTo(i * teethWidth + teethWidth / 2, size.height);
    }
    path.lineTo(size.width, 0);
    canvas.drawPath(path, primaryPaint);
  }

  @override
  bool shouldRepaint(covariant OrderLikeBorderPainter oldDelegate) {
    return primaryColor != oldDelegate.primaryColor ||
        secondaryColor != oldDelegate.secondaryColor;
  }
}
