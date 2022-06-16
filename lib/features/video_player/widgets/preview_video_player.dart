import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/video_player_provider.dart';
import 'video_player_content.dart';
import 'video_player_hub.dart';
import 'video_player_replay_button.dart';

class PreviewVideoPlayer extends StatelessWidget {
  const PreviewVideoPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const VideoPlayerContent(),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black26,
                Colors.transparent,
              ],
              begin: Alignment(-1, -1),
              end: Alignment(-1, -0.75),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black26,
                Colors.transparent,
              ],
              begin: Alignment(1, 1),
              end: Alignment(1, 0.6),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height - 130,
                  child: GestureDetector(
                    onTap: context.read<VideoPlayerProvider>().playpause,
                    onDoubleTap: context.read<VideoPlayerProvider>().backward10,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height - 130,
                      child: GestureDetector(
                        onTap: context.read<VideoPlayerProvider>().playpause,
                      ),
                    ),
                    Visibility(
                      visible:
                          context.watch<VideoPlayerProvider>().isDonePlaying,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.black26,
                              Colors.transparent,
                            ],
                            radius: 0.55,
                          ),
                        ),
                        child: VideoPlayerReplayButton(
                          onPressed: context.read<VideoPlayerProvider>().replay,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height - 130,
                  child: GestureDetector(
                    onTap: context.read<VideoPlayerProvider>().playpause,
                    onDoubleTap: context.read<VideoPlayerProvider>().forward10,
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: VideoPlayerHub(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
