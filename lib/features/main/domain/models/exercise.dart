class Exercise {
  String name;

  Exercise({required this.name});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json["name"] ?? "Error",
    );
  }

  @override
  String toString() {
    return name.replaceAll("+", "\n\t\t\t\t\t\t\t\t\t+");
  }
}
