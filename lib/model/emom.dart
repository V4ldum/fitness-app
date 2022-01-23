import 'bloc.dart';

class EMOM extends Bloc {
  late Duration cap;

  EMOM({
    sets = 1,
    int capMinutes = 0,
    int capSeconds = 0,
    int restSeconds = 0,
    int restMinutes = 0,
  })  : assert(sets > 0),
        assert(capMinutes >= 0 && capMinutes < 60),
        assert(capSeconds >= 0 && capSeconds < 60),
        assert(restSeconds >= 0 && restSeconds < 60),
        assert(restMinutes >= 0 && restMinutes < 60),
        super(sets: sets, restSeconds: restSeconds, restMinutes: restMinutes) {
    cap = Duration(seconds: capSeconds, minutes: capMinutes);
  }

  factory EMOM.fromJson(Map<String, dynamic> json) {
    return EMOM(
      sets: json["details"]["sets"] ?? 1,
      restSeconds: json["details"]["set_duration"]["sec"] ?? 0,
      restMinutes: json["details"]["set_duration"]["min"] ?? 0,
      capMinutes: json["details"]["total_duration"]["min"] ?? 0,
      capSeconds: json["details"]["total_duration"]["sec"] ?? 0,
    );
  }
}
