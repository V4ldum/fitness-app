import 'package:flutter/material.dart';

class VideoPlayerReplayButton extends StatelessWidget {
  final Function()? onPressed;

  const VideoPlayerReplayButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 60.0,
      icon: const Icon(Icons.replay),
    );
  }
}
