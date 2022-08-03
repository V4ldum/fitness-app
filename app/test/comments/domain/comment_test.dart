import 'dart:convert';

import 'package:fitness_app/features/comments/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Comment Constructor", () {
    test("Construction from parameters", () {
      Comment c = Comment(
        id: 1,
        username: "test",
        userDisplayName: "Test",
        message: "Testing",
        timestamp: DateTime(2020, 5, 3, 15, 36).millisecondsSinceEpoch ~/ 1000,
        nbReplies: 5,
      );

      expect(c.id, 1);
      expect(c.username, "test");
      expect(c.userDisplayName, "Test");
      expect(c.message, "Testing");
      expect(c.date, DateTime(2020, 5, 3, 15, 36));
      expect(c.nbReplies, 5);
    });

    test("Construction from json", () {
      String jsonString =
          '{"id":1,"username":"test","display_name":"Test","message":"Testing","timestamp":1588512960,"nb_replies":5}';
      Comment c = Comment.fromJson(json.decode(jsonString));

      expect(c.id, 1);
      expect(c.username, "test");
      expect(c.userDisplayName, "Test");
      expect(c.message, "Testing");
      expect(c.date, DateTime(2020, 5, 3, 15, 36));
      expect(c.nbReplies, 5);
    });
  });
}
