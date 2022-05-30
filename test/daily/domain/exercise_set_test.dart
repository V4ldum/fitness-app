import 'dart:convert';

import 'package:fitness_app/features/daily/domain/models/exercise.dart';
import 'package:fitness_app/features/daily/domain/models/exercise_set.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Exercise Set Constructor", () {
    test("default exercise set", () {
      ExerciseSet es = ExerciseSet();

      expect(es.sets, 1);

      expect(es.rest.inSeconds, 0);
      expect(es.rest.inMinutes, 0);
      expect(es.rest, Duration.zero);

      expect(es.exercises.length, 0);

      expect(es.videoAsset, "");
    });
    test("set should be 1", () {
      ExerciseSet es = ExerciseSet(sets: 1);

      expect(es.sets, 1);
    });
    test("rest should be 0:30 (full construction)", () {
      ExerciseSet es = ExerciseSet(restMinutes: 0, restSeconds: 30);

      expect(es.rest, const Duration(seconds: 30));
    });
    test("rest should be 0:30 (partial construction)", () {
      ExerciseSet es = ExerciseSet(restSeconds: 30);

      expect(es.rest, const Duration(seconds: 30));
    });
    test("rest should be 1:00 (full construction)", () {
      ExerciseSet es = ExerciseSet(restMinutes: 1, restSeconds: 0);

      expect(es.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:00 (partial construction)", () {
      ExerciseSet es = ExerciseSet(restMinutes: 1);

      expect(es.rest, const Duration(minutes: 1));
    });
    test("rest should be 1:30", () {
      ExerciseSet es = ExerciseSet(restMinutes: 1, restSeconds: 30);

      expect(es.rest, const Duration(minutes: 1, seconds: 30));
    });
    test("exercise should be set", () {
      List<Exercise> le = [Exercise(name: "Test Exercise")];
      ExerciseSet es = ExerciseSet(exercises: le);

      expect(es.exercises.length, 1);
      expect(es.exercises[0], le[0]);
    });
    test("videoAsset should be assets/TEST", () {
      ExerciseSet es = ExerciseSet(videoAsset: "assets/TEST");

      expect(es.videoAsset, "assets/TEST");
    });
    test("assertion should throw errors (sets)", () {
      expect(() => ExerciseSet(sets: 0), throwsAssertionError);
      expect(() => ExerciseSet(sets: -1), throwsAssertionError);
    });
    test("assertion should throw errors (rest)", () {
      expect(() => ExerciseSet(restMinutes: -1), throwsAssertionError);
      expect(() => ExerciseSet(restMinutes: 61), throwsAssertionError);
      expect(() => ExerciseSet(restSeconds: -1), throwsAssertionError);
      expect(() => ExerciseSet(restSeconds: 61), throwsAssertionError);
    });
  });

  group("Exercise Set JSON", () {
    test("rest should be 0:00 (full json)", () {
      String jsonString =
          '{"type": 0,"video":"assets/TEST","details": {"sets": 1,"rest_duration": {"min": 0,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
      expect(es.videoAsset, "assets/TEST");
    });
    test("rest should be 0:00 (no rest)", () {
      String jsonString =
          '{"type": 0,"video":"assets/TEST","details": {"sets": 1},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
      expect(es.videoAsset, "assets/TEST");
    });
    test("sets should be 1 (no set)", () {
      String jsonString =
          '{"type": 0,"video":"assets/TEST","details": {},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
      expect(es.videoAsset, "assets/TEST");
    });
    test("sets should be 1, rest should be 0:00 (no details)", () {
      String jsonString =
          '{"type": 0,"video":"assets/TEST","exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
      expect(es.videoAsset, "assets/TEST");
    });
    test("assetVideo should be empty", () {
      String jsonString =
          '{"type": 0,"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
      expect(es.videoAsset, "");
    });
    test("rest should be 0:30 (full json)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"min": 0,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 2);
      expect(es.rest, const Duration(seconds: 30));
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
    });
    test("rest should be 0:30 (partial json)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 2);
      expect(es.rest, const Duration(seconds: 30));
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
    });
    test("rest should be 1:00 (full json)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 0}},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 2);
      expect(es.rest, const Duration(minutes: 1));
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
    });
    test("rest should be 1:00 (partial json)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"min": 1}},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 2);
      expect(es.rest, const Duration(minutes: 1));
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
    });
    test("rest should be 1:30", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 2);
      expect(es.rest, const Duration(minutes: 1, seconds: 30));
      expect(es.exercises.length, 1);
      expect(es.exercises[0].name, "test");
    });
    test("exercises should be empty (full json)", () {
      String jsonString = '{"type": 0,"exercises": []}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 0);
    });
    test("exercises should be empty (no json)", () {
      String jsonString = '{"type": 0}';
      ExerciseSet es = ExerciseSet.fromJson(json.decode(jsonString));

      expect(es.sets, 1);
      expect(es.rest, Duration.zero);
      expect(es.exercises.length, 0);
    });
    test("assertion should throw error (sets null)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 0,"rest_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ExerciseSet.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (sets negative)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": -1,"rest_duration": {"min": 1,"sec": 30}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ExerciseSet.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest minutes negative)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"min": -1}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ExerciseSet.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest seconds negative)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"sec": -1}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ExerciseSet.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest minutes greater than 60)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"min": 61}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ExerciseSet.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
    test("assertion should throw error (rest seconds greater than 60)", () {
      String jsonString =
          '{"type": 0,"details": {"sets": 2,"rest_duration": {"sec": 61}},"exercises": [{"name": "test","assets": "test"}]}';

      expect(() => ExerciseSet.fromJson(json.decode(jsonString)),
          throwsAssertionError);
    });
  });

  group("Exercise Set ToString", () {
    test("should be \"1 Série\"", () {
      ExerciseSet es = ExerciseSet();

      expect(es.toString(), "1 Série");
    });
    test("should be \"2 Séries - 30\" Repos\"", () {
      ExerciseSet es = ExerciseSet(
        sets: 2,
        restSeconds: 30,
      );

      expect(es.toString(), "2 Séries - 30\" Repos");
    });
    test("should be \"2 Séries - 1' Repos\"", () {
      ExerciseSet es = ExerciseSet(
        sets: 2,
        restMinutes: 1,
      );

      expect(es.toString(), "2 Séries - 1' Repos");
    });
    test("should be \"2 Séries - 1'30\" Repos\"", () {
      ExerciseSet es = ExerciseSet(
        sets: 2,
        restSeconds: 30,
        restMinutes: 1,
      );

      expect(es.toString(), "2 Séries - 1'30\" Repos");
    });
  });
}
