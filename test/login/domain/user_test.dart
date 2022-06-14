import 'dart:convert';

import 'package:fitness_app/features/app_wide/domain/models/permission.dart';
import 'package:fitness_app/features/app_wide/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("User Construction", () {
    test(
      "default values are correct",
      () {
        User sut = User(username: "", fullName: "");

        expect(sut.username, "");
        expect(sut.fullName, "");
        expect(sut.permissions.length, 0);
        expect(sut.imagePath, null);
      },
    );
    test(
      "full construction is correct",
      () {
        User sut = User(
          username: "test",
          fullName: "test user",
          imagePath: "path",
          permissions: [0],
        );

        expect(sut.username, "test");
        expect(sut.fullName, "test user");
        expect(sut.permissions.length, 1);
        expect(sut.permissions[0], Permission.daily);
        expect(sut.imagePath, "path");
      },
    );
    test(
      "permission array with multiple values inside",
      () {
        User sut = User(
          username: "",
          fullName: "",
          permissions: [0, 1],
        );
        expect(sut.permissions.length, 2);
        expect(sut.permissions[0], Permission.daily);
        expect(sut.permissions[1], Permission.other);
      },
    );
  });

  group("User JSON", () {
    test("full construction", () {
      String jsonString =
          '{"username":"test","full_name":"test user","image_path":"path","permissions":[0]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 1);
      expect(sut.permissions[0], Permission.daily);
      expect(sut.imagePath, "path");
    });
    test("imagePath is null", () {
      String jsonString =
          '{"username":"test","full_name":"test user","image_path":null,"permissions":[0]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 1);
      expect(sut.permissions[0], Permission.daily);
      expect(sut.imagePath, null);
    });
    test("imagePath is missing", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[0]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 1);
      expect(sut.permissions[0], Permission.daily);
      expect(sut.imagePath, null);
    });
    test("permissions array empty", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 0);
      expect(sut.imagePath, null);
    });
    test("permissions array missing", () {
      String jsonString = '{"username":"test","full_name":"test user"}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 0);
      expect(sut.imagePath, null);
    });
    test("permissions array has multiple values", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[0, 1]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 2);
      expect(sut.permissions[0], Permission.daily);
      expect(sut.permissions[1], Permission.other);
      expect(sut.imagePath, null);
    });
    test("permissions array has multiple values unsorted", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[1, 0]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 2);
      expect(sut.permissions[0], Permission.other);
      expect(sut.permissions[1], Permission.daily);
      expect(sut.imagePath, null);
    });
  });
}
