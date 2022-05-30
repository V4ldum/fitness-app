import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class SmallLogo extends StatelessWidget {
  const SmallLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(Images.smallLogo),
    );
  }
}
