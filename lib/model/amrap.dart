import 'bloc.dart';

class AMRAP extends Bloc {
  int sets;
  late Duration timeCap;

  AMRAP({this.sets = 1, int capMinutes = 0, int capSeconds = 0}) {
    //TODO asserts
    timeCap = Duration(seconds: capSeconds, minutes: capMinutes);
  }
}
