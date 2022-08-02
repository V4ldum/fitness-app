import 'dart:convert';

import 'package:fitness_app/config/strings.dart';
import 'package:http/http.dart' as http;
import 'package:week_of_year/date_week_extensions.dart';

import '../domain.dart';

class CommentsService implements CommentsRepository {
  @override
  Future<List<Comment>?> getComments(String token, int day) async {
    List<Comment>? out;
    final http.Response response = await http.get(
      Uri.http(
        Strings.apiHost,
        Strings.apiCommentsPath,
        {
          "day": day.toString(),
          "week": DateTime.now().weekOfYear.toString(),
          "token": token,
        },
      ),
    );

    if (response.statusCode == 200) {
      out = [];

      final List? json =
          jsonDecode(utf8.decode(response.bodyBytes))["comments"];
      if (json != null) {
        for (var element in json) {
          out.add(Comment.fromJson(element));
        }
      }
    }
    return out;
  }

  @override
  Future<Comment?> getComment(String token, int commentId) async {
    Comment? out;

    final http.Response response = await http.get(
      Uri.http(
        Strings.apiHost,
        "${Strings.apiCommentsPath}/$commentId",
        {
          "token": token,
        },
      ),
    );

    if (response.statusCode == 200) {
      out;

      final Map<String, dynamic>? json =
          jsonDecode(utf8.decode(response.bodyBytes))["comment"];

      if (json != null) {
        out = Comment.fromJson(json);
      }
    }
    return out;
  }

  @override
  Future<List<Reply>?> getReplies(String token, int commentId) async {
    List<Reply>? out;

    final http.Response response = await http.get(
      Uri.http(
        Strings.apiHost,
        Strings.apiRepliesPath,
        {
          "comment_id": commentId.toString(),
          "token": token,
        },
      ),
    );

    if (response.statusCode == 200) {
      out = [];

      final List? json = jsonDecode(utf8.decode(response.bodyBytes))["replies"];

      if (json != null) {
        for (var element in json) {
          out.add(Reply.fromJson(element));
        }
      }
    }
    return out;
  }
}
