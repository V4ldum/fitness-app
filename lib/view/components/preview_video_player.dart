import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreviewVideoPlayer extends StatefulWidget {
  final String videoURL;

  const PreviewVideoPlayer({
    Key? key,
    required this.videoURL,
  }) : super(key: key);

  @override
  State<PreviewVideoPlayer> createState() => _PreviewVideoPlayerState();
}

class _PreviewVideoPlayerState extends State<PreviewVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.videoURL);
    _initializeVideoPlayerFuture =
        _controller.initialize().then((value) => setState(() {
              _controller.play();
            }));
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _errorBuilder(error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            height: 250.0,
            image: AssetImage("assets/fatigue.png"),
          ),
          SizedBox(height: 15.0),
          Text(
            kVideoErrorHeaderString,
            textAlign: TextAlign.center,
            style: kErrorHeaderStyle,
          ),
          Text(
            kVideoErrorBodyString,
            textAlign: TextAlign.center,
            style: kErrorBodyStyle,
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  Widget _waitingBuilder() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _doneBuilder() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError == true) {
        return _errorBuilder(snapshot.error);
      }
      return _doneBuilder();
    } else {
      return _waitingBuilder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: _buildVideoPlayer,
          ),
          Container(
            decoration: kPreviewTopGradiant,
          ),
          Container(
            decoration: kPreviewBottomGradiant,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    backgroundColor: kTintDarkColor,
                    bufferedColor: kTintDarkColor,
                    playedColor: kPrimaryColor,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 5.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _controller.seekTo(
                          Duration(
                            seconds: _controller.value.position.inSeconds - 10,
                          ),
                        );
                      },
                      iconSize: 35,
                      icon: const Icon(
                        Icons.replay_10,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                      iconSize: 55,
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    IconButton(
                      onPressed: () {
                        _controller.seekTo(
                          Duration(
                            seconds: _controller.value.position.inSeconds + 10,
                          ),
                        );
                      },
                      iconSize: 35,
                      icon: const Icon(
                        Icons.forward_10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0)
              ],
            ),
          ),
          Visibility(
            visible: _controller.value.duration == _controller.value.position,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.black12,
                      Colors.transparent,
                    ],
                    radius: 0.5,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.play();
                    });
                  },
                  iconSize: 60.0,
                  icon: const Icon(Icons.replay),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
