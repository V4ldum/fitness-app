import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Widget? child;

  const ProfileCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.tint1,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}
