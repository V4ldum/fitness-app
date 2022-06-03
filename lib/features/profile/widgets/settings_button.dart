import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final IconData? leading;
  final IconData? trailing;
  final String text;
  final Function()? onTap;

  const SettingsButton({
    Key? key,
    this.leading,
    this.trailing,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Palette.tint1,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      if (leading != null) Icon(leading),
                      if (leading != null) const SizedBox(width: 8.0),
                      Text(
                        text,
                        style: const TextStyle(
                          fontFamily: Fonts.primaryRegular,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(trailing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
