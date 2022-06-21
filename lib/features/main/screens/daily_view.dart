import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class DailyView extends StatefulWidget {
  const DailyView({Key? key}) : super(key: key);

  @override
  State<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyView> {
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
          program: data[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MainProvider provider = context.read<MainProvider>();

    if (provider.dailyProgram != null) {
      return _doneBuilder(provider.dailyProgram!);
    }
    return FutureBuilder(
      future: provider.getProgram(context.read<AppWideProvider>().accessToken!),
      builder: (BuildContext _, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _errorBuilder(snapshot.error);
          }
          return _doneBuilder(snapshot.data!);
        }
        return _waitingBuilder();
      },
    );
  }
}
