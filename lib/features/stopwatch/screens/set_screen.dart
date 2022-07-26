import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class SetScreen extends StatelessWidget {
  const SetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<StopwatchProvider>() as StopwatchSetProvider;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top Part
        Flexible(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProgressCounter(
                current:
                    (context.watch<StopwatchProvider>() as StopwatchSetProvider)
                        .sets,
                max: provider.bloc.sets,
              ),
              context.watch<StopwatchProvider>().isWorkoutFinished
                  ? FinishedIndicator()
                  : StopwatchIndicator(
                      child: const StopwatchIndicatorCenterSet(),
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
                onTap: provider.startStopwatch,
                text:
                    provider.sets + 1 >= provider.bloc.sets && !provider.isRest
                        ? Strings.endLabel
                        : Strings.restLabel,
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
    );
  }
}
