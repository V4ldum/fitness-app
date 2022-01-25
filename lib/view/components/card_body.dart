import 'package:fitness_app/constants.dart';
import 'package:fitness_app/model/bloc.dart';
import 'package:fitness_app/model/exercise.dart';
import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  final List<Bloc> blocs;

  const CardBody({
    Key? key,
    this.blocs = const [],
  }) : super(key: key);

  List<Widget> _cardBodyContent() {
    List<Widget> out = [];

    for (int i = 0; i < blocs.length; i++) {
      out.add(const Divider(color: kTintDarkColor));
      out.add(
        Text.rich(
          TextSpan(
            text: "Bloc ${'I' * (i + 1)}", //only I -> III
            style: kPreviewBlocTitleTextStyle,
            children: [
              TextSpan(
                text: " - ${blocs[i]}",
                style: kPreviewBlocSubtitleTextStyle,
              )
            ],
          ),
        ),
      );
      for (Exercise e in blocs[i].exercises) {
        out.add(
          Text("\t\t$e", style: kPreviewBlocContentTextStyle),
        );
      }
    }

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _cardBodyContent(),
    );
  }
}

/*
const [
        Divider(color: kTintDarkColor),
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
        Divider(color: kTintDarkColor),
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
        Divider(color: kTintDarkColor),
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
 */
