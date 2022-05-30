import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/video_player_provider.dart';
import '../widgets/preview_video_player.dart';

class PreviewScreen extends StatelessWidget {
  static String route = "preview";

  final String videoAsset;

  const PreviewScreen({Key? key, required this.videoAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          create: (context) => VideoPlayerProvider.fromAsset(videoAsset),
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
      ),
    );
  }
}
