abstract class ProfileRepository {
  const ProfileRepository();

  Future<bool> openMyAccount();
  Future<void> openAppSettings();

  void saveSetting(String key, String value);
  Future<String?> getSetting(String key);
  void removeSetting(String key);

  void updateImage();
}
