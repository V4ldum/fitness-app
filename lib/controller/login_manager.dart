import 'package:fitness_app/constants.dart';
import 'package:fitness_app/utils/api.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class LoginManager {
  static Future<void> _emulateNetwork() async {
    return Future.delayed(const Duration(seconds: 2));
  }

  static Future<bool> openForgottenPasswordPage() async {
    await _emulateNetwork();
    if (!await launch(kForgottenPasswordUrlString)) {
      return false;
    }
    return true;
  }

  static Future<bool> login(String username, String password) async {
    await _emulateNetwork();
    if (username == "" || password == "") {
      return false;
    }
    return API.findUser(username, password);
  }

  static Future<bool> openRegistrationPage() async {
    await _emulateNetwork();
    if (!await launch(kCreateAccountUrlString)) {
      return false;
    }
    return true;
  }
}
