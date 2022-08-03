import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class StopwatchIndicatorCenterSet extends StatelessWidget {
  const StopwatchIndicatorCenterSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<StopwatchProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.0,
          child: Center(
            child: Text(
              provider.isRest ? Strings.restLabel : "",
              style: const TextStyle(
                fontFamily: Fonts.primaryRegular,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 90,
          child: Text(
            (provider.bloc.rest - provider.elapsed).toString().substring(2, 7),
            style: const TextStyle(
              fontFamily: Fonts.primaryRegular,
              color: Palette.accent,
              fontSize: 65,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 40.0),
      ],
    );
  }
}
