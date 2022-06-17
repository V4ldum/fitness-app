import 'package:fitness_app/config/images.dart';
import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../icon_text_button.dart';
import 'error_body.dart';

class ErrorPage extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  final Function()? onPressed;
  final String? buttonText;
  final IconData? buttonIcon;

  const ErrorPage({
    Key? key,
    this.image = Images.errorImage,
    required this.title,
    required this.content,
    this.onPressed,
    this.buttonText,
    this.buttonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 250.0,
            color: Palette.tint3,
            image: AssetImage(image),
          ),
          const SizedBox(height: 15.0),
          ErrorBody(
            title: title,
            content: content,
          ),
          Column(
            children: [
              const SizedBox(height: 15.0),
              buttonText != null
                  ? IconTextButton(
                      onPressed: onPressed,
                      icon: buttonIcon,
                      text: buttonText!,
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
