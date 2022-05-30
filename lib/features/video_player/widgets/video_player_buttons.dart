import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/video_player_provider.dart';
import 'video_player_backward_button.dart';
import 'video_player_forward_button.dart';
import 'video_player_play_pause_button.dart';

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
          onPressed: () {
            VideoPlayerProvider provider = context.read<VideoPlayerProvider>();
            if (provider.isPlaying) {
              provider.pause();
            } else {
              provider.play();
            }
          },
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
