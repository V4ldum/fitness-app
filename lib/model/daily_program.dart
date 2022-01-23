import 'package:fitness_app/model/bloc.dart';

class DailyProgram {
  String title;
  String subtitle;
  List<Bloc> blocs;
  String text;

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

    jsonBlocs.map((element) => blocs.add(Bloc.fromJson(element)));

    return DailyProgram(
      title: json["title"],
      subtitle: json["subtitle"],
      blocs: blocs,
      text: json["text"] ?? "",
    );
  }
}
