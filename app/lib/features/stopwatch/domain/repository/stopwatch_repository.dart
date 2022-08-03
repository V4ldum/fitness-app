abstract class StopwatchRepository {
  Future<bool?> getSoundSettings();
  void saveSoundSettings(bool value);
}
