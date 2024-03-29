import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class PreviewScreen extends StatelessWidget {
  static const String route = "preview";

  final String videoUrl;

  const PreviewScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        title: Strings.appBarPreview,
        isTransparent: true,
        leading: AppBarButton(
          icon: Icons.arrow_back,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ChangeNotifierProvider<VideoPlayerProvider>(
        create: (context) => VideoPlayerProvider.fromNetwork(videoUrl),
        builder: (context, _) {
          return FutureBuilder(
            future: context.read<VideoPlayerProvider>().initializeVideoPlayer,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError == true) {
                  return const ErrorPage(
                    title: Strings.videoErrorHeader,
                    content: Strings.videoErrorBody,
                  );
                }
                return const PreviewVideoPlayer();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
