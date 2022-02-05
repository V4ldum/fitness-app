import 'package:fitness_app/constants.dart';
import 'package:fitness_app/controller/program_manager.dart';
import 'package:fitness_app/model/daily_program.dart';
import 'package:fitness_app/view/components/day_card.dart';
import 'package:fitness_app/view/components/my_app_bar.dart';
import 'package:fitness_app/view/components/shimmer_day_card.dart';
import 'package:flutter/material.dart';

class WeekScreen extends StatefulWidget {
  static String route = "week";

  const WeekScreen({Key? key}) : super(key: key);

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  Widget _errorBuilder(error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            height: 250.0,
            image: AssetImage("assets/fatigue.png"),
          ),
          const SizedBox(height: 15.0),
          const Text(
            kConnectionErrorHeaderString,
            textAlign: TextAlign.center,
            style: kErrorHeaderStyle,
          ),
          const Text(
            kConnectionErrorBodyString,
            textAlign: TextAlign.center,
            style: kErrorBodyStyle,
          ),
          const SizedBox(height: 15.0),
          TextButton.icon(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
              color: kPrimaryColor,
            ),
            label: const Text(
              kRefreshButtonString,
              style: kTextButtonStyle,
            ),
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
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
      listViewChildren.add(
        DayCard(program: tmp),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: listViewChildren,
    );
  }

  Widget _buildWeeklyProgram(
      BuildContext context, AsyncSnapshot<List> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError == true) {
        return _errorBuilder(snapshot.error);
      }
      return _doneBuilder(snapshot.data!);
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
              future: ProgramManager.getProgramOfTheWeek(),
              builder: _buildWeeklyProgram,
            )),
      ),
    );
  }
}
