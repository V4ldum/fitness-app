import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/notification_type.dart';
import '../domain/models/settings_key.dart';

class Settings extends ChangeNotifier {
  late SharedPreferences _prefs;

  Notifications _notifications = Notifications.all;

  Settings() {
    _init();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _init() async {
    await _initPrefs();

    _notifications = Notifications
        .values[_prefs.getInt(SettingsKey.notifications.toString())!];
    notifyListeners();
  }

  Notifications get notifications => _notifications;
  set notifications(Notifications n) {
    _notifications = n;
    writeNotification(n);

    notifyListeners();
  }

  Future<void> writeNotification(Notifications n) async {
    _prefs.setInt(SettingsKey.notifications.toString(), n.index);
  }
}
