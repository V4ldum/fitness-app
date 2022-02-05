import 'package:fitness_app/constants.dart';
import 'package:fitness_app/model/daily_program.dart';
import 'package:fitness_app/view/components/card_body.dart';
import 'package:fitness_app/view/screens/preview_screen.dart';
import 'package:flutter/material.dart';

class DayCard extends StatefulWidget {
  final DailyProgram program;

  const DayCard({
    Key? key,
    required this.program,
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
      duration: const Duration(milliseconds: 300),
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
    Future.delayed(const Duration(milliseconds: 275), () {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        color: kTintDarkColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.program.title,
                            style: kPreviewTitleTextStyle),
                        Text(widget.program.subtitle,
                            style: kPreviewSubtitleTextStyle),
                      ],
                    ),
                  ),
                  widget.program.isRestDay
                      ? const SizedBox()
                      : TextButton(
                          style: kProgramButtonTextStyle,
                          onPressed: () {
                            widget.program.startProgram();
                            Navigator.pushNamed(
                              context,
                              PreviewScreen.route,
                              arguments: [widget.program],
                            );
                          },
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: kTintDarkColor,
                            size: 30.0,
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: SizeTransition(
                axisAlignment: -1.0, //align top
                sizeFactor: _animation,
                child: CardBody(blocs: widget.program.blocs),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                left: 15.0,
                right: 15.0,
              ),
              child: widget.program.isRestDay
                  ? Column(
                      children: [
                        const Divider(color: kTintDarkColor),
                        Text(widget.program.text,
                            style: kPreviewBlocContentTextStyle),
                      ],
                    )
                  : SizedBox(
                      height: 25.0,
                      child: TextButton(
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
