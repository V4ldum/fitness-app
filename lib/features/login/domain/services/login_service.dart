import 'dart:convert';
import 'dart:io';

import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/app_wide/domain/domain.dart';
import 'package:fitness_app/shared/helpers/network.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../repository/login_repository.dart';

class LoginService implements LoginRepository {
  // 404 -> erreur de connexion
  // 401 -> mauvais username/password
  // 200 -> ok
  @override
  Future<APIResponse<Map<String, Object>>> login(
      String username, String password) async {
    final http.Response response;

    try {
      response = await http.get(Uri.http(
        Strings.apiHost,
        Strings.apiAuthPath,
        {
          "username": username,
          "password": password,
        },
      ));
    } on SocketException {
      // API Down
      return APIResponse<Map<String, Object>>(APICode.notfound, null);
    }

    Map<int, Function()> switcher = {
      200: () {
        var decoded = jsonDecode(response.body);
        AppWideService()
            .updateTokens(decoded["access_token"], decoded["refresh_token"]);
        return APIResponse<Map<String, Object>>(APICode.ok, {
          "user": User.fromJson(decoded["result"]),
          "access_token": decoded["access_token"],
          "refresh_token": decoded["refresh_token"],
        });
      },
      401: () => APIResponse<Map<String, Object>>(APICode.unauthorized, null),
      404: () => APIResponse<Map<String, Object>>(APICode.notfound, null),
    };

    return switcher[response.statusCode]!();
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
