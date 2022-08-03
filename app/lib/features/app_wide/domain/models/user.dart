import 'permission.dart';

class User {
  String username;
  String fullName;
  List<Permission> permissions = [];
  String? imageUrl;

  User({
    required this.username,
    required this.fullName,
    List<int> permissions = const [],
  }) {
    for (var item in permissions) {
      this.permissions.add(Permission.values[item]);
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"]! as String,
      fullName: json["full_name"]! as String,
      permissions:
          ((json["permissions"] ?? []) as List).map((e) => e as int).toList(),
    );
  }
}
