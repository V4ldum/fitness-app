import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  final DateTime date;

  const DateHeader({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DecoratedBox(
        decoration: const BoxDecoration(
            color: Palette.primary,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 9.0),
          child: Text(
            DateFormat.yMMMd().format(date),
            style: const TextStyle(
              fontFamily: Fonts.primaryRegular,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
