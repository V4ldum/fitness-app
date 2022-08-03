import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/main/domain/models/emom.dart';
import 'package:fitness_app/features/stopwatch/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EMOMScreen extends StatelessWidget {
  const EMOMScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<StopwatchProvider>() as StopwatchEMOMProvider;

    return Column(
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
                              as StopwatchEMOMProvider)
                          .progress,
                      max: (provider.bloc as EMOM).cap.inSeconds ~/
                          (provider.bloc as EMOM).work.inSeconds,
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
        // Bottom Part
        Flexible(
          flex: 2,
          child: Container(
            color: Palette.tint1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ExerciseList(
                currentExercise:
                    provider.progress % provider.bloc.exercises.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
