import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:fitness_app/features/comments/index.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessagesList<T extends IMessage> extends StatefulWidget {
  final List<T> elements;

  const MessagesList({
    Key? key,
    required this.elements,
  }) : super(key: key);

  @override
  State<MessagesList<T>> createState() => _MessagesListState<T>();
}

class _MessagesListState<T extends IMessage> extends State<MessagesList<T>> {
  final ScrollController _controller = ScrollController();
  double _buttonScale = 0.8;
  double _buttonOpacity = 0;
  final Duration _animationsDuration = const Duration(milliseconds: 180);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.hasClients && _controller.offset > 500) {
        setState(() {
          _buttonOpacity = 1;
          _buttonScale = 1;
        });
      }
      if (_controller.hasClients && _controller.offset <= 10) {
        setState(() {
          _buttonOpacity = 0;
          _buttonScale = 0.8;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GroupedListView<T, DateTime>(
          controller: _controller,
          reverse: true,
          order: GroupedListOrder.DESC,
          elements: widget.elements,
          groupBy: (T element) => DateTime(
            element.date.year,
            element.date.month,
            element.date.day,
          ),
          itemBuilder: (context, T element) => Message(
            commentId:
                element.runtimeType == Comment ? (element as Comment).id : null,
            username: element.username,
            displayName: element.userDisplayName,
            hour: DateFormat.Hm().format(element.date),
            message: element.message,
            isSentByMe: element.username ==
                context.read<AppWideProvider>().user?.username,
            repliesNumber: (element.runtimeType == Comment)
                ? (element as Comment).nbReplies
                : null,
          ),
          groupHeaderBuilder: (T element) => Align(
            alignment: Alignment.topCenter,
            child: DateHeader(date: element.date),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: AnimatedOpacity(
            opacity: _buttonOpacity,
            duration: _animationsDuration,
            child: AnimatedScale(
              scale: _buttonScale,
              duration: _animationsDuration,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: ClipOval(
                  child: Material(
                    color: Palette.tint1,
                    child: IconButton(
                      color: Palette.accent,
                      iconSize: 28,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        if (_controller.hasClients) {
                          _controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
