import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final void Function()? onPressed;

  const FormButton({
    Key? key,
    required this.text,
    this.textColor = Palette.primary,
    this.backgroundColor = Palette.accent,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: Palette.accent,
              width: 2.0,
            ),
          ),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: Fonts.secondaryRegular,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
