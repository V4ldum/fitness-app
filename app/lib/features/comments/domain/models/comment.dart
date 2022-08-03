import 'imessage.dart';

class Comment extends IMessage {
  final int id;
  final int nbReplies;

  Comment({
    required this.id,
    required String username,
    required String userDisplayName,
    required String message,
    required int timestamp,
    required this.nbReplies,
  }) : super(
          username: username,
          userDisplayName: userDisplayName,
          message: message,
          timestamp: timestamp,
        );

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"],
      username: json["username"],
      userDisplayName: json["display_name"],
      message: json["message"],
      timestamp: json["timestamp"],
      nbReplies: json["nb_replies"],
    );
  }
}
