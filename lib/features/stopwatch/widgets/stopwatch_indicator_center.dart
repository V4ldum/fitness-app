import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class StopwatchIndicatorCenter extends StatelessWidget {
  const StopwatchIndicatorCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<StopwatchProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.0,
          child: Center(
            child: Text(
              provider.isRest
                  ? Strings.restLabel
                  : provider.isStopwatchPaused
                      ? provider.elapsedAsString
                      : "",
              style: const TextStyle(
                fontFamily: Fonts.primaryRegular,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 90,
          child: (provider.isStopwatchPaused || provider.isStopwatchStopped) &&
                  (provider.isCountdownStopped || provider.isCountdownPaused)
              ? Icon(
                  provider.isStopwatchStopped && provider.isCountdownStopped
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  color: Palette.accent,
                  size: 90,
                )
              : Text(
                  provider.countdown == 0
                      ? provider.elapsedAsString
                      : provider.countdown.toString(),
                  style: const TextStyle(
                    fontFamily: Fonts.primaryRegular,
                    color: Palette.accent,
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        SizedBox(
          height: 40.0,
          child: Center(
            child: Text(
              provider.isStopwatchStopped
                  ? provider.isCountdownStopped
                      ? Strings.startLabel
                      : provider.isCountdownPaused
                          ? Strings.resumeLabel
                          : Strings.pauseLabel
                  : provider.isStopwatchPaused
                      ? Strings.resumeLabel
                      : Strings.pauseLabel,
              style: const TextStyle(
                fontFamily: Fonts.primaryRegular,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
