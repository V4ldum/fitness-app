import 'package:fitness_app/model/exercise.dart';

abstract class Bloc {
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

  @override
  String toString();
}
