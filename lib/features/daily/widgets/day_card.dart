import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/social/screens/comments_screen.dart';
import 'package:fitness_app/features/video_player/screens/preview_screen.dart';
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
                          program.startProgram();
                          Navigator.pushNamed(
                            context,
                            PreviewScreen.route,
                            arguments: [
                              program.blocs[0].videoAsset
                            ], //TODO convertir pour Day
                          );
                        },
                      ),
              ],
            ),
            program.isRestDay
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Separator(indent: 8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GestureDetector(
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
