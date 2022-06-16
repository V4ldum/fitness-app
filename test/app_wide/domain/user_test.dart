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
      },
    );
    test(
      "full construction is correct",
      () {
        User sut = User(
          username: "test",
          fullName: "test user",
          permissions: [0],
        );

        expect(sut.username, "test");
        expect(sut.fullName, "test user");
        expect(sut.permissions.length, 1);
        expect(sut.permissions[0], Permission.Daily);
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
        expect(sut.permissions[0], Permission.Daily);
        expect(sut.permissions[1], Permission.Other);
      },
    );
  });

  group("User JSON", () {
    test("full construction", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[0]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 1);
      expect(sut.permissions[0], Permission.Daily);
    });
    test("permissions array empty", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 0);
    });
    test("permissions array missing", () {
      String jsonString = '{"username":"test","full_name":"test user"}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 0);
    });
    test("permissions array has multiple values", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[0, 1]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 2);
      expect(sut.permissions[0], Permission.Daily);
      expect(sut.permissions[1], Permission.Other);
    });
    test("permissions array has multiple values unsorted", () {
      String jsonString =
          '{"username":"test","full_name":"test user","permissions":[1, 0]}';
      User sut = User.fromJson(json.decode(jsonString));

      expect(sut.username, "test");
      expect(sut.fullName, "test user");
      expect(sut.permissions.length, 2);
      expect(sut.permissions[0], Permission.Other);
      expect(sut.permissions[1], Permission.Daily);
    });
  });
}
