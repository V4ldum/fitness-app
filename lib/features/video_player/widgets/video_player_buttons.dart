import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class VideoPlayerButtons extends StatelessWidget {
  const VideoPlayerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VideoPlayerBackwardButton(
          onPressed: context.read<VideoPlayerProvider>().backward10,
        ),
        const SizedBox(width: 20.0),
        VideoPlayerPlayPauseButton(
          onPressed: context.read<VideoPlayerProvider>().playpause,
          isPlaying: context.watch<VideoPlayerProvider>().isPlaying,
        ),
        const SizedBox(width: 20.0),
        VideoPlayerForwardButton(
          onPressed: context.read<VideoPlayerProvider>().forward10,
        ),
      ],
    );
  }
}
