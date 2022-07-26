import 'package:fitness_app/config/colors.dart';
import 'package:fitness_app/features/stopwatch/screens/main_clock_screen.dart';
import 'package:fitness_app/features/video_player/screens/preview_screen.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class BlocCard extends StatelessWidget {
  final int blocNumber;
  final Bloc bloc;

  const BlocCard({
    Key? key,
    required this.blocNumber,
    required this.bloc,
  }) : super(key: key);

  List<Widget> _exercises(Bloc bloc) {
    List<Widget> out = [];

    for (Exercise e in bloc.exercises) {
      out.add(
        Text(
          e.toString(),
          style: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 15.0,
          ),
        ),
      );
      out.add(const SizedBox(height: 5.0));
    }

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 5.0,
        top: 5,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bloc ${'I' * blocNumber}", //only I -> III
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      bloc.toString(),
                      style: const TextStyle(
                        fontFamily: 'Abel',
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Palette.accent,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PreviewScreen.route,
                        arguments: bloc.videoAsset,
                      );
                    },
                  ),
                  const SizedBox(width: 5.0),
                  IconButton(
                    icon: const Icon(
                      Icons.timer,
                      color: Palette.accent,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        MainClockScreen.route,
                        arguments: bloc,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _exercises(bloc),
              ),
            ),
          )
        ],
      ),
    );
  }
}
