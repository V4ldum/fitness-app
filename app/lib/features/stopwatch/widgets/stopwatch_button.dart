import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/stopwatch/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StopwatchButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? text;

  const StopwatchButton({
    Key? key,
    this.onTap,
    this.icon,
    this.text,
  })  : assert(text != null || icon != null),
        assert(text == null || icon == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.watch<StopwatchProvider>().isBtnActive ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: context.watch<StopwatchProvider>().isBtnActive
              ? Palette.accent
              : Palette.tint1,
          border: Border.all(color: Palette.primary, width: 8),
          borderRadius: BorderRadius.circular(29),
        ),
        child: text != null
            ? Text(
                text!.toUpperCase(),
                style: const TextStyle(
                  fontFamily: Fonts.secondaryRegular,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2,
                  color: Palette.primary,
                ),
              )
            : Icon(
                icon!,
              ),
      ),
    );
  }
}
