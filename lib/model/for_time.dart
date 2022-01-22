import 'bloc.dart';

class ForTime extends Bloc {
  int sets;
  late Duration timeCap;

  ForTime({this.sets = 1, int capSeconds = 0, int capMinutes = 0}) {
    //TODO assets
    timeCap = Duration(seconds: capSeconds, minutes: capMinutes);
  }
}
