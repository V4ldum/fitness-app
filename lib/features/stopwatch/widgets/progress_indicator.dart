import 'dart:math';

import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final bool isFilled;

  const ProgressIndicator({
    Key? key,
    this.isFilled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: CustomPaint(
        painter: IndicatorPainter(isFilled: isFilled),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final Paint _painter = Paint();
  final bool isFilled;

  IndicatorPainter({
    required this.isFilled,
  }) {
    _painter.color = Palette.accent;
    _painter.strokeWidth = 1.5;
    _painter.style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.rotate(pi / 15);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 7, height: 25),
        const Radius.circular(5),
      ),
      _painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    (oldDelegate as IndicatorPainter);
    return oldDelegate.isFilled != isFilled;
  }
}
