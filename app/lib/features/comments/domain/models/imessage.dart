abstract class IMessage {
  final String username;
  final String userDisplayName;
  final String message;
  late final DateTime date;

  IMessage({
    required this.username,
    required this.userDisplayName,
    required this.message,
    required int timestamp,
  }) {
    // Unix timestamp is in seconds, so *1000 might be needed
    date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}
