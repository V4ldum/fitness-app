import 'bloc.dart';

class Tabata extends Bloc {
  int sets;
  late Duration work;
  late Duration rest;
  late Duration setBreak;

  Tabata(
      {this.sets = 1,
      int workSeconds = 0,
      int workMinutes = 0,
      int restSeconds = 0,
      int restMinutes = 0,
      int setBreakSeconds = 0,
      int setBreakMinutes = 0}) {
    //TODO asserts
    work = Duration(seconds: workSeconds, minutes: workMinutes);
    rest = Duration(seconds: restSeconds, minutes: restMinutes);
    work = Duration(seconds: setBreakSeconds, minutes: setBreakMinutes);
  }
}
