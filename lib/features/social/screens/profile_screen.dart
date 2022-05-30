import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/shared/widgets/alert/alert.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings/providers/settings.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  static String route = "profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _openAlert(BuildContext context) {
    PopupAlert.open(
      context: context,
      desc: Strings.logOutMessage,
      buttons: [
        AlertButton(
          text: Strings.logOutDeny,
          onPressed: () => Navigator.pop(context),
        ),
        //TODO retirer la méthode d'authentification + se déco
        AlertButton(
          text: Strings.logOutAccept,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.route,
              (_) => false,
            );
          },
        ),
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
  }

  //TODO profile.json + change image button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Strings.appBarProfile,
        leading: AppBarButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        trailing: AppBarButton(
          icon: Icons.logout,
          onPressed: () {
            _openAlert(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const ProfileHeader(),
              const SizedBox(height: 15.0),
              const Separator(),
              const SizedBox(height: 10.0),
              ChangeNotifierProvider<Settings>(
                create: (_) => Settings(),
                //child: const NotificationsSettings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
