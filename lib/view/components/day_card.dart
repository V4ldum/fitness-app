import 'package:fitness_app/constants.dart';
import 'package:fitness_app/view/components/card_body.dart';
import 'package:flutter/material.dart';

class DayCard extends StatefulWidget {
  const DayCard({
    Key? key,
  }) : super(key: key);

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  void _prepareAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  void _changeExpansionState() {
    if (_isVisible) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    Future.delayed(const Duration(milliseconds: 475), () {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kTintDarkColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lundi", style: kPreviewTitleTextStyle),
                    const Text("Lower Body", style: kPreviewSubtitleTextStyle),
                    SizeTransition(
                      axisAlignment: -1.0, //align top
                      sizeFactor: _animation,
                      child: const CardBody(),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_rounded, //TODO bouton play
                  color: kPrimaryColor,
                  size: 30.0,
                )
              ],
            ),
            TextButton(
              onPressed: () {
                setState(_changeExpansionState);
              },
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                _isVisible
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
