import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class SettingsTitle extends StatelessWidget {
  final String title;

  const SettingsTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: Fonts.primarySemiBold,
        fontSize: 18.0,
      ),
    );
  }
}
