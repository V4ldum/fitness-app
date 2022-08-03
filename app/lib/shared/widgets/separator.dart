import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double indent;

  const Separator({
    Key? key,
    this.indent = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      thickness: 0.6,
      indent: indent,
      endIndent: indent,
    );
  }
}
