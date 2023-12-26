import 'package:fitness_app/config/colors.dart';
import 'package:fitness_app/features/app_wide/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/routing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppWideProvider>(
      create: (_) => AppWideProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Palette.primary,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Palette.accent,
            brightness: Brightness.dark,
          ),
        ),
        routes: Routing.routes,
        initialRoute: Routing.initialRoute,
      ),
    );
  }
}
