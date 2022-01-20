import 'package:fitness_app/constants.dart';
import 'package:fitness_app/view/components/day_card.dart';
import 'package:fitness_app/view/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  static String route = "preview";

  const PreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: kAppBarPreviewString,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                DayCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
