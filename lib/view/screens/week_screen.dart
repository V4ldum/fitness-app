import 'package:fitness_app/constants.dart';
import 'package:fitness_app/controller/program_manager.dart';
import 'package:fitness_app/model/daily_program.dart';
import 'package:fitness_app/view/components/day_card.dart';
import 'package:fitness_app/view/components/my_app_bar.dart';
import 'package:fitness_app/view/components/shimmer_day_card.dart';
import 'package:flutter/material.dart';

class WeekScreen extends StatelessWidget {
  static String route = "week";

  const WeekScreen({Key? key}) : super(key: key);

  Widget _errorBuilder(error) {
    return const Text("Error"); //TODO error
  }

  Widget _waitingBuilder() {
    return Column(
      children: const [
        ShimmerDayCard(),
        ShimmerDayCard(),
        ShimmerDayCard(),
        ShimmerDayCard(),
        ShimmerDayCard(),
      ],
    );
  }

  Widget _doneBuilder(List data) {
    List<Widget> listViewChildren = [];

    for (var element in data) {
      DailyProgram tmp = DailyProgram.fromJson(element);
      listViewChildren.add(DayCard(program: tmp));
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: listViewChildren,
    );
  }

  Widget _futureBuilderContent(
      BuildContext context, AsyncSnapshot<List> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError == true) {
        return _errorBuilder(snapshot.error);
      }
      return _errorBuilder(snapshot.data!);
    }
    return _waitingBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: kAppBarPreviewString,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: ProgramManager
                  .getProgramOfTheWeek(), //TODO Remove Future from Build?
              builder: _futureBuilderContent,
            )),
      ),
    );
  }
}
