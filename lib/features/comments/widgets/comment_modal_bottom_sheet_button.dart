import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class CommentModalBottomSheetButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;

  const CommentModalBottomSheetButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(width: 30),
            Text(
              label,
              style: const TextStyle(
                fontFamily: Fonts.primaryMedium,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
