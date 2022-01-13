import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitness_app/utils/api.dart';
import 'package:fitness_app/constants.dart';

abstract class LoginManager {
  static _emulateNetwork() {
    sleep(const Duration(seconds: 1));
  }

  static Future<bool> openForgottenPasswordPage() async {
    _emulateNetwork();
    if (!await launch(kForgottenPasswordUrlString)) {
      return false;
    }
    return true;
  }

  static Future<bool> login(String username, String password) async {
    _emulateNetwork();
    if (username == "" || password == "") {
      return false;
    }
    return API.findUser(username, password);
  }

  static Future<bool> openRegistrationPage() async {
    _emulateNetwork();
    if (!await launch(kCreateAccountUrlString)) {
      return false;
    }
    return true;
  }
}
