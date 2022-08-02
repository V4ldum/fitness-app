import 'dart:math';

import 'package:fitness_app/shared/widgets/shimmer_bar.dart';
import 'package:flutter/material.dart';

class ShimmerMessage extends StatelessWidget {
  // width between X and Y
  final double width =
      Random(DateTime.now().microsecondsSinceEpoch).nextInt(200) + 70.0;
  // height between X and Y
  final double height =
      Random(DateTime.now().microsecondsSinceEpoch).nextInt(70) + 50.0;
  final bool isSentByMe =
      Random(DateTime.now().microsecondsSinceEpoch).nextInt(7) == 1;

  ShimmerMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        //Avatar
        if (!isSentByMe)
          const ClipOval(
            child: ShimmerBar(width: 40, height: 40),
          ),
        const SizedBox(width: 8),
        //Message Bubble
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72),
          child: ShimmerBar(width: width, height: height),
        ),
        const SizedBox(width: 8),
        //Avatar
        if (isSentByMe)
          const ClipOval(
            child: ShimmerBar(width: 40, height: 40),
          ),
      ],
    );
  }
}
