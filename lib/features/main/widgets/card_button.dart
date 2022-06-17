import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final Function()? onPressed;

  const CardButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Icon(
        Icons.arrow_forward,
        color: Palette.accent,
        size: 30.0,
      ),
    );
  }
}
