import 'package:fitness_app/model/exercise.dart';
import 'package:fitness_app/utils/duration_to_string.dart';

import 'bloc.dart';

class EMOM extends Bloc {
  late Duration cap;
  late Duration work;

  EMOM({
    sets = 1,
    int capMinutes = 0,
    int capSeconds = 0,
    int restSeconds = 0,
    int restMinutes = 0,
    int workMinutes = 0,
    int workSeconds = 0,
    List<Exercise> exercises = const [],
  })  : assert(sets > 0),
        assert(capMinutes >= 0 && capMinutes < 60),
        assert(capSeconds >= 0 && capSeconds < 60),
        assert(restSeconds >= 0 && restSeconds < 60),
        assert(restMinutes >= 0 && restMinutes < 60),
        assert(workMinutes >= 0 && workMinutes < 60),
        assert(workSeconds >= 0 && workSeconds < 60),
        super(
          sets: sets,
          restSeconds: restSeconds,
          restMinutes: restMinutes,
          exercises: exercises,
        ) {
    cap = Duration(seconds: capSeconds, minutes: capMinutes);
    if (workMinutes == 0 && workSeconds == 0) {
      work = const Duration(minutes: 1);
    } else {
      work = Duration(seconds: workSeconds, minutes: workMinutes);
    }
  }

  factory EMOM.fromJson(Map<String, dynamic> json) {
    List jsonExercises = json["exercises"] ?? [];
    List<Exercise> exercises = [];

    for (var element in jsonExercises) {
      exercises.add(Exercise.fromJson(element));
    }

    return EMOM(
      sets: json["details"]?["sets"] ?? 1,
      restSeconds: json["details"]?["rest_duration"]?["sec"] ?? 0,
      restMinutes: json["details"]?["rest_duration"]?["min"] ?? 0,
      capMinutes: json["details"]?["cap_duration"]?["min"] ?? 0,
      capSeconds: json["details"]?["cap_duration"]?["sec"] ?? 0,
      workMinutes: json["details"]?["work_duration"]?["min"] ?? 0,
      workSeconds: json["details"]?["work_duration"]?["sec"] ?? 0,
      exercises: exercises,
    );
  }

  @override
  String toString() {
    StringBuffer out = StringBuffer();

    // if multiple sets of EMOM, write number
    if (sets != 1) {
      out.write("$sets Cycles [");
    }

    // Exercise type
    out.write("EMOM");

    // Duration of one set (only if != 1')
    if (work.inSeconds != 60) {
      out.write(" ");
      out.write(Converter.durationToString(work));
    }

    // Duration of total EMOM
    out.write(" -> ");
    out.write(Converter.durationToString(cap));

    // if multiple sets of EMOM, write rest duration
    if (sets != 1) {
      out.write("] - ");
      out.write(Converter.durationToString(rest));
      out.write(" Repos");
    }

    return "$out";
  }
}
