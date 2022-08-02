import 'dart:convert';

import 'package:fitness_app/features/main/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DailyProgram JSON", () {
    test("normal case (rest day)", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","text": "Test String as text"}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.text, "Test String as text");
      expect(dp.isRestDay, true);
      expect(dp.blocs.length, 0);
      expect(dp.subtitle, "Test");
      expect(dp.title, "Test");
      expect(dp.comments, 0);
    });
    test("normal case (not rest day)", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","blocs": [{"type": 1}]}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.title, "Test");
      expect(dp.subtitle, "Test");
      expect(dp.blocs.length, 1);
      expect(dp.text, "");
      expect(dp.isRestDay, false);
      expect(dp.comments, 0);
    });
    test("blocs should be set", () {
      String jsonString = '{"title": "Test","subtitle": "Test","blocs": []}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.title, "Test");
      expect(dp.subtitle, "Test");
      expect(dp.blocs.length, 0);
      expect(dp.text, "");
      expect(dp.isRestDay, true);
      expect(dp.comments, 0);
    });
    test("blocs should be set (no json)", () {
      String jsonString = '{"title": "Test","subtitle": "Test"}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.title, "Test");
      expect(dp.subtitle, "Test");
      expect(dp.blocs.length, 0);
      expect(dp.text, "");
      expect(dp.isRestDay, true);
      expect(dp.comments, 0);
    });
    test("number of comments should not be 0", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test", "nb_comments":1}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.title, "Test");
      expect(dp.subtitle, "Test");
      expect(dp.blocs.length, 0);
      expect(dp.text, "");
      expect(dp.isRestDay, true);
      expect(dp.comments, 1);
    });
  });
  group("DailyProgram Blocs typing", () {
    test("should build ExerciseSet", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","blocs": [{"type": 0}]}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.blocs.length, 1);
      expect(dp.blocs[0].runtimeType, ExerciseSet);
    });
    test("should build AMRAP", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","blocs": [{"type": 1}]}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.blocs.length, 1);
      expect(dp.blocs[0].runtimeType, AMRAP);
    });
    test("should build ForTime", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","blocs": [{"type": 2}]}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.blocs.length, 1);
      expect(dp.blocs[0].runtimeType, ForTime);
    });
    test("should build EMOM", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","blocs": [{"type": 3}]}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.blocs.length, 1);
      expect(dp.blocs[0].runtimeType, EMOM);
    });
    test("should build Tabata", () {
      String jsonString =
          '{"title": "Test","subtitle": "Test","blocs": [{"type": 4}]}';
      DailyProgram dp = DailyProgram.fromJson(json.decode(jsonString));

      expect(dp.blocs.length, 1);
      expect(dp.blocs[0].runtimeType, Tabata);
    });
  });
}
