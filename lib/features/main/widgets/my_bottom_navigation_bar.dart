import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final Map<Permission, IconData Function()> _iconSwitcher = {
    Permission.Daily: () => Icons.lock_clock,
    Permission.Other: () => Icons.question_mark,
  };

  final int selectedIndex;
  final Function(int)? onTap;

  MyBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read<AppWideProvider>().user;

    if (user == null || user.permissions.length <= 1) {
      return const SizedBox();
    }
    return BottomNavigationBar(
      backgroundColor: Palette.tint1,
      selectedItemColor: Palette.accent,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        for (var item in user.permissions)
          BottomNavigationBarItem(
            label: describeEnum(item),
            icon: Icon(_iconSwitcher[item]?.call() ?? Icons.question_mark),
          ),
      ],
    );
  }
}
