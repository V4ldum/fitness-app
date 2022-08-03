import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  final IconData icon;

  const AppBarButton({Key? key, required this.icon, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 26,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? Palette.accent,
      ),
    );
  }
}
