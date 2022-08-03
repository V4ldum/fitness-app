import 'package:flutter/material.dart';

import '../index.dart';

class CardCarousel extends StatelessWidget {
  final List<Bloc> blocs;
  final ScrollController _controller = ScrollController();
  final Function(double)? scrollListener;

  CardCarousel({
    Key? key,
    required this.blocs,
    this.scrollListener,
  }) : super(key: key) {
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    // The current offset in pixels
    double offset = _controller.offset;

    // To fix some potential quirks with bouncing scroll like on iOS
    if (offset < 0) {
      offset = 0;
    } else if (offset > _controller.position.maxScrollExtent) {
      offset = _controller.position.maxScrollExtent;
    }

    // controller.position.maxScrollExtent = total width of carousel including out of screen elements
    // unitOffset = offset to go to the following page
    double unitOffset =
        _controller.position.maxScrollExtent / (blocs.length - 1);

    // this is the index of the current page
    double index = offset / unitOffset;

    if (scrollListener != null) scrollListener!(index);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        controller: _controller,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < blocs.length; i++)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BlocCard(
                    blocNumber: i + 1,
                    bloc: blocs[i],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
