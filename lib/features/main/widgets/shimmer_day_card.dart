import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/shared/widgets/separator.dart';
import 'package:flutter/material.dart';

import 'shimmer_bar.dart';

class ShimmerDayCard extends StatelessWidget {
  const ShimmerDayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.tint1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerBar(
                        width: 120.0,
                        height: 25.0,
                      ),
                      SizedBox(height: 5.0),
                      ShimmerBar(
                        width: 100.0,
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ShimmerBar(
                    width: 25.0,
                    height: 25.0,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Separator(indent: 8.0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: ShimmerBar(
                    width: 140.0,
                    height: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
