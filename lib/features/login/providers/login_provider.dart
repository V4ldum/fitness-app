import 'package:fitness_app/features/app_wide/index.dart';
import 'package:flutter/widgets.dart';

import '../domain/domain.dart';

class LoginProvider extends ChangeNotifier {
  String _username = "";
  String _password = "";
  late final LoginRepository _service;
  bool _isLoading = false;

  LoginProvider() {
    _service = LoginService();
  }

  LoginProvider.fromService(LoginRepository ls) {
    _service = ls;
  }

  String get username {
    return _username;
  }

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String get password {
    return _password;
  }

  set password(String value) {
    _password = value;
    notifyListeners();
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
        await _service.login(_username, _password);
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
