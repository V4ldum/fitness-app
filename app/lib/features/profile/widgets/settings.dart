import 'dart:io';

import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/domain.dart';
import '../providers/profile_provider.dart';
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
          onTap: () async {
            await context.read<ProfileProvider>().openMyAccountPage();
          },
        ),
        const SizedBox(height: 15.0),
        ProfileCard(
          child: Consumer<ProfileProvider>(
            builder: (_, provider, __) {
              return OptionSelector<Notifications>(
                label: Strings.notificationsSettings,
                options: const [
                  Notifications.Toutes,
                  Notifications.Programmes,
                  Notifications.Aucune,
                ],
                selectedItem: provider.notificationSelectedItem,
                onOptionChanged: provider.onNotificationOptionChanged,
              );
            },
          ),
        ),
        const SizedBox(height: 15.0),
        if (Platform.isAndroid)
          SettingsButton(
            leading: Icons.app_settings_alt_rounded,
            text: Strings.deviceSettingsButton,
            trailing: Icons.outbond_outlined,
            onTap: () {
              context.read<ProfileProvider>().openAppSettings();
            },
          )
      ],
    );
  }
}
