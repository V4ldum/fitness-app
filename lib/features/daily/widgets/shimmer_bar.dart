import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBar extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerBar({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: const BorderRadius.all(
            Radius.circular(3.0),
          ),
        ),
      ),
    );
  }
}
