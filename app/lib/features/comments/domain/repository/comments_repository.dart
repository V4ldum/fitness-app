import '../domain.dart';

abstract class CommentsRepository {
  Future<List<Comment>?> getComments(String token, int day);
  Future<Comment?> getComment(String token, int commentId);
  Future<List<Reply>?> getReplies(String token, int commentId);
}
