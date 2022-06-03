import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/profile/widgets/option_selector.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Strings.parametersTitle.toUpperCase(),
          style: const TextStyle(
            fontFamily: Fonts.primarySemiBold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 10.0),
        SettingsButton(
          leading: Icons.account_box,
          text: Strings.myAccountButton,
          trailing: Icons.outbond_outlined,
          onTap: () {
            print("Navigation"); //TODO fonction
          },
        ),
        const SizedBox(height: 15.0),
        const ProfileCard(
          child: OptionSelector(
            label: Strings.notificationsSettings,
            options: [
              Strings.notificationOption1,
              Strings.notificationOption2,
              Strings.notificationOption3,
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        //TODO check iOS
        SettingsButton(
          leading: Icons.app_settings_alt_rounded,
          text: Strings.deviceSettingsButton,
          trailing: Icons.outbond_outlined,
          onTap: () {
            print("Navigation"); //TODO fonction
          },
        )
      ],
    );
  }
}
