import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class CardSubtitle extends StatelessWidget {
  final String content;

  const CardSubtitle(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
        fontFamily: Fonts.secondaryRegular,
        fontStyle: FontStyle.italic,
        fontSize: 19.0,
      ),
    );
  }
}
