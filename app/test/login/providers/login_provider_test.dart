import 'package:fitness_app/features/app_wide/domain/domain.dart';
import 'package:fitness_app/features/login/domain/domain.dart';
import 'package:fitness_app/features/login/domain/services/login_service.dart';
import 'package:fitness_app/features/login/providers/login_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginService extends Mock implements LoginService {}

main() {
  late LoginProvider sut;
  late MockLoginService service;

  setUp(() {
    service = MockLoginService();
    sut = LoginProvider.fromService(service);
  });

  test(
    "Initial values are correct",
    () {
      expect(sut.username, "");
      expect(sut.password, "");
      expect(sut.isLoading, false);
    },
  );

  group("Setters are working", () {
    test(
      "set username",
      () {
        sut.username = "Testing username";
        expect(sut.username, "Testing username");
      },
    );

    test(
      "set password",
      () {
        sut.password = "Testing password";
        expect(sut.password, "Testing password");
      },
    );
  });

  group("login()", () {
    void arrangeLoginServiceLoginDefaultValues() {
      when(() => service.login("", ""))
          .thenAnswer((_) async => APIResponse(APICode.unauthorized, null));
    }

    void arrangeLoginServiceLoginTestingValues() {
      when(() => service.login("Testing username", "Testing password"))
          .thenAnswer((_) async => APIResponse(APICode.ok, {
                "access_token": "token",
                "refresh_token": "token",
                "user": User(username: "", fullName: ""),
              }));
    }

    test(
      "login() is called without changing default values",
      () async {
        arrangeLoginServiceLoginDefaultValues();
        await sut.login();
        verify(() => service.login("", "")).called(1);
      },
    );
    test(
      "login() is called after changing default values",
      () async {
        arrangeLoginServiceLoginTestingValues();
        sut.username = "Testing username";
        sut.password = "Testing password";
        await sut.login();
        verify(() => service.login("Testing username", "Testing password"))
            .called(1);
      },
    );
    test(
      "login() loads, queries then returns result of the operation",
      () async {
        arrangeLoginServiceLoginDefaultValues();
        final future = sut.login();
        expect(sut.isLoading, true);
        await future;
        expect(sut.isLoading, false);
      },
    );
  });

  group("openForgottenPasswordPage()", () {
    void arrangeLoginServiceForgottenPassword() {
      when(() => service.openForgottenPasswordPage())
          .thenAnswer((_) async => true);
    }

    test(
      "openForgottenPasswordPage() is called",
      () async {
        arrangeLoginServiceForgottenPassword();
        await sut.openForgottenPasswordPage();
        verify(() => service.openForgottenPasswordPage()).called(1);
      },
    );
    test(
      "openForgottenPasswordPage() loads, queries then returns result of the operation",
      () async {
        arrangeLoginServiceForgottenPassword();
        final future = sut.openForgottenPasswordPage();
        expect(sut.isLoading, true);
        await future;
        expect(sut.isLoading, false);
      },
    );
  });

  group("openRegistrationPage()", () {
    void arrangeLoginServiceRegistrationPage() {
      when(() => service.openRegistrationPage()).thenAnswer((_) async => true);
    }

    test(
      "openRegistrationPage() is called",
      () async {
        arrangeLoginServiceRegistrationPage();
        await sut.openRegistrationPage();
        verify(() => service.openRegistrationPage()).called(1);
      },
    );
    test(
      "openRegistrationPage() loads, queries then returns result of the operation",
      () async {
        arrangeLoginServiceRegistrationPage();
        final future = sut.openRegistrationPage();
        expect(sut.isLoading, true);
        await future;
        expect(sut.isLoading, false);
      },
    );
  });
}
