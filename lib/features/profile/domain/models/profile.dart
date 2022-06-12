class Profile {
  final String name;
  final String imageUrl;

  Profile({
    required this.name,
    required this.imageUrl,
  });

  factory Profile.json(Map<String, String> json) {
    return Profile(
      name: json["name"]!,
      imageUrl: json["image"]!,
    );
  }
}
