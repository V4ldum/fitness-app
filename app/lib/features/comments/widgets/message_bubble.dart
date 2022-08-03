import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String displayName;
  final String hour;
  final String message;
  final bool isSentByMe;

  const MessageBubble({
    Key? key,
    required this.displayName,
    required this.hour,
    required this.message,
    required this.isSentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSentByMe ? Palette.accent2 : Palette.tint1,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0),
          bottomLeft: isSentByMe ? const Radius.circular(10.0) : Radius.zero,
          bottomRight: isSentByMe ? Radius.zero : const Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontFamily: Fonts.primaryRegular,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    hour,
                    style: const TextStyle(
                      fontFamily: Fonts.secondaryRegular,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.72,
                ),
                child: Text(message),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
