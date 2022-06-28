import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentsScreen extends StatelessWidget {
  static String route = "comments";

  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(appBar: MyAppBar(title: "test"), body: Text("comments")),
    );
  }
}
//TODO bottomsheet widget
