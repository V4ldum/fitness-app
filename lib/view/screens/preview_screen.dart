import 'package:fitness_app/model/daily_program.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  static String route = "preview";
  final DailyProgram program;

  const PreviewScreen({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(program.title);
  }
}
