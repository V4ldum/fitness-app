import 'package:video_player/video_player.dart';

import '../repository/video_player_repository.dart';

class VideoPlayerService implements VideoPlayerRepository {
  @override
  Future<void> play(VideoPlayerController controller) async {
    await controller.play();
  }

  @override
  Future<void> pause(VideoPlayerController controller) async {
    await controller.pause();
  }

  @override
  Future<void> replay(VideoPlayerController controller) async {
    await play(controller);
  }

  @override
  Future<void> forward10(VideoPlayerController controller) async {
    await controller.seekTo(
      Duration(
        seconds: controller.value.position.inSeconds + 10,
      ),
    );
  }

  @override
  Future<void> backward10(VideoPlayerController controller) async {
    await controller.seekTo(
      Duration(
        seconds: controller.value.position.inSeconds - 10,
      ),
    );
  }
}
