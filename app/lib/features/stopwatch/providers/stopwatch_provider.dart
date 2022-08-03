import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/main/domain/domain.dart';
import 'package:flutter/material.dart';

import '../index.dart';

abstract class StopwatchProvider extends ChangeNotifier {
  @protected
  StopwatchRepository service = StopwatchService();

  final AudioCache _cache = AudioCache(prefix: Strings.assetsFolder);
  final AudioPlayer _player = AudioPlayer();

  Timer? _timer;
  @protected
  late int countdownCounter;

  late Bloc bloc;
  late Stopwatch _stopwatch;
  bool isRest = false;

  bool isMuted = false;

  @protected
  bool started = false;
  @protected
  bool finished = false;

  StopwatchProvider(this.bloc) {
    _construction();

    _stopwatch = Stopwatch(
      onTickCallback: _onTickCallback,
      onHalfCallback: _onHalfCallback,
      onEndCallback: _onEndCallback,
      onLastThreeSeconds: _onLastThreeSecondsCallback,
    );
  }

  StopwatchProvider.fromElapsed(
    this.bloc, {
    required Duration elapsed,
    required Duration timeCap,
  }) {
    _construction();

    _stopwatch = Stopwatch.fromPreviousStopwatch(
      elapsed: elapsed,
      timeCap: timeCap,
      onTickCallback: _onTickCallback,
      onHalfCallback: _onHalfCallback,
      onEndCallback: _onEndCallback,
      onLastThreeSeconds: _onLastThreeSecondsCallback,
    );
    _timer = Timer(
        Duration.zero, () {}); // Dummy timer to recreate state before backup
  }

  void _construction() {
    _cache.loadAll([
      Strings.highBeepSound,
      Strings.mediumBeepSound,
      Strings.lowBeepSound,
    ]);
    service.getSoundSettings().then((value) {
      isMuted = value ?? false;
      notifyListeners();
    });
  }

  @protected
  Stopwatch get stopwatch => _stopwatch;

  bool get isStopwatchPaused => _stopwatch.isPaused;
  bool get isStopwatchStopped => _stopwatch.isStopped;
  bool get isCountdownPaused => _timer != null && !_timer!.isActive;
  bool get isCountdownStopped => _timer == null;

  bool get isBtnActive;

  bool get isTimeCapSet => _stopwatch.timeCap != Duration.zero;
  Duration get elapsed => _stopwatch.elapsed;
  double get elapsedInSeconds => elapsed.inMilliseconds / 1000.0;
  String get elapsedAsString => elapsed.toString().substring(2, 7);
  int get countdown => countdownCounter;

  bool get isWorkoutStarted => started;
  bool get isWorkoutFinished => finished;

  double get f {
    if (_stopwatch.timeCap != Duration.zero) {
      return 1 / _stopwatch.timeCap.inSeconds;
    }
    return 1 / 60;
  }

  @protected
  void init();
  @protected
  void onEnd();

  Map<String, dynamic> backup();

  void startStopwatch() {
    if (countdown != 0) {
      notifyListeners();

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        countdownCounter--;
        notifyListeners();

        if (countdownCounter <= 0) {
          if (!isMuted) {
            _player.play(
                UrlSource(
                    (_cache.loadedFiles[Strings.mediumBeepSound])!.toString()),
                mode: PlayerMode.lowLatency);
          }

          timer.cancel();
          started = true;
          finished = false;
          init();
        } else if (countdownCounter <= 3) {
          if (!isMuted) {
            _player.play(
                UrlSource(
                    (_cache.loadedFiles[Strings.lowBeepSound])!.toString()),
                mode: PlayerMode.lowLatency);
          }
        }
      });
    } else {
      // Specific case of the set which doesn't use countdown
      started = true;
      finished = false;
      init();
    }
  }

  void playpauseStopwatch() {
    if (!isStopwatchStopped || !isCountdownStopped) {
      if (!isCountdownStopped && isStopwatchStopped) {
        _timer!.cancel();
        countdownCounter = 10;
        notifyListeners();
        return;
      }

      if (isStopwatchPaused) {
        _stopwatch.resume();
      } else {
        _stopwatch.pause();
      }
      notifyListeners();
    }
  }

  void fin() {
    finished = true;
    notifyListeners();
  }

  void muteUnmute() {
    isMuted = !isMuted;
    service.saveSoundSettings(isMuted);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.destroy();
    _player.dispose();
    _cache.clearAll();
    super.dispose();
  }

  /* Stopwatch callbacks */
  void _onTickCallback() {
    notifyListeners();
  }

  void _onHalfCallback() {
    if (!isMuted) {
      _player.play(
          UrlSource((_cache.loadedFiles[Strings.highBeepSound])!.toString()),
          mode: PlayerMode.lowLatency);
    }
  }

  void _onEndCallback() {
    if (!isMuted) {
      _player.play(
          UrlSource((_cache.loadedFiles[Strings.mediumBeepSound])!.toString()),
          mode: PlayerMode.lowLatency);
    }
    onEnd();
  }

  void _onLastThreeSecondsCallback() {
    if (!isMuted) {
      _player.play(
          UrlSource((_cache.loadedFiles[Strings.lowBeepSound])!.toString()),
          mode: PlayerMode.lowLatency);
    }
  }
}
