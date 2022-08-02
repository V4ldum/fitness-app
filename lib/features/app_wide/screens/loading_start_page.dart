import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/features/main/screens/main_screen.dart';
import 'package:fitness_app/shared/widgets/big_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class LoadingStartPage extends StatelessWidget {
  static const String route = "app_loading";

  const LoadingStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartupCaller(
        onInit: () async {
          if (await context.read<AppWideProvider>().authenticate()) {
            Navigator.pushReplacementNamed(context, MainScreen.route);
          } else {
            Navigator.pushReplacementNamed(context, LoginScreen.route);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Hero(
              tag: Strings.heroBigLogo,
              child: BigLogo(),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
