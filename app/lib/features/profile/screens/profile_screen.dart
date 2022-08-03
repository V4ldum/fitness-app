import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:fitness_app/features/login/screens/login_screen.dart';
import 'package:fitness_app/shared/widgets/alert/alert.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String route = "profile";

  const ProfileScreen({Key? key}) : super(key: key);

  void _openAlert(BuildContext context) {
    PopupAlert.open(
      context: context,
      desc: Strings.logOutMessage,
      buttons: [
        AlertButton(
          text: Strings.logOutDeny,
          onPressed: () => Navigator.pop(context),
        ),
        AlertButton(
          text: Strings.logOutAccept,
          onPressed: () {
            context.read<AppWideProvider>().deleteTokens();
            imageCache.clear();
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
      body: ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const ProfileHeader(),
                    const SizedBox(height: 15.0),
                    const Separator(),
                    const SizedBox(height: 10.0),
                    Consumer<ProfileProvider>(
                      builder: (_, provider, __) {
                        if (provider.isLoadingProfile) {
                          return const CircularProgressIndicator();
                        }
                        return const RepaintBoundary(
                          child: Settings(),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (newContext, provider, _) {
                return Visibility(
                  visible: provider.isLoadingExternal,
                  child: Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
