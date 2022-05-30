import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class ProfileName extends StatelessWidget {
  final String name;

  const ProfileName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25.0,
        fontFamily: Fonts.primaryRegular,
      ),
    );
  }
}
