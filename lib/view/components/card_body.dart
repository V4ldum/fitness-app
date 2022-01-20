import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  const CardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Divider(),
        Text.rich(
          TextSpan(
            text: "Bloc I",
            style: kPreviewBlocTitleTextStyle,
            children: [
              TextSpan(
                text: " - 4 Séries - 2' Repos",
                style: kPreviewBlocSubtitleTextStyle,
              )
            ],
          ),
        ),
        Text("\t\tPower Clean Squat + Thruster x4",
            style: kPreviewBlocContentTextStyle),
        Text("\t\tToes to Bar x6-10", style: kPreviewBlocContentTextStyle),
        Divider(),
        Text.rich(
          TextSpan(
            text: "Bloc II",
            style: kPreviewBlocTitleTextStyle,
            children: [
              TextSpan(
                text: " - 4 Séries - 1' Repos",
                style: kPreviewBlocSubtitleTextStyle,
              )
            ],
          ),
        ),
        Text("\t\tRomanian Deadlift x25", style: kPreviewBlocContentTextStyle),
        Divider(),
        Text.rich(
          TextSpan(
            text: "Bloc III",
            style: kPreviewBlocTitleTextStyle,
            children: [
              TextSpan(
                text: " - 5 Séries For Time - 8'",
                style: kPreviewBlocSubtitleTextStyle,
              )
            ],
          ),
        ),
        Text("\t\tGoblet Squat x10", style: kPreviewBlocContentTextStyle),
        Text("\t\tSwing x10", style: kPreviewBlocContentTextStyle),
        Text("\t\tGoblet Walk x50pas", style: kPreviewBlocContentTextStyle),
        Text("\t\tAbdos x20", style: kPreviewBlocContentTextStyle),
      ],
    );
  }
}
