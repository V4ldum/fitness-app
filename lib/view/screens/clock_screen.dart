import 'package:fitness_app/view/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatelessWidget {
  static String route = "clock";

  const ClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: MyAppBar(title: "Chronomètre"),
        body: Text("Clock"),
      ),
    );
  }
}
