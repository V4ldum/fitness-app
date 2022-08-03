import 'package:fitness_app/config/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain.dart';

class StopwatchService implements StopwatchRepository {
  @override
  Future<bool?> getSoundSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(Strings.isMutedKey);
  }

  @override
  void saveSoundSettings(bool value) {
    SharedPreferences.getInstance()
        .then((pref) => pref.setBool(Strings.isMutedKey, value));
  }
}
