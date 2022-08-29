import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/index.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class CommentsScreen extends StatefulWidget {
  static const String route = "comments";

  final int number;
  final int day;

  const CommentsScreen({
    Key? key,
    required this.number,
    required this.day,
  }) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  Widget _errorBuilder(error) {
    return ErrorPage(
      title: Strings.connectionErrorHeader,
      content: Strings.connectionErrorBody,
      buttonText: Strings.refreshButton,
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _waitingBuilder() {
    return const ShimmerMessageList();
  }

  Widget _doneBuilder(List<Comment> elements) {
    return MessagesList<Comment>(
      elements: elements,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "${widget.number} ${Strings.appBarComments}",
        leading: AppBarButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ChangeNotifierProvider<CommentsProvider>(
        create: (_) => CommentsProvider(),
        builder: (newContext, child) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: widget.number != 0
                      ? FutureBuilder(
                          future: newContext
                              .read<CommentsProvider>()
                              .getComments(
                                  context.read<AppWideProvider>().accessToken!,
                                  widget.day),
                          builder: (BuildContext _, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return _errorBuilder(snapshot.error);
                              }
                              return _doneBuilder(
                                  snapshot.data! as List<Comment>);
                            }
                            return _waitingBuilder();
                          },
                        )
                      : const Center(
                          child: SingleChildScrollView(
                            child: ErrorPage(
                              title: Strings.noCommentErrorHeader,
                              content: Strings.noCommentErrorBody,
                              image: Images.comment,
                            ),
                          ),
                        ),
                ),
              ),
              child!,
            ],
          );
        },
        child: const Material(
          color: Palette.tint1,
          child: SafeArea(
            bottom: true,
            child: CommentTextField(),
          ),
        ),
      ),
    );
  }
}
