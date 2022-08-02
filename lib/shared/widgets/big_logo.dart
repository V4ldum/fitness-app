import 'package:fitness_app/config/images.dart';
import 'package:flutter/material.dart';

class BigLogo extends StatelessWidget {
  const BigLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      height: 200.0,
      image: AssetImage(Images.bigLogo),
    );
  }
}
