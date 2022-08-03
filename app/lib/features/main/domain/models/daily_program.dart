import 'amrap.dart';
import 'bloc.dart';
import 'emom.dart';
import 'exercise_set.dart';
import 'exercise_type.dart';
import 'for_time.dart';
import 'tabata.dart';

class DailyProgram {
  String title;
  String subtitle;
  List<Bloc> blocs;
  String text;
  int comments;

  bool get isRestDay {
    return blocs.isEmpty;
  }

  DailyProgram({
    required this.title,
    required this.subtitle,
    this.blocs = const [],
    this.text = "",
    required this.comments,
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
      comments: json["nb_comments"] ?? 0,
    );
  }
}
