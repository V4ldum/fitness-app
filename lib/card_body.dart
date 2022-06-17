import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

import 'features/main/domain/models/bloc.dart';
import 'features/main/domain/models/exercise.dart';

class CardBody extends StatelessWidget {
  final List<Bloc> blocs;

  const CardBody({
    Key? key,
    this.blocs = const [],
  }) : super(key: key);

  List<Widget> _cardBodyContent() {
    List<Widget> out = [];

    for (int i = 0; i < blocs.length; i++) {
      out.add(const Divider(color: Palette.tint1));
      out.add(
        Text.rich(
          TextSpan(
            text: "Bloc ${'I' * (i + 1)}", //only I -> III
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            children: [
              TextSpan(
                text: " - ${blocs[i]}",
                style: const TextStyle(
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0,
                ),
              )
            ],
          ),
        ),
      );
      for (Exercise e in blocs[i].exercises) {
        out.add(
          Text("\t\t$e",
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.0,
              )),
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
