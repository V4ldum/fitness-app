import 'package:fitness_app/features/app_wide/index.dart';
import 'package:flutter/widgets.dart';

import '../domain/domain.dart';

class LoginProvider extends ChangeNotifier {
  String username = "";
  String password = "";
  late final LoginRepository _service;
  bool _isLoading = false;

  LoginProvider() {
    _service = LoginService();
  }

  LoginProvider.fromService(LoginRepository ls) {
    _service = ls;
  }

  get isLoading {
    return _isLoading;
  }

  void _changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<APIResponse<Map<String, Object>>> login() async {
    _changeLoadingState();
    final APIResponse<Map<String, Object>> out =
        await _service.login(username, password);
    _changeLoadingState();

    return out;
  }

  Future<bool> openForgottenPasswordPage() async {
    _changeLoadingState();
    bool out = await _service.openForgottenPasswordPage();
    _changeLoadingState();

    return out;
  }

  Future<bool> openRegistrationPage() async {
    _changeLoadingState();
    bool out = await _service.openRegistrationPage();
    _changeLoadingState();

    return out;
  }
}
