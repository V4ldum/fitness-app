import 'package:flutter/widgets.dart';

import 'video_player_buttons.dart';
import 'video_player_progress_indicator.dart';

class VideoPlayerHub extends StatelessWidget {
  const VideoPlayerHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        VideoPlayerProgressIndicator(),
        VideoPlayerButtons(),
      ],
    );
  }
}
