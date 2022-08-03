import 'package:fitness_app/features/app_wide/screens/loading_start_page.dart';
import 'package:fitness_app/features/comments/screens/comments_screen.dart';
import 'package:fitness_app/features/comments/screens/replies_screen.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/features/main/index.dart';
import 'package:fitness_app/features/profile/screens/profile_screen.dart';
import 'package:fitness_app/features/stopwatch/screens/main_clock_screen.dart';
import 'package:fitness_app/features/video_player/screens/preview_screen.dart';
import 'package:flutter/widgets.dart';

class Routing {
  Routing._();

  static Map<String, Widget Function(BuildContext)> routes = {
    LoadingStartPage.route: (context) => const LoadingStartPage(),
    LoginScreen.route: (context) => const LoginScreen(),
    MainScreen.route: (context) => MainScreen(),
    ProfileScreen.route: (context) => const ProfileScreen(),
    CommentsScreen.route: (context) => CommentsScreen(
          day: (ModalRoute.of(context)?.settings.arguments!
              as Map<String, int>)["day"]!,
          number: (ModalRoute.of(context)?.settings.arguments!
              as Map<String, int>)["number"]!,
        ),
    PreviewScreen.route: (context) => PreviewScreen(
          videoUrl: ModalRoute.of(context)?.settings.arguments! as String,
        ),
    MainClockScreen.route: (context) => MainClockScreen(
          bloc: ModalRoute.of(context)?.settings.arguments as Bloc,
        ),
    RepliesScreen.route: (context) => RepliesScreen(
          commentId: (ModalRoute.of(context)?.settings.arguments!
              as Map<String, dynamic>)["commentId"]! as int,
          number: (ModalRoute.of(context)?.settings.arguments!
              as Map<String, dynamic>)["number"]! as int,
        ),
  };
  static String initialRoute = LoadingStartPage.route;
}
