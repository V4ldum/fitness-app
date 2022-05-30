import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class CheckboxTileLabel extends StatelessWidget {
  final String label;

  const CheckboxTileLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: Fonts.primaryRegular,
        fontSize: 16.0,
      ),
    );
  }
}
