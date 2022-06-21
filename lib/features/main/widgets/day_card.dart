import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/comments/screens/comments_screen.dart';
import 'package:fitness_app/features/daily/day_screen.dart';
import 'package:fitness_app/shared/widgets/separator.dart';
import 'package:flutter/material.dart';

import '../domain/models/daily_program.dart';
import 'card_button.dart';
import 'card_header.dart';
import 'comments.dart';

class DayCard extends StatelessWidget {
  final DailyProgram program;

  const DayCard({
    Key? key,
    required this.program,
  }) : super(key: key);

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
                  child: CardHeader(
                    title: program.title,
                    subtitle: program.subtitle,
                  ),
                ),
                program.isRestDay
                    ? const SizedBox()
                    : CardButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            DayScreen.route,
                            arguments: [
                              program,
                            ],
                          );
                        },
                      ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: program.isRestDay
                      ? const SizedBox(height: 5)
                      : const Separator(indent: 8),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: program.isRestDay
                      ? Text(
                          program.text.toString(),
                          style: const TextStyle(
                            fontFamily: Fonts.primaryRegular,
                            fontSize: 14.0,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, CommentsScreen.route);
                          },
                          child: const Comments(),
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
