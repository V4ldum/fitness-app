import 'package:app_settings/app_settings.dart';
import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/shared/helpers/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repository/profile_repository.dart';

class ProfileService implements ProfileRepository {
  @override
  Future<void> openAppSettings() {
    return AppSettings.openAppSettings();
  }

  @override
  Future<bool> openMyAccount() async {
    await Network.emulate();
    return await launchUrl(
        Uri.https(Strings.myAccountHost, Strings.myAccountPath));
  }

  @override
  void saveSetting(String key, String value) {
    SharedPreferences.getInstance().then((pref) => pref.setString(key, value));
  }

  @override
  Future<String?> getSetting(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  @override
  void removeSetting(String key) {
    SharedPreferences.getInstance().then((pref) => pref.remove(key));
  }

  @override
  void updateImage() {
    // TODO: implement updateImage
    print("Update image");
  }
}
//TODO json version
/*
static Future<Map> profile() async {
    //emulate API call
    return json.decode(await rootBundle.loadString('assets/profile.json'));
  }
*/

/*

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

 */
