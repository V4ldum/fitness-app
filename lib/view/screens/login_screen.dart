import 'package:fitness_app/constants.dart';
import 'package:fitness_app/controller/login_manager.dart';
import 'package:fitness_app/model/error_type.dart';
import 'package:fitness_app/view/components/login_button.dart';
import 'package:fitness_app/view/components/login_field.dart';
import 'package:fitness_app/view/screens/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static String route = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showSpinner = false;
  late String username;
  late String password;

  @override
  void initState() {
    super.initState();
    username = "";
    password = "";
  }

  void _openAlert(BuildContext context, ErrorType e) {
    Map<ErrorType, List<String>> errorData = {
      ErrorType.password: [kLoginErrorHeaderString, kLoginErrorBodyString],
      ErrorType.network: [kNetworkErrorHeaderString, kNetworkErrorBodyString],
    };

    Alert(
      context: context,
      title: errorData[e]![0],
      desc: "\n" + errorData[e]![1],
      style: kLoginAlertStyle,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: kPrimaryColor,
          child: Text(
            kLoginAlertButtonString,
            style: kLoginTextStyle.copyWith(
              color: kPrimaryDarkColor,
            ),
          ),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Column(
                    children: const [
                      Image(
                        height: 200.0,
                        image: AssetImage("assets/logo-big.png"),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    kLoginPageHeaderString,
                    style: kLoginHeaderStyle,
                  ),
                ),
                const SizedBox(height: 30.0),
                LoginField(
                  hint: kLoginHintString,
                  icon: Icons.person,
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 30.0),
                LoginField(
                  hint: kPasswordHintString,
                  icon: Icons.lock,
                  obscure: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LoginButton(
                      text: kSignUpButtonString,
                      textColor: kPrimaryColor,
                      backgroundColor: kPrimaryDarkColor,
                      borderColor: kPrimaryColor,
                      onPressedCallback: () async {
                        setState(() {
                          _showSpinner = true;
                        });
                        if (!await LoginManager.openRegistrationPage()) {
                          _openAlert(context, ErrorType.network);
                        }
                        setState(() {
                          _showSpinner = false;
                        });
                      },
                    ),
                    const SizedBox(width: 30.0),
                    LoginButton(
                      text: kSignInButtonString,
                      onPressedCallback: () async {
                        setState(() {
                          _showSpinner = true;
                        });
                        if (await LoginManager.login(username, password)) {
                          Navigator.pushReplacementNamed(
                              context, PreviewScreen.route);
                        } else {
                          _openAlert(context, ErrorType.password);
                        }
                        setState(() {
                          _showSpinner = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    if (!await LoginManager.openForgottenPasswordPage()) {
                      _openAlert(context, ErrorType.network);
                    }
                    setState(() {
                      _showSpinner = false;
                    });
                  },
                  child: const Text(kPasswordForgottenString),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
