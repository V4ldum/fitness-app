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
      children: [
        BigAvatar(
          image: "", //TODO //context.watch<ProfileProvider>().imageUrl,
          onPressEditButton: () {
            //context.read<ProfileProvider>().updateImage();
          },
        ),
        const SizedBox(height: 15.0),
        const ProfileName(
          name: "", //context.watch<ProfileProvider>().name,
        ), //TODO
      ],
    );
  }
}
