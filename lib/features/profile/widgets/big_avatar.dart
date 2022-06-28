import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class BigAvatar extends StatelessWidget {
  final String image;
  final Function()? onPressEditButton;

  const BigAvatar({
    Key? key,
    required this.image,
    this.onPressEditButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 100.0,
          backgroundColor: Palette.accent,
          child: CircleAvatar(
            backgroundColor: Palette.primary,
            radius: 97.0,
            backgroundImage: const AssetImage(Images.profilePicturePlaceholder),
            foregroundImage: NetworkImage(image),
          ),
        ),
        if (onPressEditButton != null)
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0.85, 0.85),
              child: SizedBox(
                height: 32,
                width: 32,
                child: RepaintBoundary(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(0),
                        )),
                    onPressed: onPressEditButton,
                    child: const Icon(
                      Icons.edit,
                      color: Palette.tint1,
                      size: 19,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
