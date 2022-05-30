import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class CheckboxTileCheck extends StatelessWidget {
  final bool isChecked;
  final Function(bool?)? onChanged;

  const CheckboxTileCheck({
    Key? key,
    required this.isChecked,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        onChanged: onChanged,
        value: isChecked,
        shape: const CircleBorder(),
        activeColor: Palette.accent,
        checkColor: Palette.primary,
      ),
    );
  }
}
