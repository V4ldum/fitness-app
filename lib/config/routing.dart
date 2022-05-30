import 'package:fitness_app/features/chronometer/screens/clock_screen.dart';
import 'package:fitness_app/features/daily/screens/day_screen.dart';
import 'package:fitness_app/features/daily/screens/week_screen.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/features/social/screens/comments_screen.dart';
import 'package:fitness_app/features/social/screens/profile_screen.dart';
import 'package:fitness_app/features/video_player/screens/preview_screen.dart';
import 'package:flutter/widgets.dart';

class Routing {
  Routing._();

  static Map<String, Widget Function(BuildContext)> routes = {
    ClockScreen.route: (context) => const ClockScreen(),
    LoginScreen.route: (context) => const LoginScreen(),
    WeekScreen.route: (context) => const WeekScreen(),
    PreviewScreen.route: (context) => PreviewScreen(
        videoAsset:
            (ModalRoute.of(context)?.settings.arguments! as List<String>)[0]),
    DayScreen.route: (context) => const DayScreen(),
    ProfileScreen.route: (context) => const ProfileScreen(),
    CommentsScreen.route: (context) => const CommentsScreen(),
  };
  static String initialRoute = LoginScreen.route;
}
