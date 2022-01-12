import 'dart:math';

import 'package:flutter/material.dart';

class FilledInBeerCustomPainter extends CustomPainter {
  // between 0 and 1.
  num filledPercent;

  FilledInBeerCustomPainter(this.filledPercent);

  @override
  void paint(Canvas canvas, Size size) {
    final percent = 1 - filledPercent;
    final beerPaint = Paint()..color = Colors.amber;

    final startAtHeight = (size.height * percent) - 12;
    canvas.drawRect(
        Rect.fromPoints(
          Offset(0, startAtHeight),
          Offset(size.width, size.height),
        ),
        beerPaint);

    _drawBubbles(canvas, size, startAtHeight);
    _drawFoam(canvas, size, startAtHeight);
  }

  @override
  bool shouldRepaint(covariant FilledInBeerCustomPainter oldDelegate) {
    return filledPercent != oldDelegate.filledPercent;
  }

  void _drawBubbles(Canvas canvas, Size size, double atHeight) {
    final random = Random();
    const bubbleCount = 30;
    final ligtherPaint = Paint()..color = Colors.white54;
    final darkerPaint = Paint()..color = const Color.fromRGBO(212, 160, 6, 1);

    for (var i = 0; i < bubbleCount; i++) {
      final paint = random.nextBool() ? darkerPaint : ligtherPaint;
      final radius = random.nextInt(3) + 1;
      final xPos = 4 + random.nextInt(size.width.toInt() - 4);
      final yPos = atHeight + random.nextInt((size.height - atHeight).toInt());
      canvas.drawCircle(
        Offset(xPos.toDouble(), yPos.toDouble()),
        radius.toDouble(),
        paint,
      );
    }
  }

  void _drawFoam(Canvas canvas, Size size, double atHeight) {
    final foamBasePaint = Paint()
      ..color = Colors.white; // Color.fromRGBO(245, 245, 245, 1);
    final shadowFoamBasePaint = Paint()
      ..color = const Color.fromRGBO(255, 226, 184, 1);
    const foamHeight = 20;
    final random = Random();
    final numOfFoamHalfMoons = random.nextInt(4) + 2;
    const numOfFoamCircles = 30;

    // Draw foam base end circles
    final baseCircleRadius = size.width / numOfFoamCircles;
    double xPos = 0;

    // Foam shadow
    xPos = 0;
    while (xPos < size.width) {
      final radius = random.nextInt(6) + baseCircleRadius;
      final yPos = random.nextInt((foamHeight / 2).round()) + atHeight + 10;
      canvas.drawCircle(Offset(xPos, yPos), radius, shadowFoamBasePaint);
      xPos += radius - random.nextInt(6);
    }

    // Foam
    xPos = 0;
    while (xPos < size.width) {
      final radius = random.nextInt(6) + baseCircleRadius;
      final yPos = random.nextInt((foamHeight / 2).round()) + atHeight;
      canvas.drawCircle(Offset(xPos, yPos), radius, foamBasePaint);
      xPos += radius - random.nextInt(6);
    }

    for (var i = 0; i < numOfFoamHalfMoons; i++) {
      final radius = random.nextInt(6) + 4.0;
      final xPos = random.nextInt(size.width.toInt());
      final yPos = atHeight + random.nextInt((foamHeight).round());
      canvas.drawCircle(
          Offset(xPos.toDouble(), yPos), radius, shadowFoamBasePaint);
      canvas.drawCircle(
          Offset(xPos.toDouble(), yPos - 3), radius, foamBasePaint);
    }
  }
}
