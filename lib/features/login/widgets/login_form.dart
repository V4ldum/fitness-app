import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/shared/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import 'widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              Strings.loginPageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: Fonts.primarySemiBold,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          FormTextField(
            hint: Strings.loginHint,
            icon: Icons.person,
            onChanged: (String value) {
              context.read<LoginProvider>().username = value;
            },
          ),
          const SizedBox(height: 30.0),
          FormTextField(
            hint: Strings.passwordHint,
            icon: Icons.lock,
            obscure: true,
            onChanged: (String value) {
              context.read<LoginProvider>().password = value;
            },
          ),
          const SizedBox(height: 30.0),
          Row(
            children: [
              Expanded(
                child: FormButton(
                  text: Strings.signUpButton,
                  textColor: Palette.accent,
                  backgroundColor: Palette.primary,
                  onPressed: () {
                    context
                        .read<LoginProvider>()
                        .onPressedForgottenPasswordButton(context);
                  },
                ),
              ),
              const SizedBox(width: 30.0),
              Expanded(
                child: FormButton(
                  text: Strings.logInButton,
                  onPressed: () {
                    context.read<LoginProvider>().onPressedLoginButton(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          IconTextButton(
            text: Strings.forgottenPassword,
            onPressed: () async {
              context
                  .read<LoginProvider>()
                  .onPressedOpenRegistrationButton(context);
            },
          ),
        ],
      ),
    );
  }
}
