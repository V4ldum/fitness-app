import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final IconData? icon;

  const IconTextButton({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Palette.accent,
        ),
        label: Text(
          text,
          style: const TextStyle(
            color: Palette.accent,
            fontSize: 15.0,
            fontFamily: Fonts.primaryRegular,
          ),
        ),
      );
    }
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Palette.accent,
          fontSize: 15.0,
          fontFamily: Fonts.primaryRegular,
        ),
      ),
    );
  }
}
