import 'dart:convert';

import 'package:fitness_app/model/exercise.dart';
import 'package:fitness_app/model/for_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("For Time Constructor", () {
    test("default exercise set", () {
      ForTime ft = ForTime();

      expect(ft.sets, 1);

      expect(ft.rest.inSeconds, 0);
      expect(ft.rest.inMinutes, 0);
      expect(ft.rest, Duration.zero);

      expect(ft.cap.inSeconds, 0);
      expect(ft.cap.inMinutes, 0);
      expect(ft.cap, Duration.zero);

      expect(ft.exercises.length, 0);
    });
    test("set should be 1", () {
      ForTime ft = ForTime(sets: 1);

      expect(ft.sets, 1);
    });
    test("rest should be 0:30 (full construction)", () {
      ForTime ft = ForTime(restMinutes: 0, restSeconds: 30);

      expect(ft.rest, const Duration(seconds: 30));
    });
    test("rest should be 0:30 (partial construction)", () {
      ForTime ft = ForTime(restSeconds: 30);

      expect(ft.rest, const Duration(seconds: 30));
    });
    test("rest should be 1:00 (full construction)", () {
      ForTime ft = ForTime(restMinutes: 1, restSeconds: 0);

      expect(ft.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:00 (partial construction)", () {
      ForTime ft = ForTime(restMinutes: 1);

      expect(ft.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:30", () {
      ForTime ft = ForTime(restMinutes: 1, restSeconds: 30);

      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
    });
    test("cap should be 0:30 (full construction)", () {
      ForTime ft = ForTime(capMinutes: 0, capSeconds: 30);

      expect(ft.cap, const Duration(seconds: 30));
    });
    test("cap should be 0:30 (partial construction)", () {
      ForTime ft = ForTime(capSeconds: 30);

      expect(ft.cap, const Duration(seconds: 30));
    });
    test("cap should be 1:00 (full construction)", () {
      ForTime ft = ForTime(capMinutes: 1, capSeconds: 0);

      expect(ft.cap, const Duration(minutes: 1));
    });
    test("cap should be 1:00 (partial construction)", () {
      ForTime ft = ForTime(capMinutes: 1);

      expect(ft.cap, const Duration(minutes: 1));
    });
    test("cap should be 1:30", () {
      ForTime ft = ForTime(capMinutes: 1, capSeconds: 30);

      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
    });
    test("exercise should be set", () {
      List<Exercise> le = [Exercise(name: "Test Exercise")];
      ForTime ft = ForTime(exercises: le);

      expect(ft.exercises.length, 1);
      expect(ft.exercises[0], le[0]);
    });
    test("assertion should throw errors (sets)", () {
      expect(() => ForTime(sets: 0), throwsAssertionError);
      expect(() => ForTime(sets: -1), throwsAssertionError);
    });
    test("assertion should throw errors (rest)", () {
      expect(() => ForTime(restMinutes: -1), throwsAssertionError);
      expect(() => ForTime(restMinutes: 61), throwsAssertionError);
      expect(() => ForTime(restSeconds: -1), throwsAssertionError);
      expect(() => ForTime(restSeconds: 61), throwsAssertionError);
    });
    test("assertion should throw errors (cap)", () {
      expect(() => ForTime(capMinutes: -1), throwsAssertionError);
      expect(() => ForTime(capMinutes: 61), throwsAssertionError);
      expect(() => ForTime(capSeconds: -1), throwsAssertionError);
      expect(() => ForTime(capSeconds: 61), throwsAssertionError);
    });
  });

  group("For Time JSON", () {
    test("rest should be 0:00, cap should be 0:00 (full json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 1,"rest_duration": {"min": 0,"sec": 0},"cap_duration": {"min": 0,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("rest should be 0:00 (no rest)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 1,"cap_duration": {"min": 0,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("cap should be 0:00 (no cap)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 1},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("sets should be 1 (no set)", () {
      String jsonString =
          '{"type": 2,"details": {},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test(
        "sets should be 1, rest should be 0:00, cap should be 0:00 (no details)",
        () {
      String jsonString =
          '{"type": 2,"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("rest should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 0,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(seconds: 30));
      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("rest should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(seconds: 30));
      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("rest should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 0},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1));
      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("rest should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1));
      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("rest should be 1:30", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("cap should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 0,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
      expect(ft.cap, const Duration(seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("cap should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
      expect(ft.cap, const Duration(seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("cap should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
      expect(ft.cap, const Duration(minutes: 1));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("cap should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec":30},"cap_duration": {"min": 1}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
      expect(ft.cap, const Duration(minutes: 1));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("cap should be 1:30", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 2);
      expect(ft.rest, const Duration(minutes: 1, seconds: 30));
      expect(ft.cap, const Duration(minutes: 1, seconds: 30));
      expect(ft.exercises.length, 1);
      expect(ft.exercises[0].name, "test");
    });
    test("exercises should be empty (full json)", () {
      String jsonString = '{"type": 2,"exercises": []}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 0);
    });
    test("exercises should be empty (no json)", () {
      String jsonString = '{"type": 2}';
      ForTime ft = ForTime.fromJson(json.decode(jsonString));

      expect(ft.sets, 1);
      expect(ft.rest, Duration.zero);
      expect(ft.cap, Duration.zero);
      expect(ft.exercises.length, 0);
    });
    test("assertion should throw error (sets null)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 0,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (sets negative)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": -1,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest minutes negative)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": -1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest seconds negative)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": -1},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest minutes greater than 60)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 61,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest seconds greater than 60)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 61},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });

    test("assertion should throw error (cap minutes negative)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": -1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (cap seconds negative)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": -1}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (cap minutes greater than 60)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 61,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (cap seconds greater than 60)", () {
      String jsonString =
          '{"type": 2,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 61}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ForTime.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
  });

  group("For Time ToString", () {
    test("should be \"For Time\"", () {
      ForTime ft = ForTime();

      expect(ft.toString(), "For Time");
    });
    test("should be \"For Time 30\" \"", () {
      ForTime ft = ForTime(
        capSeconds: 30,
      );

      expect(ft.toString(), "For Time 30\"");
    });
    test("should be \"For Time 1'\"", () {
      ForTime ft = ForTime(
        capMinutes: 1,
      );

      expect(ft.toString(), "For Time 1'");
    });
    test("should be \"For Time 1'30\" \"", () {
      ForTime ft = ForTime(
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(ft.toString(), "For Time 1'30\"");
    });
    test("should be \"2 Cycles [For Time 1'30\"] - 30\" Repos\"", () {
      ForTime ft = ForTime(
        sets: 2,
        restSeconds: 30,
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(ft.toString(), "2 Cycles [For Time 1'30\"] - 30\" Repos");
    });
    test("should be \"2 Cycles [For Time -> 1'30\"] - 1' Repos\"", () {
      ForTime ft = ForTime(
        sets: 2,
        restMinutes: 1,
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(ft.toString(), "2 Cycles [For Time 1'30\"] - 1' Repos");
    });
    test("should be \"2 Cycles [For Time 1'30\"] - 1'30\" Repos\"", () {
      ForTime ft = ForTime(
        sets: 2,
        restMinutes: 1,
        restSeconds: 30,
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(ft.toString(), "2 Cycles [For Time 1'30\"] - 1'30\" Repos");
    });
    test("should be \"2 Cycles [For Time] - 1'30\" Repos\"", () {
      ForTime ft = ForTime(
        sets: 2,
        restMinutes: 1,
        restSeconds: 30,
      );

      expect(ft.toString(), "2 Cycles [For Time] - 1'30\" Repos");
    });
  });
}
