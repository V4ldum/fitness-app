import 'bloc.dart';

class EMOM extends Bloc {
  late Duration setTime;
  late Duration totalTime;

  EMOM(
      {int setSeconds = 0,
      int setMinutes = 0,
      int totalSeconds = 0,
      int totalMinutes = 0}) {
    //TODO asserts
    setTime = Duration(seconds: setSeconds, minutes: setMinutes);
    totalTime = Duration(seconds: totalSeconds, minutes: totalMinutes);
  }
}
