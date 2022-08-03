import 'package:fitness_app/config/fonts.dart';
import 'package:flutter/material.dart';

class CycleCounter extends StatelessWidget {
  final int current;
  final int max;

  const CycleCounter({
    Key? key,
    required this.current,
    required this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Cycle ${current + 1} / $max",
      style: const TextStyle(
        fontFamily: Fonts.primaryRegular,
        fontSize: 18.0,
      ),
    );
  }
}
