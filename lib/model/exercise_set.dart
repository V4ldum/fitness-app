import 'package:fitness_app/model/exercise.dart';
import 'package:fitness_app/utils/duration_to_string.dart';

import 'bloc.dart';

class ExerciseSet extends Bloc {
  ExerciseSet({
    sets = 1,
    int restSeconds = 0,
    int restMinutes = 0,
    List<Exercise> exercises = const [],
    String videoAsset = "",
  })  : assert(sets > 0),
        assert(restSeconds >= 0 && restSeconds < 60),
        assert(restMinutes >= 0 && restMinutes < 60),
        super(
          sets: sets,
          restSeconds: restSeconds,
          restMinutes: restMinutes,
          exercises: exercises,
          videoAsset: videoAsset,
        );

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    List jsonExercises = json["exercises"] ?? [];
    List<Exercise> exercises = [];

    for (var element in jsonExercises) {
      exercises.add(Exercise.fromJson(element));
    }

    return ExerciseSet(
      sets: json["details"]?["sets"] ?? 1,
      restSeconds: json["details"]?["rest_duration"]?["sec"] ?? 0,
      restMinutes: json["details"]?["rest_duration"]?["min"] ?? 0,
      exercises: exercises,
      videoAsset: json["video"] ?? "",
    );
  }

  @override
  String toString() {
    StringBuffer out = StringBuffer();

    // Number of sets
    out.write("$sets Série");

    if (sets > 1) {
      out.write("s - ");

      // Rest duration
      out.write(Converter.durationToString(rest));
      out.write(" Repos");
    }

    return "$out";
  }
}
