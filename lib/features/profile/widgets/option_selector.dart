import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OptionSelector<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final int selectedItem;
  final void Function(T)? onOptionChanged;

  const OptionSelector({
    Key? key,
    required this.label,
    required this.options,
    this.selectedItem = 0,
    this.onOptionChanged,
  })  : assert(selectedItem < options.length),
        super(key: key);

  List<Widget> buildOptions(BuildContext context) {
    List<Widget> out = [];

    for (int i = 0; i < options.length; i++) {
      out.add(
        OptionSelectorTile(
          label: options[i],
          enabled: selectedItem == i ? true : false,
          onTap: () {
            if (onOptionChanged != null && selectedItem != i) {
              onOptionChanged!(options[i]);
            }
          },
        ),
      );
    }

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: Fonts.primarySemiBold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildOptions(context),
          ),
        )
      ],
    );
  }
}
