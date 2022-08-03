import 'dart:convert';

import 'package:fitness_app/features/main/domain/models/emom.dart';
import 'package:fitness_app/features/main/domain/models/exercise.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("EMOM Constructor", () {
    test("default exercise set", () {
      EMOM e = EMOM();

      expect(e.sets, 1);

      expect(e.rest.inSeconds, 0);
      expect(e.rest.inMinutes, 0);
      expect(e.rest, Duration.zero);

      expect(e.cap.inSeconds, 0);
      expect(e.cap.inMinutes, 0);
      expect(e.cap, Duration.zero);

      expect(e.work.inSeconds, 60);
      expect(e.work.inMinutes, 1);
      expect(e.work, const Duration(minutes: 1));

      expect(e.exercises.length, 0);

      expect(e.videoAsset, "");
    });
    test("set should be 1", () {
      EMOM e = EMOM(sets: 1);

      expect(e.sets, 1);
    });
    test("rest should be 0:30 (full construction)", () {
      EMOM e = EMOM(restMinutes: 0, restSeconds: 30);

      expect(e.rest, const Duration(seconds: 30));
    });
    test("rest should be 0:30 (partial construction)", () {
      EMOM e = EMOM(restSeconds: 30);

      expect(e.rest, const Duration(seconds: 30));
    });
    test("rest should be 1:00 (full construction)", () {
      EMOM e = EMOM(restMinutes: 1, restSeconds: 0);

      expect(e.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:00 (partial construction)", () {
      EMOM e = EMOM(restMinutes: 1);

      expect(e.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:30", () {
      EMOM e = EMOM(restMinutes: 1, restSeconds: 30);

      expect(e.rest, const Duration(minutes: 1, seconds: 30));
    });
    test("cap should be 0:30 (full construction)", () {
      EMOM e = EMOM(capMinutes: 0, capSeconds: 30);

      expect(e.cap, const Duration(seconds: 30));
    });
    test("cap should be 0:30 (partial construction)", () {
      EMOM e = EMOM(capSeconds: 30);

      expect(e.cap, const Duration(seconds: 30));
    });
    test("cap should be 1:00 (full construction)", () {
      EMOM e = EMOM(capMinutes: 1, capSeconds: 0);

      expect(e.cap, const Duration(minutes: 1));
    });
    test("cap should be 1:00 (partial construction)", () {
      EMOM e = EMOM(capMinutes: 1);

      expect(e.cap, const Duration(minutes: 1));
    });
    test("cap should be 1:30", () {
      EMOM e = EMOM(capMinutes: 1, capSeconds: 30);

      expect(e.cap, const Duration(minutes: 1, seconds: 30));
    });
    test("work should be 0:30 (full construction)", () {
      EMOM e = EMOM(workMinutes: 0, workSeconds: 30);

      expect(e.work, const Duration(seconds: 30));
    });
    test("work should be 0:30 (partial construction)", () {
      EMOM e = EMOM(workSeconds: 30);

      expect(e.work, const Duration(seconds: 30));
    });
    test("work should be 1:00 (full construction)", () {
      EMOM e = EMOM(workMinutes: 1, workSeconds: 0);

      expect(e.work, const Duration(minutes: 1));
    });
    test("work should be 1:00 (partial construction)", () {
      EMOM e = EMOM(workMinutes: 1);

      expect(e.work, const Duration(minutes: 1));
    });
    test("work should be 1:30", () {
      EMOM e = EMOM(workMinutes: 1, workSeconds: 30);

      expect(e.work, const Duration(minutes: 1, seconds: 30));
    });
    test("exercise should be set", () {
      List<Exercise> le = [Exercise(name: "Test Exercise")];
      EMOM e = EMOM(exercises: le);

      expect(e.exercises.length, 1);
      expect(e.exercises[0], le[0]);
    });
    test("videoAsset should be assets/TEST", () {
      EMOM e = EMOM(videoAsset: "assets/TEST");

      expect(e.videoAsset, "assets/TEST");
    });
    test("assertion should throw errors (sets)", () {
      expect(() => EMOM(sets: 0), throwsAssertionError);
      expect(() => EMOM(sets: -1), throwsAssertionError);
    });
    test("assertion should throw errors (rest)", () {
      expect(() => EMOM(restMinutes: -1), throwsAssertionError);
      expect(() => EMOM(restMinutes: 61), throwsAssertionError);
      expect(() => EMOM(restSeconds: -1), throwsAssertionError);
      expect(() => EMOM(restSeconds: 61), throwsAssertionError);
    });
    test("assertion should throw errors (cap)", () {
      expect(() => EMOM(capMinutes: -1), throwsAssertionError);
      expect(() => EMOM(capMinutes: 61), throwsAssertionError);
      expect(() => EMOM(capSeconds: -1), throwsAssertionError);
      expect(() => EMOM(capSeconds: 61), throwsAssertionError);
    });
    test("assertion should throw errors (work)", () {
      expect(() => EMOM(workMinutes: -1), throwsAssertionError);
      expect(() => EMOM(workMinutes: 61), throwsAssertionError);
      expect(() => EMOM(workSeconds: -1), throwsAssertionError);
      expect(() => EMOM(workSeconds: 61), throwsAssertionError);
    });
  });

  group("EMOM JSON", () {
    test(
        "rest should be 0:00, cap should be 0:00, work should be 1:00 (full json)",
        () {
      String jsonString =
          '{"type": 3,"video":"assets/TEST","details": {"sets": 1,"rest_duration": {"min": 0,"sec": 0},"cap_duration": {"min": 0,"sec": 0},"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "assets/TEST");
    });
    test("rest should be 0:00 (no rest)", () {
      String jsonString =
          '{"type": 3,"video":"assets/TEST","details": {"sets": 1,"cap_duration": {"min": 0,"sec": 0},"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "assets/TEST");
    });
    test("cap should be 0:00 (no cap)", () {
      String jsonString =
          '{"type": 3,"video":"assets/TEST","details": {"sets": 1,"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "assets/TEST");
    });
    test("work should be 1:00 (no work)", () {
      String jsonString =
          '{"type": 3,"video":"assets/TEST","details": {"sets": 1},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "assets/TEST");
    });
    test("sets should be 1 (no set)", () {
      String jsonString =
          '{"type": 3,"video":"assets/TEST","details": {},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "assets/TEST");
    });
    test(
        "sets should be 1, rest should be 0:00, cap should be 0:00, work should be 1:00 (no details)",
        () {
      String jsonString =
          '{"type": 3,"video":"assets/TEST","exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "assets/TEST");
    });
    test("videoAsset should be empty", () {
      String jsonString =
          '{"type": 3,"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
      expect(e.videoAsset, "");
    });
    test("rest should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 0,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("rest should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("rest should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 0},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("rest should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("rest should be 1:30", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("cap should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 0,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("cap should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("cap should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 0},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("cap should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("cap should be 1:30", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("work should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 0,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("work should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("work should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("work should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("work should be 1:30", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 2);
      expect(e.rest, const Duration(minutes: 1, seconds: 30));
      expect(e.cap, const Duration(minutes: 1, seconds: 30));
      expect(e.work, const Duration(minutes: 1, seconds: 30));
      expect(e.exercises.length, 1);
      expect(e.exercises[0].name, "test");
    });
    test("exercises should be empty (full json)", () {
      String jsonString = '{"type": 3,"exercises": []}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 0);
    });
    test("exercises should be empty (no json)", () {
      String jsonString = '{"type": 3}';
      EMOM e = EMOM.fromJson(json.decode(jsonString));

      expect(e.sets, 1);
      expect(e.rest, Duration.zero);
      expect(e.cap, Duration.zero);
      expect(e.work, const Duration(minutes: 1));
      expect(e.exercises.length, 0);
    });
    test("assertion should throw error (sets null)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 0,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (sets negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": -1,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest minutes negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": -1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest seconds negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": -1},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest minutes greater than 60)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 61,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest seconds greater than 60)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 61},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap minutes negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": -1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap seconds negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": -1},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap minutes greater than 60)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 61,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (cap seconds greater than 60)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 61},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work minutes negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": -1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work seconds negative)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": -1}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work minutes greater than 60)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 61,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work seconds greater than 60)", () {
      String jsonString =
          '{"type": 3,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"cap_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 61}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => EMOM.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
  });

  group("EMOM ToString", () {
    test("should be \"EMOM -> 30\"\"", () {
      EMOM e = EMOM(
        capSeconds: 30,
      );

      expect(e.toString(), "EMOM -> 30\"");
    });
    test("should be \"EMOM -> 1'\"", () {
      EMOM e = EMOM(
        capMinutes: 1,
      );

      expect(e.toString(), "EMOM -> 1'");
    });
    test("should be \"EMOM -> 1'30\"\"", () {
      EMOM e = EMOM(
        capMinutes: 1,
        capSeconds: 30,
      );

      expect(e.toString(), "EMOM -> 1'30\"");
    });
    test("should be \"EMOM 30\" -> 1'30\"\"", () {
      EMOM e = EMOM(
        capMinutes: 1,
        capSeconds: 30,
        workSeconds: 30,
      );

      expect(e.toString(), "EMOM 30\" -> 1'30\"");
    });
    test("should be \"EMOM -> 1'30\"\"", () {
      EMOM e = EMOM(
        capMinutes: 1,
        capSeconds: 30,
        workMinutes: 1,
      );

      expect(e.toString(), "EMOM -> 1'30\"");
    });
    test("should be \"EMOM 1'30\" -> 1'30\"\"", () {
      EMOM e = EMOM(
        capMinutes: 1,
        capSeconds: 30,
        workMinutes: 1,
        workSeconds: 30,
      );

      expect(e.toString(), "EMOM 1'30\" -> 1'30\"");
    });
    test("should be \"2 Cycles [EMOM 1'30\" -> 1'30\"] - 30\" Repos\"", () {
      EMOM e = EMOM(
        sets: 2,
        restSeconds: 30,
        capMinutes: 1,
        capSeconds: 30,
        workMinutes: 1,
        workSeconds: 30,
      );

      expect(e.toString(), "2 Cycles [EMOM 1'30\" -> 1'30\"] - 30\" Repos");
    });
    test("should be \"2 Cycles [EMOM 1'30\" -> 1'30\"] - 1' Repos\"", () {
      EMOM e = EMOM(
        sets: 2,
        restMinutes: 1,
        capMinutes: 1,
        capSeconds: 30,
        workMinutes: 1,
        workSeconds: 30,
      );

      expect(e.toString(), "2 Cycles [EMOM 1'30\" -> 1'30\"] - 1' Repos");
    });
    test("should be \"2 Cycles [EMOM 1'30\" -> 1'30\"] - 1'30\" Repos\"", () {
      EMOM e = EMOM(
        sets: 2,
        restMinutes: 1,
        restSeconds: 30,
        capMinutes: 1,
        capSeconds: 30,
        workMinutes: 1,
        workSeconds: 30,
      );

      expect(e.toString(), "2 Cycles [EMOM 1'30\" -> 1'30\"] - 1'30\" Repos");
    });
    test("should be \"2 Cycles [EMOM 1'30\" -> 1'30\"] - 1'30\" Repos\"", () {
      EMOM e = EMOM(
        sets: 2,
        restMinutes: 1,
        restSeconds: 30,
        capMinutes: 1,
        capSeconds: 30,
      );

      expect(e.toString(), "2 Cycles [EMOM -> 1'30\"] - 1'30\" Repos");
    });
  });
}
