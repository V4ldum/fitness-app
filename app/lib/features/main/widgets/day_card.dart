import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/comments/screens/comments_screen.dart';
import 'package:fitness_app/shared/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../index.dart';

class DayCard extends StatefulWidget {
  final DailyProgram program;
  final int day;

  const DayCard({
    Key? key,
    required this.program,
    required this.day,
  }) : super(key: key);

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  double _offset = 0;

  void scrollListener(double offset) {
    setState(() {
      _offset = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.tint1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 13.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardHeader(
                    title: widget.program.title,
                    subtitle: widget.program.subtitle,
                  ),
                  if (!widget.program.isRestDay)
                    SmoothIndicator(
                      offset: _offset,
                      count: widget.program.blocs.length,
                      effect: const WormEffect(
                        activeDotColor: Palette.accent,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                ],
              ),
            ),
            if (!widget.program.isRestDay) const Separator(indent: 8),
            if (!widget.program.isRestDay)
              CardCarousel(
                blocs: widget.program.blocs,
                scrollListener: scrollListener,
              ),
            const Separator(indent: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: widget.program.isRestDay
                  ? Text(
                      widget.program.text.toString(),
                      style: const TextStyle(
                        fontFamily: Fonts.primaryRegular,
                        fontSize: 14.0,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CommentsScreen.route,
                          arguments: {
                            "day": widget.day,
                            "number": widget.program.comments,
                          },
                        );
                      },
                      child: Comments(number: widget.program.comments),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
