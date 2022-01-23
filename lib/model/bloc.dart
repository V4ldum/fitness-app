import 'package:fitness_app/model/exercice.dart';

class Bloc {
  int sets;
  late Duration rest;
  List<Exercise> exercises;

  Bloc({
    this.sets = 1,
    int restSeconds = 0,
    int restMinutes = 0,
    this.exercises = const [],
  })  : assert(sets > 0),
        assert(restSeconds >= 0 && restSeconds < 60),
        assert(restMinutes >= 0 && restMinutes < 60) {
    rest = Duration(seconds: restSeconds, minutes: restMinutes);
  }

  factory Bloc.fromJson(Map<String, dynamic> json) {
    List jsonExercises = json["exercises"];
    List<Exercise> exercises = [];

    jsonExercises.map((element) => exercises.add(Exercise.fromJson(element)));

    return Bloc(
      sets: json["details"]["sets"] ?? 1,
      restSeconds: json["details"]["rest_duration"]["sec"] ?? 0,
      restMinutes: json["details"]["rest_duration"]["min"] ?? 0,
      exercises: exercises,
    );
  }
}
