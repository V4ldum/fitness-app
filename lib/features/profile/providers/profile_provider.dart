import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

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

    //_profile = out[0] as Profile;
    _notificationSelectedItem = Notifications.values
        .firstWhere(
          (e) => e.name == out,
          orElse: () => Notifications.Toutes,
        )
        .index;

    _changeLoadingStateProfile();
  }

  Future<bool> openMyAccountPage() async {
    _changeLoadingStateExternal();
    bool out = await _service.openMyAccount();
    _changeLoadingStateExternal();

    return out;
  }

  void openAppSettings() async {
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
    print("update image");
  }
}
