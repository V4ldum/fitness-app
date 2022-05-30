import 'package:flutter/material.dart';

class VideoPlayerBackwardButton extends StatelessWidget {
  final Function()? onPressed;

  const VideoPlayerBackwardButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 35,
      icon: const Icon(
        Icons.replay_10,
      ),
    );
  }
}
