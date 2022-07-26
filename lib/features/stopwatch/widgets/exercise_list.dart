import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class ExerciseList extends StatelessWidget {
  final int? currentExercise;

  const ExerciseList({
    Key? key,
    this.currentExercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<StopwatchProvider>();
    var exercises = provider.bloc.exercises;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RichText(
              text: TextSpan(
                children: [
                  for (int i = 0; i < exercises.length; i++)
                    TextSpan(
                      text:
                          "${exercises[i]}${i == exercises.length - 1 ? "" : "\n"}",
                      style: TextStyle(
                        fontFamily: currentExercise != null &&
                                currentExercise == i &&
                                !provider.isRest &&
                                !provider.isStopwatchStopped
                            ? Fonts.primaryBold
                            : Fonts.primaryMedium,
                        fontSize: 18.0,
                        height: 1.8,
                        color: currentExercise != null &&
                                currentExercise == i &&
                                !provider.isRest &&
                                !provider.isStopwatchStopped
                            ? Palette.accent
                            : null,
                      ),
                    )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
