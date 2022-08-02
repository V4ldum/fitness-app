import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/app_wide/providers/app_wide_provider.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class RepliesScreen extends StatefulWidget {
  static const route = "replies";

  final int commentId;
  final int number;

  const RepliesScreen({
    Key? key,
    required this.commentId,
    required this.number,
  }) : super(key: key);

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
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

  Widget _doneBuilder(List<Reply> elements) {
    return MessagesList<Reply>(
      elements: elements,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "${widget.number} ${Strings.appBarReplies}",
        leading: AppBarButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ChangeNotifierProvider<RepliesProvider>(
        create: (_) => RepliesProvider(),
        builder: (newContext, child) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: widget.number != 0
                      ? FutureBuilder(
                          future: newContext.read<RepliesProvider>().getReplies(
                                context.read<AppWideProvider>().accessToken!,
                                widget.commentId,
                              ),
                          builder: (BuildContext _, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return _errorBuilder(snapshot.error);
                              }
                              return _doneBuilder(
                                  snapshot.data! as List<Reply>);
                            }
                            return _waitingBuilder();
                          },
                        )
                      : const ErrorPage(
                          title: Strings.noCommentErrorHeader,
                          content: Strings.noCommentErrorBody,
                          image: Images.comment,
                        ),
                ),
              ),
              child!
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
