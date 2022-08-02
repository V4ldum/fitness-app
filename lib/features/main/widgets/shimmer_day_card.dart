import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/shared/widgets/separator.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/shimmer_bar.dart';

class ShimmerDayCard extends StatelessWidget {
  const ShimmerDayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.tint1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 13.0),
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
            const Separator(indent: 8),
            // Card Carousel
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBar(width: 100, height: 30),
                  SizedBox(height: 8),
                  ShimmerBar(width: double.infinity, height: 20),
                  SizedBox(height: 5),
                  ShimmerBar(width: double.infinity, height: 20),
                ],
              ),
            ),
            const Separator(indent: 8),
            // Body
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ShimmerBar(
                width: 140.0,
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
