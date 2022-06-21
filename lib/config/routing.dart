import 'package:fitness_app/features/app_wide/screens/loading_start_page.dart';
import 'package:fitness_app/features/chronometer/screens/clock_screen.dart';
import 'package:fitness_app/features/comments/screens/comments_screen.dart';
import 'package:fitness_app/features/daily/day_screen.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/features/main/index.dart';
import 'package:fitness_app/features/profile/screens/profile_screen.dart';
import 'package:fitness_app/features/video_player/screens/preview_screen.dart';
import 'package:flutter/widgets.dart';

class Routing {
  Routing._();

  static Map<String, Widget Function(BuildContext)> routes = {
    LoadingStartPage.route: (context) => const LoadingStartPage(),
    LoginScreen.route: (context) => const LoginScreen(),
    MainScreen.route: (context) => const MainScreen(),
    ProfileScreen.route: (context) => const ProfileScreen(),
    CommentsScreen.route: (context) => const CommentsScreen(),
    DayScreen.route: (context) => DayScreen(
          program: (ModalRoute.of(context)?.settings.arguments!
              as List<DailyProgram>)[0],
        ),
    PreviewScreen.route: (context) => PreviewScreen(
          videoAsset:
              (ModalRoute.of(context)?.settings.arguments! as List<String>)[0],
        ),
    ClockScreen.route: (context) => const ClockScreen(),
  };
  static String initialRoute = LoadingStartPage.route;
}
