import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'big_avatar.dart';
import 'profile_name.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigAvatar(
          image:
              "http://${Strings.apiHost}${Strings.apiUserPath}${Strings.apiPicturePath}?token=${context.read<AppWideProvider>().accessToken}",
          onPressEditButton: () {
            context.read<ProfileProvider>().updateImage();
          },
        ),
        const SizedBox(height: 15.0),
        ProfileName(
          name: context.read<AppWideProvider>().user?.fullName ?? "",
        ),
      ],
    );
  }
}
