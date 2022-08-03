import 'package:flutter/material.dart';

class VideoPlayerForwardButton extends StatelessWidget {
  final Function()? onPressed;

  const VideoPlayerForwardButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 35,
      icon: const Icon(
        Icons.forward_10,
      ),
    );
  }
}
