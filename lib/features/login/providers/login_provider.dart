import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/app_wide/domain/domain.dart';
import 'package:fitness_app/features/daily/index.dart';
import 'package:fitness_app/shared/widgets/alert/alert.dart';
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

  Future<APIResponse<User>> login() async {
    _changeLoadingState();
    final APIResponse<User> out = await _service.login(_username, _password);
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

  void _openAlert(BuildContext context, LoginErrorType e) {
    Map<LoginErrorType, List<String>> errorData = {
      LoginErrorType.password: [
        Strings.loginErrorHeader,
        Strings.loginErrorBody
      ],
      LoginErrorType.network: [
        Strings.networkErrorHeader,
        Strings.networkErrorBody
      ],
      LoginErrorType.unknown: [
        Strings.unknownErrorHeader,
        Strings.unknownErrorBody
      ],
    };

    PopupAlert.open(
      context: context,
      title: errorData[e]![0],
      desc: "\n${errorData[e]![1]}",
      buttons: [
        AlertButton(
          onPressed: () => Navigator.pop(context),
          text: Strings.loginAlertButton,
        ),
      ],
    ).show();
  }

  void onPressedLoginButton(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<APICode, Function()> switcher = {
      APICode.ok: () =>
          Navigator.pushReplacementNamed(context, WeekScreen.route),
      APICode.notfound: () => _openAlert(context, LoginErrorType.network),
      APICode.unauthorized: () => _openAlert(context, LoginErrorType.password),
    };

    login().then((response) {
      Function()? switcherOutput = switcher[response.statusCode];

      if (switcherOutput != null) {
        switcherOutput();
      } else {
        _openAlert(context, LoginErrorType.unknown);
      }
    });
  }

  void onPressedOpenRegistrationButton(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!await openRegistrationPage()) {
      _openAlert(context, LoginErrorType.network);
    }
  }

  void onPressedForgottenPasswordButton(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!await openForgottenPasswordPage()) {
      _openAlert(context, LoginErrorType.network);
    }
  }
}
