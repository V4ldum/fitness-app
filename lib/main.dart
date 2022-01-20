import 'package:fitness_app/constants.dart';
import 'package:fitness_app/view/screens/clock_screen.dart';
import 'package:fitness_app/view/screens/login_screen.dart';
import 'package:fitness_app/view/screens/preview_screen.dart';
import 'package:fitness_app/view/screens/program_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryDarkColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryColor,
          brightness: Brightness.dark,
        ),
      ),
      routes: {
        ClockScreen.route: (context) => const ClockScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        PreviewScreen.route: (context) => const PreviewScreen(),
        ProgramScreen.route: (context) => const ProgramScreen(),
      },
      initialRoute: LoginScreen.route,
    );
  }
}
