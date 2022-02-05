import 'package:fitness_app/model/daily_program.dart';
import 'package:fitness_app/view/components/my_app_bar.dart';
import 'package:fitness_app/view/components/preview_video_player.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  static String route = "preview";
  final DailyProgram program;

  const PreviewScreen({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MyAppBar(title: "Demonstration", pop: true),
        body: Center(
          child:
              PreviewVideoPlayer(videoURL: program.getCurrentBloc().videoAsset),
        ),
      ),
    );
  }
}
