import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class PreLoadingPainter extends CustomPainter {
  PreLoadingPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = (size.width * 8) / 60
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width / 4) * 1.7;
    const int numSegments = 8;

    // Define el índice de las manecillas que se encienden, empezando con 7 y luego 0
    int firstSegmentIndex = 6;
    int secondSegmentIndex = 7;

    // Control de opacidad en función del valor de `progress`
    double firstSegmentOpacity = progress <= 0.5 ? progress * 2 : 1.0;
    double secondSegmentOpacity = progress > 0.5 ? (progress - 0.5) * 2 : 0.0;

    // Dibujar la primera manecilla con opacidad gradual
    paint.color = color.withOpacity(firstSegmentOpacity.clamp(0, 1.0));
    final angle1 = (2 * pi / numSegments) * firstSegmentIndex;
    final startOffset1 = Offset(
      center.dx + radius * cos(angle1) * 0.55,
      center.dy + radius * sin(angle1) * 0.55,
    );
    final endOffset1 = Offset(
      center.dx + radius * cos(angle1),
      center.dy + radius * sin(angle1),
    );
    canvas.drawLine(startOffset1, endOffset1, paint);

    // Dibujar la segunda manecilla con opacidad gradual
    paint.color = color.withOpacity(secondSegmentOpacity.clamp(0, 1.0));
    final angle2 = (2 * pi / numSegments) * secondSegmentIndex;
    final startOffset2 = Offset(
      center.dx + radius * cos(angle2) * 0.55,
      center.dy + radius * sin(angle2) * 0.55,
    );
    final endOffset2 = Offset(
      center.dx + radius * cos(angle2),
      center.dy + radius * sin(angle2),
    );
    canvas.drawLine(startOffset2, endOffset2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
