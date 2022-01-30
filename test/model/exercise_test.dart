import 'dart:convert';

import 'package:fitness_app/model/exercise.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Exercise JSON", () {
    test("exercise with no name", () {
      String jsonString = '{"assets": "TODO"}';
      Exercise e = Exercise.fromJson(json.decode(jsonString));

      expect(e.name, "Error");
    });
    test("exercise with name", () {
      String jsonString = '{"name": "Test Exercise","assets": "TODO"}';
      Exercise e = Exercise.fromJson(json.decode(jsonString));

      expect(e.name, "Test Exercise");
    });
  });
}
