import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isTransparent;
  final Widget? leading;
  final Widget? trailing;

  const MyAppBar({
    Key? key,
    required this.title,
    this.isTransparent = false,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isTransparent ? Colors.transparent : Palette.tint1,
      elevation: isTransparent ? 0 : 4,
      centerTitle: true,
      leading: leading,
      actions: trailing != null ? [trailing!] : [],
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: Fonts.primaryRegular,
          color: Colors.white,
        ),
      ),
    );
  }
}
