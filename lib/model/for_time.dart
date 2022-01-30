import 'package:fitness_app/model/exercise.dart';
import 'package:fitness_app/utils/duration_to_string.dart';

import 'bloc.dart';

class ForTime extends Bloc {
  late Duration cap;

  ForTime({
    sets = 1,
    int capMinutes = 0,
    int capSeconds = 0,
    int restSeconds = 0,
    int restMinutes = 0,
    List<Exercise> exercises = const [],
  })  : assert(sets > 0),
        assert(capMinutes >= 0 && capMinutes < 60),
        assert(capSeconds >= 0 && capSeconds < 60),
        assert(restSeconds >= 0 && restSeconds < 60),
        assert(restMinutes >= 0 && restMinutes < 60),
        super(
          sets: sets,
          restSeconds: restSeconds,
          restMinutes: restMinutes,
          exercises: exercises,
        ) {
    cap = Duration(seconds: capSeconds, minutes: capMinutes);
  }

  factory ForTime.fromJson(Map<String, dynamic> json) {
    List jsonExercises = json["exercises"] ?? [];
    List<Exercise> exercises = [];

    for (var element in jsonExercises) {
      exercises.add(Exercise.fromJson(element));
    }

    return ForTime(
      sets: json["details"]?["sets"] ?? 1,
      restSeconds: json["details"]?["rest_duration"]?["sec"] ?? 0,
      restMinutes: json["details"]?["rest_duration"]?["min"] ?? 0,
      capMinutes: json["details"]?["cap_duration"]?["min"] ?? 0,
      capSeconds: json["details"]?["cap_duration"]?["sec"] ?? 0,
      exercises: exercises,
    );
  }

  @override
  String toString() {
    StringBuffer out = StringBuffer();

    // if multiple sets of For Time, write number
    if (sets != 1) {
      out.write("$sets Cycles [");
    }

    // Exercise type
    out.write("For Time");

    if (cap != Duration.zero) {
      out.write(" ");

      // Time cap of the AMRAP
      out.write(Converter.durationToString(cap));
    }

    // if multiple sets of For Time, write rest duration
    if (sets != 1) {
      out.write("] - ");
      out.write(Converter.durationToString(rest));
      out.write(" Repos");
    }

    return "$out";
  }
}
