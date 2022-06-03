import 'package:flutter/widgets.dart';

import 'big_avatar.dart';
import 'profile_name.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  //TODO profile.json
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        BigAvatar(image: 'assets/strong_cat.png'),
        SizedBox(height: 15.0),
        ProfileName(name: "Cat Bumstead"),
      ],
    );
  }
}
