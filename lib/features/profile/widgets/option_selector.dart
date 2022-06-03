import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OptionSelector extends StatefulWidget {
  final String label;
  final List<String> options;

  const OptionSelector({
    Key? key,
    required this.label,
    required this.options,
  }) : super(key: key);

  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  int selectedItem = 1;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildOptions() {
    List<Widget> out = [];

    for (int i = 0; i < widget.options.length; i++) {
      out.add(
        OptionSelectorTile(
          label: widget.options[i],
          enabled: selectedItem == i ? true : false,
          onTap: () {
            setState(() {
              selectedItem = i;
            });
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
          widget.label,
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
            children: buildOptions(),
          ),
        )
      ],
    );
  }
}
