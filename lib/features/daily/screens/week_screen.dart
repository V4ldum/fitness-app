import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/profile/screens/profile_screen.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:fitness_app/shared/widgets/small_logo.dart';
import 'package:flutter/material.dart';

import '../domain/domain.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class WeekScreen extends StatefulWidget {
  static String route = "week";

  const WeekScreen({Key? key}) : super(key: key);

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  Widget _errorBuilder(error) {
    return ErrorPage(
      title: Strings.connectionErrorHeader,
      content: Strings.connectionErrorBody,
      buttonIcon: Icons.refresh,
      buttonText: Strings.refreshButton,
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _waitingBuilder() {
    return ListView(
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
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return DayCard(
          program: DailyProgram.fromJson(data[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: Strings.appBarWeek,
          leading: const SmallLogo(),
          trailing: AppBarButton(
            icon: Icons.people_alt,
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.route);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: DailyProvider().getProgram(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError == true) {
                  return _errorBuilder(snapshot.error);
                }
                return _doneBuilder(snapshot.data!);
              }
              return _waitingBuilder();
            },
          ),
        ),
      ),
    );
  }
}
