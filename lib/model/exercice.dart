class Exercise {
  String name;

  Exercise({required this.name});

  factory Exercise.fromJson(Map<String, String> json) {
    return Exercise(
      name: json["name"]!,
    );
  }
}
