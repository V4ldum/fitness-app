import 'dart:convert';

import 'package:fitness_app/features/comments/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Comment Constructor", () {
    test("Construction from parameters", () {
      Reply r = Reply(
        username: "test",
        userDisplayName: "Test",
        message: "Testing",
        timestamp: DateTime(2020, 5, 3, 15, 36).millisecondsSinceEpoch ~/ 1000,
      );

      expect(r.username, "test");
      expect(r.userDisplayName, "Test");
      expect(r.message, "Testing");
      expect(r.date, DateTime(2020, 5, 3, 15, 36));
    });

    test("Construction from json", () {
      String jsonString =
          '{"id":1,"username":"test","display_name":"Test","message":"Testing","timestamp":1588512960,"nb_replies":5}';
      Reply r = Reply.fromJson(json.decode(jsonString));

      expect(r.username, "test");
      expect(r.userDisplayName, "Test");
      expect(r.message, "Testing");
      expect(r.date, DateTime(2020, 5, 3, 15, 36));
    });
  });
}
