import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class FinishedIndicator extends StatelessWidget {
  final double radius;
  final double width;
  late final double _smallRadius;

  FinishedIndicator({
    Key? key,
    this.radius = 130,
    this.width = 18,
  }) : super(key: key) {
    _smallRadius = radius - width;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: Palette.accent,
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
          child: const ClipOval(
            child: Center(
              child: Text(
                Strings.finishedWorkoutLabel,
                style: TextStyle(
                  fontFamily: Fonts.primaryRegular,
                  color: Palette.accent,
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
