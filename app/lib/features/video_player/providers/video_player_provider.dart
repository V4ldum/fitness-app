import 'package:fitness_app/features/video_player/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  late final VideoPlayerRepository _vps = VideoPlayerService();
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayer;

  VideoPlayerProvider.fromAsset(String url) {
    _controller = VideoPlayerController.asset(url);
    _initialize();
  }

  VideoPlayerProvider.fromNetwork(String url) {
    _controller = VideoPlayerController.network(url);
    _initialize();
  }

  void _initialize() {
    _initializeVideoPlayer = _controller.initialize().then((value) => play());
    _controller.addListener(() {
      if (isDonePlaying) {
        notifyListeners();
      }
    });
  }

  get controller => _controller;

  get initializeVideoPlayer => _initializeVideoPlayer;

  get isDonePlaying {
    return !_controller.value.isPlaying &&
        _controller.value.isInitialized &&
        (_controller.value.duration == _controller.value.position);
  }

  get isPlaying {
    return _controller.value.isPlaying;
  }

  void play() {
    _vps.play(_controller);
    notifyListeners();
  }

  void pause() {
    _vps.pause(_controller);
    notifyListeners();
  }

  void playpause() {
    if (!isDonePlaying) {
      if (isPlaying) {
        pause();
      } else {
        play();
      }
    } else {
      replay();
    }
  }

  void forward10() {
    _vps.forward10(_controller);
  }

  void backward10() async {
    Future<void> future = _vps.backward10(_controller);
    if (isDonePlaying) {
      await future;
      play();
    }
  }

  void replay() {
    _vps.replay(_controller);
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
