import 'package:fitness_app/config/index.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/video_player_provider.dart';

class VideoPlayerProgressIndicator extends StatelessWidget {
  const VideoPlayerProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      context.read<VideoPlayerProvider>().controller,
      allowScrubbing: true,
      colors: const VideoProgressColors(
        backgroundColor: Palette.tint1,
        bufferedColor: Palette.tint1,
        playedColor: Palette.accent,
      ),
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 5.0,
        left: 10.0,
        right: 10.0,
      ),
    );
  }
}
