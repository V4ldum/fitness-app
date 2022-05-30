import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/shared/helpers/network.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repository/login_repository.dart';

class LoginService implements LoginRepository {
  @override
  Future<bool> login(String username, String password) async {
    // TODO: Real API call
    await Network.emulate();
    return username == "test" && password == "test";
  }

  @override
  Future<bool> openForgottenPasswordPage() async {
    await Network.emulate();
    return await launchUrl(Uri.https(
        Strings.forgottenPasswordHost, Strings.forgottenPasswordPath));
  }

  @override
  Future<bool> openRegistrationPage() async {
    await Network.emulate();
    return await launchUrl(
        Uri.https(Strings.createAccountHost, Strings.createAccountPath));
  }
}
