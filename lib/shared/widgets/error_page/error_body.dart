import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';

class ErrorBody extends StatelessWidget {
  final String title;
  final String content;

  const ErrorBody({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: Fonts.primarySemiBold,
            fontSize: 20.0,
          ),
        ),
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: Fonts.primaryRegular,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
