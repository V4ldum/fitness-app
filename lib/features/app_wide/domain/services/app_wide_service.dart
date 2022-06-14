import 'dart:convert';
import 'dart:io';

import 'package:fitness_app/config/index.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../domain.dart';

class AppWideService implements AppWideRepository {
  @override
  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Strings.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Strings.refreshTokenKey);
  }

  @override
  Future<void> updateTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(Strings.accessTokenKey, accessToken);
    prefs.setString(Strings.refreshTokenKey, refreshToken);
  }

  @override
  Future<void> deleteTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(Strings.accessTokenKey);
    prefs.remove(Strings.refreshTokenKey);
  }

  @override
  Future<APIResponse<User>> authenticate(String accessToken) async {
    final http.Response response;

    try {
      response =
          await http.get(Uri.http(Strings.apiHost, Strings.apiAccessPath, {
        "token": accessToken,
      }));
    } on SocketException {
      // API Down
      return APIResponse<User>(APICode.notfound, null);
    }

    Map<int, Function()> switcher = {
      200: () => APIResponse<User>(
          APICode.ok, User.fromJson(jsonDecode(response.body)["result"])),
      401: () => APIResponse<User>(APICode.unauthorized, null),
      404: () => APIResponse<User>(APICode.notfound, null),
    };

    return switcher[response.statusCode]!();
  }

  @override
  Future<APIResponse<Map<String, String>>> refresh(String refreshToken) async {
    final http.Response response;

    try {
      response =
          await http.get(Uri.http(Strings.apiHost, Strings.apiAccessPath, {
        "token": refreshToken,
      }));
    } on SocketException {
      // API Down
      return APIResponse<Map<String, String>>(APICode.notfound, null);
    }

    Map<int, Function()> switcher = {
      200: () => APIResponse<Map<String, String>>(
            APICode.ok,
            {
              "access_token": jsonDecode(response.body)["access_token"],
              "refresh_token": jsonDecode(response.body)["refresh_token"],
            },
          ),
      401: () => APIResponse<User>(APICode.unauthorized, null),
      404: () => APIResponse<User>(APICode.notfound, null),
    };

    return switcher[response.statusCode]!();
  }
}
