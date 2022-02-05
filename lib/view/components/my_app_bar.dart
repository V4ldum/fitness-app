import 'package:fitness_app/constants.dart';
import 'package:fitness_app/view/screens/clock_screen.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool pop;

  const MyAppBar({
    Key? key,
    required this.title,
    this.pop = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: pop ? Colors.transparent : kTintDarkColor,
      elevation: pop ? 0 : 4,
      centerTitle: true,
      actions: pop
          ? [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, ClockScreen.route);
                },
                icon: const Text(
                  "GO",
                  style: TextStyle(
                    fontFamily: "Abel",
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]
          : const [],
      leading: pop
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
              ),
            )
          : const Image(
              image: AssetImage("assets/logo-small.png"),
            ),
      title: Text(
        title,
        style: kAppBarTextStyle,
      ),
    );
  }
}
