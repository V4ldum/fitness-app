import 'package:fitness_app/features/daily/card_body.dart';
import 'package:fitness_app/features/main/index.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:flutter/material.dart';

class DayScreen extends StatelessWidget {
  static String route = "day";

  final DailyProgram program;

  const DayScreen({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: program.title,
          leading: AppBarButton(
            icon: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            //TODO card déjà utilisée ? autre UI ? jsp
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardBody(
                //TODO provider?
                blocs: program.blocs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
