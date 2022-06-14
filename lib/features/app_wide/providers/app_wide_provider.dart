import 'package:fitness_app/features/app_wide/domain/domain.dart';
import 'package:fitness_app/features/daily/index.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AppWideProvider extends ChangeNotifier {
  String? accessToken;
  String? refreshToken;
  final AppWideRepository _service = AppWideService();
  User? user;

  Future<void> authenticate(BuildContext context) async {
    Future<String?> refreshTokenFuture = _service.getRefreshToken();
    accessToken = await _service.getAccessToken();

    // Access token found on system
    if (accessToken != null) {
      APIResponse<User> authenticationCall =
          await _service.authenticate(accessToken!);

      // Access token is valid
      if (authenticationCall.statusCode == APICode.ok) {
        user = authenticationCall.content;
        _loadAppData();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, WeekScreen.route);
        return;
      }
    }

    refreshToken = await refreshTokenFuture;
    // Access token is not valid but refresh token is found
    if (refreshToken != null) {
      APIResponse<Map<String, String>> refreshCall =
          await _service.refresh(refreshToken!);

      // Refresh token is valid
      if (refreshCall.statusCode == APICode.ok) {
        //New refresh token for security
        refreshToken = refreshCall.content!["refresh_token"];
        //New access token
        accessToken = refreshCall.content!["access_token"];

        APIResponse<User> refreshAuthenticationCall =
            await _service.authenticate(accessToken!);

        // Access token is valid (in case it isn't for some reason)
        if (refreshAuthenticationCall.statusCode == APICode.ok) {
          _service.updateTokens(accessToken!, refreshToken!);
          _loadAppData();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, WeekScreen.route);
          return;
        }
      }
    }
    // Access token & refresh token both not found or invalid
    accessToken = null;
    refreshToken = null;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }

  Future<void> _loadAppData() async {
    //TODO query profile picture
    print("query data");
  }

  void deleteTokens() {
    _service.deleteTokens();
  }
}
