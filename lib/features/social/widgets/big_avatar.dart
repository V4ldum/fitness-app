import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class BigAvatar extends StatelessWidget {
  final String image;

  const BigAvatar({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 100.0,
      backgroundColor: Palette.accent,
      child: CircleAvatar(
        backgroundColor: Palette.primary,
        radius: 97.0,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
