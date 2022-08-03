import 'dart:math';

import 'package:fitness_app/config/colors.dart';
import 'package:fitness_app/features/stopwatch/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StopwatchIndicator extends StatelessWidget {
  final double radius;
  final double width;
  late final double _smallRadius;
  final Color color;

  final Function()? onTap;
  final Widget? child;

  StopwatchIndicator({
    Key? key,
    this.radius = 130,
    this.width = 18,
    this.color = Palette.tint3,
    this.onTap,
    this.child,
  }) : super(key: key) {
    _smallRadius = radius - width;
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<StopwatchProvider>();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        Container(
          width: _smallRadius * 2,
          height: _smallRadius * 2,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(_smallRadius),
          ),
          child: ClipOval(
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: child,
            ),
          ),
        ),
        CustomPaint(
          painter: ChronoPainter(
            radius: radius,
            width: width,
            f: provider.f,
            t: provider.isTimeCapSet
                ? provider.elapsedInSeconds
                : (provider.elapsedInSeconds % 60),
          ),
        ),
      ],
    );
  }
}

class ChronoPainter extends CustomPainter {
  final Paint _painter = Paint();
  final double radius;
  final double width;
  final double f;
  late final double t;

  ChronoPainter({
    color = Palette.accent,
    required this.radius,
    required this.width,
    required this.f,
    required double t,
  }) {
    this.t = t == 0 ? 0.001 : t;
    _painter.color = color;
    _painter.strokeWidth = width;
    _painter.strokeCap = StrokeCap.round;
    _painter.style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCenter(
          center: center,
          width: (radius - width / 2) * 2,
          height: (radius - width / 2) * 2),
      -pi / 2,
      2 * pi * f * t,
      false,
      _painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    (oldDelegate as ChronoPainter);
    return oldDelegate.t != t;
  }
}
