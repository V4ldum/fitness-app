import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/video_player_provider.dart';

class VideoPlayerContent extends StatelessWidget {
  const VideoPlayerContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width:
              context.read<VideoPlayerProvider>().controller.value.size.width,
          height:
              context.read<VideoPlayerProvider>().controller.value.size.height,
          child: VideoPlayer(context.read<VideoPlayerProvider>().controller),
        ),
      ),
    );
  }
}
