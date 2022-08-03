import 'package:fitness_app/config/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OptionSelectorTile<T> extends StatelessWidget {
  final T label;
  final bool enabled;
  final Function()? onTap;

  const OptionSelectorTile({
    Key? key,
    required this.label,
    required this.enabled,
    this.onTap,
  })  : assert(label is Enum),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            describeEnum(label!),
            style: const TextStyle(
              fontFamily: Fonts.primaryRegular,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            activeColor: Palette.accent,
            checkColor: Palette.accent,
            value: enabled,
            onChanged: (state) {
              if (onTap != null) onTap!();
            },
          ),
        ],
      ),
    );
  }
}
