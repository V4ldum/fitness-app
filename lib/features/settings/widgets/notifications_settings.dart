import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/models/notification_type.dart';
import '../providers/settings.dart';
import 'widgets.dart';

class NotificationsSettings extends StatelessWidget {
  const NotificationsSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsTitle(title: "Notifications"),
        const SizedBox(height: 10.0),
        Consumer<Settings>(builder: (context, settings, _) {
          return CheckboxTile(
            label: "\tToutes",
            isChecked: settings.notifications == Notifications.all,
            onChanged: (value) {
              if (value!) {
                settings.notifications = Notifications.all;
              }
            },
          );
        }),
        Consumer<Settings>(builder: (context, settings, _) {
          return CheckboxTile(
            label: "\tSeulement les programmes",
            isChecked: settings.notifications == Notifications.programs,
            onChanged: (value) {
              if (value!) {
                settings.notifications = Notifications.programs;
              }
            },
          );
        }),
        Consumer<Settings>(builder: (context, settings, _) {
          return CheckboxTile(
            label: "\tAucune",
            isChecked: settings.notifications == Notifications.none,
            onChanged: (value) {
              if (value!) {
                settings.notifications = Notifications.none;
              }
            },
          );
        }),
      ],
    );
  }
}
