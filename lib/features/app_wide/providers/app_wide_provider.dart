// ignore_for_file: use_build_context_synchronously

import 'package:fitness_app/features/app_wide/domain/domain.dart';
import 'package:flutter/material.dart';

class AppWideProvider extends ChangeNotifier {
  String? accessToken;
  String? refreshToken;
  late final AppWideRepository _service;
  User? user;

  AppWideProvider() {
    _service = AppWideService();
  }

  AppWideProvider.fromService(AppWideRepository awr) {
    _service = awr;
  }

  Future<bool> _accessTokenAuthentication() async {
    // Access token not found
    if (accessToken == null) {
      return false;
    }
    APIResponse<User> response = await _service.authenticate(accessToken!);

    // Access token is invalid
    if (response.statusCode != APICode.ok) {
      return false;
    }

    user = response.content;
    _loadAppData();
    return true;
  }

  Future<bool> _refreshTokenAuthentication() async {
    // Refresh token not found
    if (refreshToken == null) {
      return false;
    }
    APIResponse<Map<String, String>> response =
        await _service.refresh(refreshToken!);

    // Refresh token is invalid
    if (response.statusCode != APICode.ok) {
      return false;
    }

    //New access token
    accessToken = response.content!["access_token"];
    //New refresh token for security
    refreshToken = response.content!["refresh_token"];

    // In case new access token is invalid for some obscure reason
    if (!await _accessTokenAuthentication()) {
      return false;
    }

    _service.updateTokens(accessToken!, refreshToken!);
    return true;
  }

  Future<bool> authenticate() async {
    Future<void> minLoadingDuration =
        Future.delayed(const Duration(milliseconds: 500));
    Future<String?> refreshTokenFuture = _service.getRefreshToken();
    accessToken = await _service.getAccessToken();

    if (await _accessTokenAuthentication()) {
      // Access token OK
      await minLoadingDuration;
      return true;
    } else {
      // Access token KO
      refreshToken = await refreshTokenFuture;

      if (await _refreshTokenAuthentication()) {
        // Refresh token OK
        await minLoadingDuration;
        return true;
      } else {
        // Access token & Refresh token KO
        deleteTokens();
        await minLoadingDuration;
        return false;
      }
    }
  }

  Future<void> _loadAppData() async {
    //TODO query data?
    print("query data");
  }

  void deleteTokens() {
    if (accessToken != null || refreshToken != null) {
      _service.deleteTokens();
      accessToken = null;
      refreshToken = null;
    }
  }
}
