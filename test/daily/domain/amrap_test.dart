import 'dart:convert';

import 'package:fitness_app/features/daily/domain/models/amrap.dart';
import 'package:fitness_app/features/daily/domain/models/exercise.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AMRAP Constructor", () {
    test("default exercise set", () {
      AMRAP a = AMRAP();

      expect(a.sets, 1);

      expect(a.rest.inSeconds, 0);
      expect(a.rest.inMinutes, 0);
      expect(a.rest, Duration.zero);

      expect(a.cap.inSeconds, 0);
      expect(a.cap.inMinutes, 0);
      expect(a.cap, Duration.zero);

      expect(a.exercises.length, 0);

      expect(a.videoAsset, "");
    });
    test("set should be 1", () {
      AMRAP a = AMRAP(sets: 1);

      expect(a.sets, 1);
    });
    test("rest should be 0:30 (full construction)", () {
      AMRAP a = AMRAP(restMinutes: 0, restSeconds: 30);

      expect(a.rest, const Duration(seconds: 30));
    });
    test("rest should be 0:30 (partial construction)", () {
      AMRAP a = AMRAP(restSeconds: 30);

      expect(a.rest, const Duration(seconds: 30));
    });
    test("rest should be 1:00 (full construction)", () {
      AMRAP a = AMRAP(restMinutes: 1, restSeconds: 0);

      expect(a.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:00 (partial construction)", () {
      AMRAP a = AMRAP(restMinutes: 1);

      expect(a.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:30", () {
      AMRAP a = AMRAP(restMinutes: 1, restSeconds: 30);

      expect(a.rest, const Duration(minutes: 1, seconds: 30));
    });
    test("cap should be 0:30 (full construction)", () {
      AMRAP a = AMRAP(capMinutes: 0, capSeconds: 30);

      expect(a.cap, const Duration(seconds: 30));
    });
    test("cap should be 0:30 (partial construction)", () {
      AMRAP a = AMRAP(capSeconds: 30);

      expect(a.cap, const Duration(seconds: 30));
    });
    test("cap should be 1:00 (full construction)", () {
      AMRAP a = AMRAP(capMinutes: 1, capSeconds: 0);

      expect(a.cap, const Duration(minutes: 1));
    });
    test("cap should be 1:00 (partial construction)", () {
      AMRAP a = AMRAP(capMinutes: 1);

      expect(a.cap, const Duration(minutes: 1));
    });
    test("cap should be 1:30", () {
      AMRAP a = AMRAP(capMinutes: 1, capSeconds: 30);

      expect(a.cap, const Duration(minutes: 1, seconds: 30));
    });
    test("exercise should be set", () {
      List<Exercise> le = [Exercise(name: "Test Exercise")];
      AMRAP a = AMRAP(exercises: le);

      expect(a.exercises.length, 1);
      expect(a.exercises[0], le[0]);
    });
    test("videoAsset should be assets/TEST", () {
      AMRAP a = AMRAP(videoAsset: "assets/TEST");

      expect(a.videoAsset, "assets/TEST");
    });
    test("assertion should throw errors (sets)", () {
      expect(() => AMRAP(sets: 0), throwsAssertionError);
      expect(() => AMRAP(sets: -1), throwsAssertionError);
    });
    test("assertion should throw errors (rest)", () {
      expect(() => AMRAP(restMinutes: -1), throwsAssertionError);
      expect(() => AMRAP(restMinutes: 61), throwsAssertionError);
      expect(() => AMRAP(restSeconds: -1), throwsAssertionError);
      expect(() => AMRAP(restSeconds: 61), throwsAssertionError);
    });
    test("assertion should throw errors (cap)", () {
      expect(() => AMRAP(capMinutes: -1), throwsAssertionError);
      expect(() => AMRAP(capMinutes: 61), throwsAssertionError);
      expect(() => AMRAP(capSeconds: -1), throwsAssertionError);
      expect(() => AMRAP(capSeconds: 61), throwsAssertionError);
    });
  });

  group("AMRAP JSON", () {
    test("rest should be 0:00, cap should be 0:00 (full json)", () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","details": {"sets": 1,"rest_duration": {"min": 0,"sec": 0},"cap_duration": {"min": 0,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
      expect(a.videoAsset, "assets/TEST");
    });
    test("rest should be 0:00 (no rest)", () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","details": {"sets": 1,"cap_duration": {"min": 0,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
      expect(a.videoAsset, "assets/TEST");
    });
    test("cap should be 0:00 (no cap)", () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","details": {"sets": 1},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
      expect(a.videoAsset, "assets/TEST");
    });
    test("sets should be 1 (no set)", () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","details": {},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
      expect(a.videoAsset, "assets/TEST");
    });
    test(
        "sets should be 1, rest should be 0:00, cap should be 0:00 (no details)",
        () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
      expect(a.videoAsset, "assets/TEST");
    });
    test("videoAsset should be empty", () {
      String jsonString =
          '{"type": 1,"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
      expect(a.videoAsset, "");
    });
    test("rest should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","details": {"sets": 2,"rest_duration": {"min": 0,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(seconds: 30));
      expect(a.cap, const Duration(minutes: 1, seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("rest should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 1,"video":"assets/TEST","details": {"sets": 2,"rest_duration": {"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(seconds: 30));
      expect(a.cap, const Duration(minutes: 1, seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("rest should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 0},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1));
      expect(a.cap, const Duration(minutes: 1, seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("rest should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1));
      expect(a.cap, const Duration(minutes: 1, seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("rest should be 1:30", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1, seconds: 30));
      expect(a.cap, const Duration(minutes: 1, seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("cap should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 0,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1, seconds: 30));
      expect(a.cap, const Duration(seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("cap should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1, seconds: 30));
      expect(a.cap, const Duration(seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("cap should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1, seconds: 30));
      expect(a.cap, const Duration(minutes: 1));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("cap should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec":30},"cap_duration": {"min": 1}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1, seconds: 30));
      expect(a.cap, const Duration(minutes: 1));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("cap should be 1:30", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 2);
      expect(a.rest, const Duration(minutes: 1, seconds: 30));
      expect(a.cap, const Duration(minutes: 1, seconds: 30));
      expect(a.exercises.length, 1);
      expect(a.exercises[0].name, "test");
    });
    test("exercises should be empty (full json)", () {
      String jsonString = '{"type": 1,"exercises": []}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 0);
    });
    test("exercises should be empty (no json)", () {
      String jsonString = '{"type": 1}';
      AMRAP a = AMRAP.fromJson(json.decode(jsonString));

      expect(a.sets, 1);
      expect(a.rest, Duration.zero);
      expect(a.cap, Duration.zero);
      expect(a.exercises.length, 0);
    });
    test("assertion should throw error (sets null)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 0,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (sets negative)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": -1,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest minutes negative)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": -1,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest seconds negative)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": -1},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest minutes greater than 60)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 61,"sec": 30},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest seconds greater than 60)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 61},"cap_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });

    test("assertion should throw error (cap minutes negative)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": -1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap seconds negative)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": -1}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap minutes greater than 60)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 61,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap seconds greater than 60)", () {
      String jsonString =
          '{"type": 1,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 61}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => AMRAP.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
  });

  group("AMRAP ToString", () {
    test("should be \"AMRAP\"", () {
      AMRAP a = AMRAP();

      expect(a.toString(), "AMRAP");
    });
    test("should be \"AMRAP 30\" \"", () {
      AMRAP a = AMRAP(
        capSeconds: 30,
      );

      expect(a.toString(), "AMRAP 30\"");
    });
    test("should be \"AMRAP 1'\"", () {
      AMRAP a = AMRAP(
        capMinutes: 1,
      );

      expect(a.toString(), "AMRAP 1'");
    });
    test("should be \"AMRAP 1'30\" \"", () {
      AMRAP a = AMRAP(
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(a.toString(), "AMRAP 1'30\"");
    });
    test("should be \"2 Cycles [AMRAP 1'30\"] - 30\" Repos\"", () {
      AMRAP a = AMRAP(
        sets: 2,
        restSeconds: 30,
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(a.toString(), "2 Cycles [AMRAP 1'30\"] - 30\" Repos");
    });
    test("should be \"2 Cycles [AMRAP 1'30\"] - 1' Repos\"", () {
      AMRAP a = AMRAP(
        sets: 2,
        restMinutes: 1,
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(a.toString(), "2 Cycles [AMRAP 1'30\"] - 1' Repos");
    });
    test("should be \"2 Cycles [AMRAP 1'30\"] - 1'30\" Repos\"", () {
      AMRAP a = AMRAP(
        sets: 2,
        restMinutes: 1,
        restSeconds: 30,
        capSeconds: 30,
        capMinutes: 1,
      );

      expect(a.toString(), "2 Cycles [AMRAP 1'30\"] - 1'30\" Repos");
    });
    test("should be \"2 Cycles [AMRAP] - 1'30\" Repos\"", () {
      AMRAP a = AMRAP(
        sets: 2,
        restMinutes: 1,
        restSeconds: 30,
      );

      expect(a.toString(), "2 Cycles [AMRAP] - 1'30\" Repos");
    });
  });
}
