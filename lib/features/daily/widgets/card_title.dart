import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class CardTitle extends StatelessWidget {
  final String content;

  const CardTitle(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
        fontFamily: Fonts.primarySemiBold,
        fontSize: 22.0,
      ),
    );
  }
}
