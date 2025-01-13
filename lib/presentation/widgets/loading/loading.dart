import 'dart:math';

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader(
      {super.key, required this.size, this.effectProgress = true, required this.color});
  final double size;
  final bool effectProgress;
  final Color color;

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Configura el controlador para la animación
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Repetir la animación para que el símbolo de carga gire continuamente
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LoadingPainter(
              progress: _controller.value,
              effectLoad: widget.effectProgress,
              color: widget.color),
          child: SizedBox(
            width: widget.size,
          ),
        );
      },
    );
  }
}

class LoadingPainter extends CustomPainter {
  LoadingPainter(
      {required this.progress, this.effectLoad = true, required this.color});
  final Color color;
  final double progress;
  final bool effectLoad;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = (size.width * 8) / 60
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 4, size.height / 4);
    final double radius = (size.width / 4) * 1.7;
    const int numSegments = 8;

    int highlightedIndex = (progress * numSegments).floor() % numSegments;

    for (int i = 0; i < numSegments; i++) {
      int distanceFromHighlight =
          (i - highlightedIndex + numSegments) % numSegments;
      double opacity = ((distanceFromHighlight / numSegments)).clamp(0.1, 1.0);
      if (effectLoad) {
        paint.color = color.withOpacity(opacity);
      } else {
        paint.color = color;
      }

      final angle = (2 * pi / numSegments) * i;
      final startOffset = Offset(
        center.dx * 2 + radius * cos(angle) * 0.55,
        center.dy * 2 + radius * sin(angle) * 0.55,
      );
      final endOffset = Offset(
        center.dx * 2 + radius * cos(angle),
        center.dy * 2 + radius * sin(angle),
      );

      canvas.drawLine(startOffset, endOffset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
