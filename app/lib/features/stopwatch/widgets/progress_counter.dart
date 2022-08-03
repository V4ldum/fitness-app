import 'package:flutter/material.dart';

import './progress_indicator.dart' as my;

class ProgressCounter extends StatelessWidget {
  final int current;
  final int? max;

  const ProgressCounter({
    Key? key,
    required this.current,
    this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // max value is set
        if (max != null)
          for (int i = 0; i < max!; i++)
            Row(
              children: [
                if (i != 0) const SizedBox(width: 18),
                my.ProgressIndicator(
                  isFilled: current > i,
                ),
              ],
            ),
        // max value is not set
        if (max == null)
          for (int i = 0; i < current; i++)
            Row(
              children: [
                if (i != 0) const SizedBox(width: 18),
                const my.ProgressIndicator(
                  isFilled: true,
                ),
              ],
            ),
      ],
    );
  }
}
