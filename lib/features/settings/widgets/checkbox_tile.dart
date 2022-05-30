import 'package:fitness_app/features/settings/widgets/checkbox_tile_check.dart';
import 'package:flutter/widgets.dart';

import 'checkbox_tile_label.dart';

class CheckboxTile extends StatelessWidget {
  final String label;
  final bool isChecked;
  final Function(bool?)? onChanged;

  const CheckboxTile({
    Key? key,
    required this.label,
    required this.isChecked,
    this.onChanged,
  }) : super(key: key);

  //TODO profile.json
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CheckboxTileLabel(label: label),
        CheckboxTileCheck(
          isChecked: isChecked,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
