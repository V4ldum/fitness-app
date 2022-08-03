import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/shared/widgets/big_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: Hero(
                          tag: Strings.heroBigLogo,
                          child: BigLogo(),
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
