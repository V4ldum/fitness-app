import 'package:fitness_app/config/images.dart';
import 'package:flutter/material.dart';

class MessageAvatar extends StatelessWidget {
  final String imageUrl;

  const MessageAvatar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: const AssetImage(Images.profilePicturePlaceholder),
      foregroundImage: NetworkImage(imageUrl),
      onForegroundImageError: (_, __) {
        debugPrint("[x] Comments Avatar: Error");
      },
    );
  }
}
