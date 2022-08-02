import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/providers/app_wide_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class Message extends StatelessWidget {
  final int? commentId;
  final String username;
  final String displayName;
  final String hour;
  final String message;
  final bool isSentByMe;
  final int? repliesNumber;

  const Message({
    Key? key,
    this.commentId,
    required this.username,
    required this.displayName,
    required this.hour,
    required this.message,
    required this.isSentByMe,
    this.repliesNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              bottom: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (repliesNumber != null)
                    CommentModalBottomSheetButton(
                      icon: Icons.reply,
                      label: Strings.replyTextButton,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          RepliesScreen.route,
                          arguments: {
                            "commentId": commentId!,
                            "number": repliesNumber!,
                          },
                        );
                      },
                    ),
                  CommentModalBottomSheetButton(
                    icon: Icons.copy,
                    label: Strings.copyTextButton,
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: message));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isSentByMe)
              MessageAvatar(
                imageUrl:
                    "${Strings.apiProtocol}${Strings.apiHost}${Strings.apiUserPath}/$username${Strings.apiPicturePath}?token=${context.read<AppWideProvider>().accessToken}",
              ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MessageBubble(
                  displayName: displayName,
                  hour: hour,
                  message: message,
                  isSentByMe: isSentByMe,
                ),
                if (repliesNumber != null && repliesNumber! >= 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RepliesScreen.route,
                          arguments: {
                            "commentId": commentId!,
                            "number": repliesNumber!,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "$repliesNumber ${Strings.appBarReplies}"
                              .toUpperCase(),
                          style: const TextStyle(
                            fontFamily: Fonts.secondaryRegular,
                            color: Palette.accent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 5),
            if (isSentByMe)
              MessageAvatar(
                imageUrl:
                    "${Strings.apiProtocol}${Strings.apiHost}${Strings.apiUserPath}${Strings.apiPicturePath}?token=${context.read<AppWideProvider>().accessToken}",
              ),
          ],
        ),
      ),
    );
  }
}
