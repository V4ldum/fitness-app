import 'package:flutter/material.dart';

import 'widgets.dart';

class ShimmerMessageList extends StatelessWidget {
  const ShimmerMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return Column(
          children: [
            ShimmerMessage(),
          ],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 15),
    );
  }
}
