import 'dart:convert';

import 'package:fitness_app/model/exercise.dart';
import 'package:fitness_app/model/tabata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Tabata Constructor", () {
    test("default exercise set", () {
      Tabata t = Tabata();

      expect(t.sets, 1);

      expect(t.rest.inSeconds, 0);
      expect(t.rest.inMinutes, 0);
      expect(t.rest, Duration.zero);

      expect(t.work.inSeconds, 0);
      expect(t.work.inMinutes, 0);
      expect(t.work, Duration.zero);

      expect(t.pause.inSeconds, 0);
      expect(t.pause.inMinutes, 0);
      expect(t.pause, Duration.zero);

      expect(t.exercises.length, 0);
    });
    test("set should be 1", () {
      Tabata t = Tabata(sets: 1);

      expect(t.sets, 1);
    });
    test("rest should be 0:30 (full construction)", () {
      Tabata t = Tabata(restMinutes: 0, restSeconds: 30);

      expect(t.rest, const Duration(seconds: 30));
    });
    test("rest should be 0:30 (partial construction)", () {
      Tabata t = Tabata(restSeconds: 30);

      expect(t.rest, const Duration(seconds: 30));
    });
    test("rest should be 1:00 (full construction)", () {
      Tabata t = Tabata(restMinutes: 1, restSeconds: 0);

      expect(t.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:00 (partial construction)", () {
      Tabata t = Tabata(restMinutes: 1);

      expect(t.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:30", () {
      Tabata t = Tabata(restMinutes: 1, restSeconds: 30);

      expect(t.rest, const Duration(minutes: 1, seconds: 30));
    });
    test("work should be 0:30 (full construction)", () {
      Tabata t = Tabata(workMinutes: 0, workSeconds: 30);

      expect(t.work, const Duration(seconds: 30));
    });
    test("work should be 0:30 (partial construction)", () {
      Tabata t = Tabata(workSeconds: 30);

      expect(t.work, const Duration(seconds: 30));
    });
    test("work should be 1:00 (full construction)", () {
      Tabata t = Tabata(workMinutes: 1, workSeconds: 0);

      expect(t.work, const Duration(minutes: 1));
    });
    test("work should be 1:00 (partial construction)", () {
      Tabata t = Tabata(workMinutes: 1);

      expect(t.work, const Duration(minutes: 1));
    });
    test("work should be 1:30", () {
      Tabata t = Tabata(workMinutes: 1, workSeconds: 30);

      expect(t.work, const Duration(minutes: 1, seconds: 30));
    });
    test("pause should be 0:30 (full construction)", () {
      Tabata t = Tabata(pauseMinutes: 0, pauseSeconds: 30);

      expect(t.pause, const Duration(seconds: 30));
    });
    test("pause should be 0:30 (partial construction)", () {
      Tabata t = Tabata(pauseSeconds: 30);

      expect(t.pause, const Duration(seconds: 30));
    });
    test("pause should be 1:00 (full construction)", () {
      Tabata t = Tabata(pauseMinutes: 1, pauseSeconds: 0);

      expect(t.pause, const Duration(minutes: 1));
    });
    test("pause should be 1:00 (partial construction)", () {
      Tabata t = Tabata(pauseMinutes: 1);

      expect(t.pause, const Duration(minutes: 1));
    });
    test("pause should be 1:30", () {
      Tabata t = Tabata(pauseMinutes: 1, pauseSeconds: 30);

      expect(t.pause, const Duration(minutes: 1, seconds: 30));
    });
    test("exercise should be set", () {
      List<Exercise> le = [Exercise(name: "Test Exercise")];
      Tabata t = Tabata(exercises: le);

      expect(t.exercises.length, 1);
      expect(t.exercises[0], le[0]);
    });
    test("assertion should throw errors (sets)", () {
      expect(() => Tabata(sets: 0), throwsAssertionError);
      expect(() => Tabata(sets: -1), throwsAssertionError);
    });
    test("assertion should throw errors (rest)", () {
      expect(() => Tabata(restMinutes: -1), throwsAssertionError);
      expect(() => Tabata(restMinutes: 61), throwsAssertionError);
      expect(() => Tabata(restSeconds: -1), throwsAssertionError);
      expect(() => Tabata(restSeconds: 61), throwsAssertionError);
    });
    test("assertion should throw errors (work)", () {
      expect(() => Tabata(workMinutes: -1), throwsAssertionError);
      expect(() => Tabata(workMinutes: 61), throwsAssertionError);
      expect(() => Tabata(workSeconds: -1), throwsAssertionError);
      expect(() => Tabata(workSeconds: 61), throwsAssertionError);
    });
    test("assertion should throw errors (pause)", () {
      expect(() => Tabata(pauseMinutes: -1), throwsAssertionError);
      expect(() => Tabata(pauseMinutes: 61), throwsAssertionError);
      expect(() => Tabata(pauseSeconds: -1), throwsAssertionError);
      expect(() => Tabata(pauseSeconds: 61), throwsAssertionError);
    });
  });

  group("Tabata JSON", () {
    test(
        "rest should be 0:00, pause should be 0:00, work should be 1:00 (full json)",
        () {
      String jsonString =
          '{"type": 4,"details": {"sets": 1,"rest_duration": {"min": 0,"sec": 0},"pause_duration": {"min": 0,"sec": 0},"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, const Duration(minutes: 1));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("rest should be 0:00 (no rest)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 1,"pause_duration": {"min": 0,"sec": 0},"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, const Duration(minutes: 1));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("pause should be 0:00 (no pause)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 1,"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, const Duration(minutes: 1));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("work should be 1:00 (no work)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 1},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, Duration.zero);
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("sets should be 1 (no set)", () {
      String jsonString =
          '{"type": 4,"details": {},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, Duration.zero);
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test(
        "sets should be 1, rest should be 0:00, pause should be 0:00, work should be 1:00 (no details)",
        () {
      String jsonString =
          '{"type": 4,"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, Duration.zero);
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("rest should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 0,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("rest should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("rest should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 0},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("rest should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("rest should be 1:30", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("pause should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 0,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("pause should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("pause should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 0},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("pause should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("pause should be 1:30", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("work should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 0,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("work should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("work should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("work should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("work should be 1:30", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 2);
      expect(t.rest, const Duration(minutes: 1, seconds: 30));
      expect(t.pause, const Duration(minutes: 1, seconds: 30));
      expect(t.work, const Duration(minutes: 1, seconds: 30));
      expect(t.exercises.length, 1);
      expect(t.exercises[0].name, "test");
    });
    test("exercises should be empty (full json)", () {
      String jsonString = '{"type": 4,"exercises": []}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, Duration.zero);
      expect(t.exercises.length, 0);
    });
    test("exercises should be empty (no json)", () {
      String jsonString = '{"type": 4}';
      Tabata t = Tabata.fromJson(json.decode(jsonString));

      expect(t.sets, 1);
      expect(t.rest, Duration.zero);
      expect(t.pause, Duration.zero);
      expect(t.work, Duration.zero);
      expect(t.exercises.length, 0);
    });
    test("assertion should throw error (sets null)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 0,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (sets negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": -1,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest minutes negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": -1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest seconds negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": -1},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest minutes greater than 60)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 61,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (rest seconds greater than 60)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 61},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (pause minutes negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": -1,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (pause seconds negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": -1},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (pause minutes greater than 60)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 61,"sec": 30},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (pause seconds greater than 60)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 61},"work_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work minutes negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": -1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work seconds negative)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": -1}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work minutes greater than 60)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 61,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
    test("assertion should throw error (work seconds greater than 60)", () {
      String jsonString =
          '{"type": 4,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30},"pause_duration": {"min": 1,"sec": 30},"work_duration": {"min": 1,"sec": 61}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(
          () => Tabata.fromJson(json.decode(jsonString)), throwsAssertionError);
    });
  });

  group("Tabata ToString", () {
    test("should be \"1 Cycle [1'30\" Work - 30\" Rest]\"", () {
      Tabata t = Tabata(
        workMinutes: 1,
        workSeconds: 30,
        restSeconds: 30,
      );

      expect(t.toString(), "1 Cycle [1'30\" Work - 30\" Rest]");
    });
    test("should be \"1 Cycle [1'30\" Work - 1' Rest]\"", () {
      Tabata t = Tabata(
        workMinutes: 1,
        workSeconds: 30,
        restMinutes: 1,
      );

      expect(t.toString(), "1 Cycle [1'30\" Work - 1' Rest]");
    });
    test("should be \"1 Cycle [1'30\" Work - 1'30\" Rest]\"", () {
      Tabata t = Tabata(
        workMinutes: 1,
        workSeconds: 30,
        restMinutes: 1,
        restSeconds: 30,
      );

      expect(t.toString(), "1 Cycle [1'30\" Work - 1'30\" Rest]");
    });
    test("should be \"1 Cycle [1' Work - 1'30\" Rest]\"", () {
      Tabata t = Tabata(
        workMinutes: 1,
        restMinutes: 1,
        restSeconds: 30,
      );

      expect(t.toString(), "1 Cycle [1' Work - 1'30\" Rest]");
    });
    test("should be \"1 Cycle [30\" Work - 1'30\" Rest]\"", () {
      Tabata t = Tabata(
        workSeconds: 30,
        restMinutes: 1,
        restSeconds: 30,
      );

      expect(t.toString(), "1 Cycle [30\" Work - 1'30\" Rest]");
    });
    test("should be \"2 Cycles [1'30\" Work - 1'30\" Rest] - 30\" Pause\"", () {
      Tabata t = Tabata(
        sets: 2,
        workMinutes: 1,
        workSeconds: 30,
        restMinutes: 1,
        restSeconds: 30,
        pauseSeconds: 30,
      );

      expect(t.toString(), "2 Cycles [1'30\" Work - 1'30\" Rest] - 30\" Pause");
    });
    test("should be \"2 Cycles [1'30\" Work - 1'30\" Rest] - 1' Pause\"", () {
      Tabata t = Tabata(
        sets: 2,
        workMinutes: 1,
        workSeconds: 30,
        restMinutes: 1,
        restSeconds: 30,
        pauseMinutes: 1,
      );

      expect(t.toString(), "2 Cycles [1'30\" Work - 1'30\" Rest] - 1' Pause");
    });
    test("should be \"2 Cycles [1'30\" Work - 1'30\" Rest] - 1'30\" Pause\"",
        () {
      Tabata t = Tabata(
        sets: 2,
        workMinutes: 1,
        workSeconds: 30,
        restMinutes: 1,
        restSeconds: 30,
        pauseMinutes: 1,
        pauseSeconds: 30,
      );

      expect(
          t.toString(), "2 Cycles [1'30\" Work - 1'30\" Rest] - 1'30\" Pause");
    });
  });
}
