import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/providers/app_wide_provider.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/shared/widgets/alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/domain.dart';

class ProfileProvider extends ChangeNotifier {
  late final ProfileRepository _service;

  int _notificationSelectedItem = 0;

  bool _isLoadingExternal = false;
  bool _isLoadingProfile = false;

  ProfileProvider() {
    _service = ProfileService();
    _loadProfile();
  }

  ProfileProvider.fromService(ProfileRepository ps) {
    _service = ps;
    _loadProfile();
  }

  bool get isLoadingExternal => _isLoadingExternal;
  bool get isLoadingProfile => _isLoadingProfile;

  int get notificationSelectedItem => _notificationSelectedItem;

  set notificationSelectedItem(int value) {
    _notificationSelectedItem = value;
    notifyListeners();
  }

  void _changeLoadingStateExternal() {
    _isLoadingExternal = !_isLoadingExternal;
    notifyListeners();
  }

  void _changeLoadingStateProfile() {
    _isLoadingProfile = !_isLoadingProfile;
    notifyListeners();
  }

  void _loadProfile() async {
    _changeLoadingStateProfile();

    String? out = await _service.getSetting(Strings.notificationSettingKey);

    _notificationSelectedItem = Notifications.values
        .firstWhere(
          (e) => e.name == out,
          orElse: () => Notifications.Toutes,
        )
        .index;

    _changeLoadingStateProfile();
  }

  void _openAlert(BuildContext context) {
    PopupAlert.open(
      context: context,
      desc: Strings.logOutMessage,
      buttons: [
        AlertButton(
          text: Strings.logOutDeny,
          onPressed: () => Navigator.pop(context),
        ),
        AlertButton(
          text: Strings.logOutAccept,
          onPressed: () {
            context.read<AppWideProvider>().deleteTokens();
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.route,
              (_) => false,
            );
          },
        ),
      ],
    ).show();
  }

  Future<bool> openMyAccountPage() async {
    _changeLoadingStateExternal();
    bool out = await _service.openMyAccount();
    _changeLoadingStateExternal();

    return out;
  }

  Future<void> openAppSettings() async {
    _changeLoadingStateExternal();
    await _service.openAppSettings();
    _changeLoadingStateExternal();
  }

  void saveSetting(String key, String value) {
    _service.saveSetting(key, value);
  }

  Future<String?> getSetting(String key) async {
    return await _service.getSetting(key);
  }

  void removeSetting(String key) {
    _service.removeSetting(key);
  }

  void updateImage() {
    // TODO: implement updateImage
    print("Not Implemented");
  }

  void onLogOutButtonPressed(BuildContext context) {
    _openAlert(context);
  }

  void onNotificationOptionChanged(Notifications value) {
    notificationSelectedItem = value.index;
    saveSetting(
      Strings.notificationSettingKey,
      value.name,
    );
  }
}
