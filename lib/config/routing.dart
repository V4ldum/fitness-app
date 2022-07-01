import 'package:fitness_app/features/app_wide/screens/loading_start_page.dart';
import 'package:fitness_app/features/chronometer/screens/clock_screen.dart';
import 'package:fitness_app/features/comments/screens/comments_screen.dart';
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
    MainScreen.route: (context) => MainScreen(),
    ProfileScreen.route: (context) => const ProfileScreen(),
    CommentsScreen.route: (context) => const CommentsScreen(),
    PreviewScreen.route: (context) => PreviewScreen(
          videoUrl: ModalRoute.of(context)?.settings.arguments! as String,
        ),
    ClockScreen.route: (context) => const ClockScreen(),
  };
  static String initialRoute = LoadingStartPage.route;
}
