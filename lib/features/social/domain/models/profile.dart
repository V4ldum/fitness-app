class Profile {
  final String name;
  final String imageUrl;

  Profile({
    required this.name,
    required this.imageUrl,
  });

  factory Profile.json(Map<String, String> json) {
    return Profile(
      name: json["name"] ?? "Placeholder", //TODO baseline name
      imageUrl: json["image"] ?? "Placeholder", //TODO baseline image
    );
  }
}
