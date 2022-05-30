import 'package:flutter/material.dart';

class VideoPlayerPlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final Function()? onPressed;

  const VideoPlayerPlayPauseButton(
      {Key? key, required this.isPlaying, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 55,
      icon: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow_rounded,
      ),
    );
  }
}
