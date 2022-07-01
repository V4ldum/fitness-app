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
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: ShimmerDayCard(),
        );
      },
    );
  }

  Widget _doneBuilder(List data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: DayCard(
            program: data[index],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DailyProvider provider = context.read<DailyProvider>();

    if (provider.programs != null) {
      return _doneBuilder(provider.programs!);
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
