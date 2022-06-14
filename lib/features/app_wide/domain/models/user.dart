import 'permission.dart';

class User {
  String username;
  String fullName;
  String? imagePath;
  List<Permission> permissions = [];

  User({
    required this.username,
    required this.fullName,
    this.imagePath,
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
      imagePath: json["image_path"] as String?,
      permissions:
          ((json["permissions"] ?? []) as List).map((e) => e as int).toList(),
    );
  }
}
