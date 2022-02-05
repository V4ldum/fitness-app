import 'package:fitness_app/model/amrap.dart';
import 'package:fitness_app/model/bloc.dart';
import 'package:fitness_app/model/emom.dart';
import 'package:fitness_app/model/exercise_set.dart';
import 'package:fitness_app/model/exercise_type.dart';
import 'package:fitness_app/model/for_time.dart';
import 'package:fitness_app/model/tabata.dart';

class DailyProgram {
  String title;
  String subtitle;
  List<Bloc> blocs;
  String text;
  int _currentBloc = 1;

  bool get isRestDay {
    return text != "";
  }

  DailyProgram({
    required this.title,
    required this.subtitle,
    this.blocs = const [],
    this.text = "",
  });

  factory DailyProgram.fromJson(Map<String, dynamic> json) {
    List jsonBlocs = json["blocs"] ?? [];
    List<Bloc> blocs = [];
    Map<BlocType, Bloc Function(Map<String, dynamic>)> types = {
      BlocType.set: ExerciseSet.fromJson,
      BlocType.amrap: AMRAP.fromJson,
      BlocType.forTime: ForTime.fromJson,
      BlocType.emom: EMOM.fromJson,
      BlocType.tabata: Tabata.fromJson,
    };

    for (var element in jsonBlocs) {
      Function(Map<String, dynamic>) exerciseConstructor =
          types[BlocType.values[element["type"]]]!;
      blocs.add(exerciseConstructor(element));
    }

    return DailyProgram(
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      blocs: blocs,
      text: json["text"] ?? "",
    );
  }

  void startProgram() {
    _currentBloc = 1;
  }

  void nextBloc() {
    _currentBloc++;
  }

  Bloc getCurrentBloc() {
    return blocs[_currentBloc];
  }
}
