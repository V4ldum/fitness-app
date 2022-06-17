import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class Comments extends StatelessWidget {
  final int number;

  const Comments({Key? key, this.number = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$number commentaires",
      style: const TextStyle(
        color: Palette.accent,
        fontFamily: Fonts.primarySemiBold,
        fontSize: 14.0,
      ),
    );
  }
}
