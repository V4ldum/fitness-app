import 'package:flutter/material.dart';
import 'package:fitness_app/constants.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final void Function()? onPressedCallback;

  const LoginButton({
    Key? key,
    this.text = "",
    this.textColor = kPrimaryDarkColor,
    this.backgroundColor = kPrimaryColor,
    this.borderColor = kPrimaryColor,
    this.onPressedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressedCallback,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            text.toUpperCase(),
            style: kLoginTextStyle.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
