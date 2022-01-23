import 'bloc.dart';

class Set extends Bloc {
  Set({
    sets = 1,
    int restSeconds = 0,
    int restMinutes = 0,
  })  : assert(sets > 0),
        assert(restSeconds >= 0 && restSeconds < 60),
        assert(restMinutes >= 0 && restMinutes < 60),
        super(sets: sets, restSeconds: restSeconds, restMinutes: restMinutes);

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      sets: json["details"]["sets"] ?? 1,
      restSeconds: json["details"]["rest_duration"]["sec"] ?? 0,
      restMinutes: json["details"]["rest_duration"]["min"] ?? 0,
    );
  }
}
