import 'package:video_player/video_player.dart';

abstract class VideoPlayerRepository {
  Future<void> play(VideoPlayerController controller);
  Future<void> pause(VideoPlayerController controller);
  Future<void> replay(VideoPlayerController controller);
  Future<void> forward10(VideoPlayerController controller);
  Future<void> backward10(VideoPlayerController controller);
}
