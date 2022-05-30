import 'package:fitness_app/features/login/domain/repository/login_repository.dart';
import 'package:flutter/widgets.dart';

import '../domain/models/user.dart';
import '../domain/services/login_service.dart';

class LoginProvider extends ChangeNotifier {
  final User _user = User();
  late final LoginRepository _service;
  bool _isLoading = false;

  LoginProvider() {
    _service = LoginService();
  }

  LoginProvider.fromService(LoginRepository ls) {
    _service = ls;
  }

  String get username {
    return _user.username;
  }

  set username(String value) {
    _user.username = value;
    notifyListeners();
  }

  String get password {
    return _user.password;
  }

  set password(String value) {
    _user.password = value;
    notifyListeners();
  }

  get isLoading {
    return _isLoading;
  }

  void _changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<bool> login() async {
    _changeLoadingState();
    bool out = await _service.login(_user.username, _user.password);
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
