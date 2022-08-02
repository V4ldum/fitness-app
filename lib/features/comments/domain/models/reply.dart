import 'comment.dart';
import 'imessage.dart';

class Reply extends IMessage {
  Reply({
    required String username,
    required String userDisplayName,
    required String message,
    required int timestamp,
  }) : super(
          username: username,
          userDisplayName: userDisplayName,
          message: message,
          timestamp: timestamp,
        );

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      username: json["username"],
      userDisplayName: json["display_name"],
      message: json["message"],
      timestamp: json["timestamp"],
    );
  }

  factory Reply.fromComment(Comment comment) {
    return Reply(
      username: comment.username,
      userDisplayName: comment.userDisplayName,
      message: comment.message,
      timestamp: comment.date.millisecondsSinceEpoch ~/ 1000,
    );
  }
}
