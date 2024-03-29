import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:fitness_app/features/profile/index.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:fitness_app/shared/widgets/small_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'daily_view.dart';
import 'other_view.dart';

class MainScreen extends StatelessWidget {
  static const String route = "main";

  final Map<Permission, Widget Function()> _currentViewSwitcher = {
    Permission.Daily: () => ChangeNotifierProvider<DailyProvider>(
          create: (_) => DailyProvider(),
          child: const DailyView(),
        ),
    Permission.Other: () => const OtherView(),
  };

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: MyAppBar(
          title: Strings.appBarWeek,
          leading: const SmallLogo(),
          trailing: AppBarButton(
            icon: Icons.people_alt,
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.route);
            },
          ),
        ),
        bottomNavigationBar: Consumer<MainProvider>(
          builder: (_, provider, __) {
            return MyBottomNavigationBar(
              selectedIndex: provider.selectedIndex,
              onTap: (int value) {
                provider.selectedIndex = value;
              },
            );
          },
        ),
        body: Consumer<MainProvider>(
          builder: (_, provider, __) {
            AppWideProvider appWideProvider = context.read<AppWideProvider>();
            Widget? out;
            try {
              out = _currentViewSwitcher[
                      appWideProvider.user?.permissions[provider.selectedIndex]]
                  ?.call();
            } on RangeError {
              // No access bought
              return const ErrorPage(
                image: Images.noServiceImage,
                title: Strings.noContentErrorHeader,
                content: Strings.noContentErrorBody,
              );
            }
            // Correct page or attempt to bypass logon
            return out ??
                const ErrorPage(
                  title: Strings.unknownErrorHeader,
                  content: Strings.unknownErrorBody,
                );
          },
        ),
      ),
    );
  }
}
