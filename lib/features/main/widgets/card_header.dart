import 'package:flutter/widgets.dart';

import 'card_subtitle.dart';
import 'card_title.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const CardHeader({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title),
        CardSubtitle(subtitle),
      ],
    );
  }
}
