import 'package:fitness_app/shared/big_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class LoadingStartPage extends StatelessWidget {
  static String route = "app_loading";
  //static const double _indicatorSize = 15.0;

  const LoadingStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartupCaller(
      onInit: () {
        context.read<AppWideProvider>().authenticate(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BigLogo(),
          SizedBox(height: 30.0),
          /*SizedBox(
            width: _indicatorSize,
            height: _indicatorSize,
            child: CircularProgressIndicator(strokeWidth: _indicatorSize / 8.0),
          ),*/
        ],
      ),
    );
  }
}
