import 'package:flutter/scheduler.dart';

class Stopwatch {
  Ticker? _ticker;
  bool _isStopped = true;
  // ignore: constant_identifier_names
  static const int _ERROR_MARGIN = 20;

  Duration _elapsed = Duration.zero;
  Duration _previousElapsed = Duration.zero;
  Duration _timeCap = Duration.zero;

  final void Function()? onTickCallback;
  final void Function()? onQuarterCallback;
  final void Function()? onHalfCallback;
  final void Function()? onEndCallback;
  final void Function()? onLastThreeSeconds;

  bool _isHalfCallbackCalled = false;
  bool _isQuarterCallbackCalled = false;
  List<bool> _isLastThreeSecondsCalled = [false, false, false];

  Stopwatch({
    this.onTickCallback,
    this.onQuarterCallback,
    this.onHalfCallback,
    this.onEndCallback,
    this.onLastThreeSeconds,
  });

  Stopwatch.fromPreviousStopwatch({
    required Duration elapsed,
    required Duration timeCap,
    this.onTickCallback,
    this.onQuarterCallback,
    this.onHalfCallback,
    this.onEndCallback,
    this.onLastThreeSeconds,
  })  : assert(timeCap.inSeconds >= 1 || timeCap == Duration.zero),
        assert(elapsed != Duration.zero) {
    _init();
    _ticker = Ticker(_tickerCallback);

    _timeCap = timeCap;
    _previousElapsed = elapsed;

    _isStopped = false;
  }

  Duration get elapsed => _elapsed + _previousElapsed;
  Duration get timeCap => _timeCap;
  bool get isPaused => !_isStopped && _ticker != null && !_ticker!.isTicking;
  bool get isStopped => _isStopped;

  void start(Duration timeCap) {
    if (timeCap.inSeconds < 1 && timeCap != Duration.zero) {
      throw ArgumentError("timeCap should be >= 1, or == 0 is no cap");
    }

    if (isStopped) {
      _init();
      _timeCap = timeCap;
      _ticker = Ticker(_tickerCallback);
      _isStopped = false;
      _ticker!.start();
    }
  }

  void pause() {
    if (!isStopped && !isPaused) {
      _previousElapsed += _elapsed;
      _elapsed = Duration.zero;
      _ticker!.stop();
    }
  }

  void resume() {
    if (!isStopped && isPaused) {
      _ticker!.start();
    }
  }

  void stop({callEndCallback = false}) {
    if (!isStopped) {
      _isStopped = true;
      destroy();
      _timeCap = Duration.zero;

      if (callEndCallback) {
        onEndCallback?.call();
      }
    }
  }

  void _init() {
    _previousElapsed = Duration.zero;
    _elapsed = Duration.zero;
    _isHalfCallbackCalled = false;
    _isQuarterCallbackCalled = false;
    _isLastThreeSecondsCalled = [false, false, false];
  }

  void _tickerCallback(Duration newElapsed) {
    if (!_isStopped) {
      // each tick
      _elapsed = newElapsed;
      onTickCallback?.call();

      // onEnd
      if (_timeCap > Duration.zero && elapsed >= _timeCap) {
        stop();
        onEndCallback?.call();
        return;
      }

      // Don't run callbacks around start and end
      if (elapsed.inMilliseconds > _ERROR_MARGIN &&
          elapsed.inMilliseconds < _timeCap.inMilliseconds - _ERROR_MARGIN) {
        // onHalf
        if (onHalfCallback != null) {
          _halfCallback();
        }

        // onQuarter
        if (onQuarterCallback != null) {
          _quarterCallback();
        }

        // onLastThreeSeconds
        if (onLastThreeSeconds != null) {
          _onLastThreeSecondsCallback();
        }
      }
    }
  }

  void _halfCallback() {
    int half = (_timeCap.inMilliseconds / 2).truncate();
    int current = elapsed.inMilliseconds % (half);

    // timer is at half and callback hasn't already been called
    if (!_isHalfCallbackCalled && _isWithinErrorMargin(current, half)) {
      _isHalfCallbackCalled = true;
      onHalfCallback!();
    }
  }

  void _quarterCallback() {
    int quarters = (_timeCap.inMilliseconds / 4).truncate();
    int current = elapsed.inMilliseconds % (quarters);

    // timer is at a quarter and callback hasn't already been called
    if (!_isQuarterCallbackCalled && _isWithinErrorMargin(current, quarters)) {
      _isQuarterCallbackCalled =
          true; //used so it doesn't call back multiple times for different ticks on the same second
      onQuarterCallback!();
    }
    //resets the call tracker at quarter +1 (only called once per quarter)
    if (_isQuarterCallbackCalled &&
        _isWithinErrorMargin(current, 2 * _ERROR_MARGIN)) {
      _isQuarterCallbackCalled = false;
    }
  }

  void _onLastThreeSecondsCallback() {
    int millisecondsToEnd = (_timeCap - elapsed).inMilliseconds;

    if (_isWithinErrorMargin(millisecondsToEnd, 3000) ||
        _isWithinErrorMargin(millisecondsToEnd, 2000) ||
        _isWithinErrorMargin(millisecondsToEnd, 1000)) {
      int currentIndex = (millisecondsToEnd - _ERROR_MARGIN) ~/ 1000;

      if (!_isLastThreeSecondsCalled[currentIndex]) {
        _isLastThreeSecondsCalled[currentIndex] = true;
        onLastThreeSeconds!();
      }
    }
  }

  // approximate ~= real +- margin
  bool _isWithinErrorMargin(int approximate, int real) {
    return (real - approximate).abs() < _ERROR_MARGIN;
  }

  void destroy() {
    if (_ticker != null) {
      _ticker!.stop();
      _ticker!.dispose();
      _ticker = null;
    }
  }
}
