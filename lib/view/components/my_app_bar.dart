import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kTintDarkColor,
      centerTitle: true,
      leading: const Image(
        image: AssetImage("assets/logo-small.png"),
      ),
      title: Text(
        title,
        style: kAppBarTextStyle,
      ),
    );
  }
}
