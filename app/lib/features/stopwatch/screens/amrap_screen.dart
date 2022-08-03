import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class AMRAPScreen extends StatelessWidget {
  const AMRAPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<StopwatchProvider>() as StopwatchAMRAPProvider;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Part
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      if (provider.sets != null)
                        CycleCounter(
                          current: provider.sets!,
                          max: provider.bloc.sets,
                        ),
                      if (provider.sets != null) const SizedBox(height: 6),
                      SizedBox(
                        height: 20,
                        child: ProgressCounter(
                          current: (context.watch<StopwatchProvider>()
                                  as StopwatchAMRAPProvider)
                              .progress,
                        ),
                      ),
                    ],
                  ),
                  RepaintBoundary(
                    child: context.watch<StopwatchProvider>().isWorkoutFinished
                        ? FinishedIndicator()
                        : StopwatchIndicator(
                            onTap: () {
                              if (provider.isCountdownStopped ||
                                  (provider.isCountdownPaused &&
                                      provider.isStopwatchStopped)) {
                                provider.startStopwatch();
                              } else {
                                provider.playpauseStopwatch();
                              }
                            },
                            child: const StopwatchIndicatorCenter(),
                          ),
                  ),
                ],
              ),
            ),
            // Middle w/ Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Palette.tint1,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: const SizedBox(height: 35.0),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Palette.tint1,
                        Palette.tint1,
                        Colors.transparent,
                        Colors.transparent
                      ],
                      stops: [0, 0.5, 0.5, 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: StopwatchButton(
                    onTap: provider.increment,
                    text: Strings.AMRAPButton,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Palette.tint1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                      ),
                    ),
                    child: const SizedBox(height: 35.0),
                  ),
                ),
              ],
            ),
            // Bottom Part
            Flexible(
              flex: 2,
              child: Container(
                color: Palette.tint1,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ExerciseList(),
                ),
              ),
            ),
          ],
        ),
        if (provider.lastRep != null)
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 6,
                  child: Container(),
                ),
                const Text(
                  Strings.AMRAPLastRoundLabel,
                  style: TextStyle(
                    fontFamily: Fonts.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  provider.lastRep!,
                  style: const TextStyle(
                    fontFamily: Fonts.primaryRegular,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(),
                ),
              ],
            ),
          )
      ],
    );
  }
}
