import 'package:flutter/material.dart';

import '../index.dart';

class RepliesProvider extends ChangeNotifier {
  bool _isLoading = false;
  late final CommentsRepository _service;

  Comment? comment;
  List<Reply>? replies;

  RepliesProvider() {
    _service = CommentsService();
  }

  RepliesProvider.fromService(CommentsRepository cs) {
    _service = cs;
  }

  bool get isLoading => _isLoading;

  void _changeLoadingState() {
    _isLoading = !_isLoading;
  }

  Future<List<Reply>> getReplies(String token, int commentId) async {
    if (replies != null && comment != null) {
      return [Reply.fromComment(comment!), ...replies!];
    }

    _changeLoadingState();

    var futureComment = _service.getComment(token, commentId);
    var futureReplies = _service.getReplies(token, commentId);

    comment = await futureComment;
    replies = await futureReplies;

    _changeLoadingState();

    if (replies == null) return [];

    return [Reply.fromComment(comment!), ...replies!];
  }
}
