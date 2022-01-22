import 'bloc.dart';

class Serie extends Bloc {
  int sets;
  late Duration restTime;

  Serie({this.sets = 1, int restSeconds = 0, int restMinutes = 0}) {
    //TODO asserts
    restTime = Duration(seconds: restSeconds, minutes: restMinutes);
  }
}
