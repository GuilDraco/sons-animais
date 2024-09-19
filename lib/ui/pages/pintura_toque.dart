import 'package:flutter/material.dart';

class PinturaToque extends CustomPainter {
  final List<MapEntry<Offset?, Paint>> points;

  PinturaToque(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].key != null && points[i + 1].key != null) {
        // Desenha uma linha entre os pontos usando a tinta (Paint)
        canvas.drawLine(
          points[i].key!,
          points[i + 1].key!,
          points[i].value,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
