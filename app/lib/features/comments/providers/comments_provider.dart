import 'package:flutter/material.dart';

import '../index.dart';

class CommentsProvider extends ChangeNotifier {
  bool _isLoading = false;
  late final CommentsRepository _service;
  List<Comment>? comments;

  CommentsProvider() {
    _service = CommentsService();
  }

  CommentsProvider.fromService(CommentsRepository cs) {
    _service = cs;
  }

  bool get isLoading => _isLoading;

  void _changeLoadingState() {
    _isLoading = !_isLoading;
  }

  Future getComments(String token, int day) async {
    if (comments != null) return comments;

    _changeLoadingState();
    comments = await _service.getComments(token, day);
    _changeLoadingState();

    return comments ?? <Comment>[];
  }
}
