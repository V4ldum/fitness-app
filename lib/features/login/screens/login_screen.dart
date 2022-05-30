import 'package:fitness_app/config/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static String route = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                      MediaQuery.of(context).viewInsets.bottom == 0
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: Image(
                          height: 200.0,
                          image: AssetImage(Images.bigLogo),
                        ),
                      ),
                    ),
                    const LoginForm(),
                  ],
                ),
              ),
              Consumer<LoginProvider>(
                builder: (newContext, provider, _) {
                  return Visibility(
                    visible: provider.isLoading,
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
      ),
    );
  }
}
