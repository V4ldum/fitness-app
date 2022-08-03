import 'package:fitness_app/features/app_wide/domain/domain.dart';
import 'package:fitness_app/features/app_wide/providers/app_wide_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppWideService extends Mock implements AppWideService {}

main() {
  late AppWideProvider sut;
  late MockAppWideService service;

  setUp(() {
    service = MockAppWideService();
    sut = AppWideProvider.fromService(service);
  });

  test(
    "Initial values are correct",
    () {
      expect(sut.accessToken, null);
      expect(sut.refreshToken, null);
      expect(sut.user, null);
    },
  );

  group("deleteTokens()", () {
    void arrangeAppWideServiceDeleteTokens() {
      when(() => service.deleteTokens()).thenAnswer((_) async {});
    }

    test(
      "deleteTokens() is called and tokens are erased",
      () async {
        arrangeAppWideServiceDeleteTokens();
        sut.accessToken = "test";
        sut.refreshToken = "test";
        sut.deleteTokens();

        verify(() => service.deleteTokens()).called(1);
        expect(sut.accessToken, null);
        expect(sut.refreshToken, null);
      },
    );
  });

  group("authenticate()", () {
    void arrangeAppWideServiceGetAccessTokenFound() {
      when(() => service.getAccessToken()).thenAnswer((_) async => "test");
    }

    void arrangeAppWideServiceGetAccessTokenNotFound() {
      when(() => service.getAccessToken()).thenAnswer((_) async => null);
    }

    void arrangeAppWideServiceGetRefreshTokenFound() {
      when(() => service.getRefreshToken()).thenAnswer((_) async => "test");
    }

    void arrangeAppWideServiceGetRefreshTokenNotFound() {
      when(() => service.getRefreshToken()).thenAnswer((_) async => null);
    }

    void arrangeAppWideServiceAuthenticateValid() {
      when(() => service.authenticate("test")).thenAnswer(
        (_) async => APIResponse<User>(
          APICode.ok,
          User(username: "test", fullName: "test"),
        ),
      );
    }

    void arrangeAppWideServiceAuthenticateInvalid() {
      when(() => service.authenticate("test")).thenAnswer(
        (_) async => APIResponse<User>(APICode.unauthorized, null),
      );
    }

    void arrangeAppWideServiceRefreshValid() {
      when(() => service.refresh("test")).thenAnswer(
        (_) async => APIResponse<Map<String, String>>(APICode.ok, {
          "access_token": "test2",
          "refresh_token": "test2",
        }),
      );
      when(() => service.authenticate("test2")).thenAnswer(
        (_) async => APIResponse<User>(
          APICode.ok,
          User(username: "test", fullName: "test"),
        ),
      );
    }

    void arrangeAppWideServiceRefreshInvalid() {
      when(() => service.refresh("test")).thenAnswer(
        (_) async =>
            APIResponse<Map<String, String>>(APICode.unauthorized, null),
      );
    }

    void arrangeAppWideServiceOtherFunctions() {
      when(() => service.deleteTokens()).thenAnswer((_) async {});
      when(() => service.updateTokens("test", "test")).thenAnswer((_) async {});
      when(() => service.updateTokens("test2", "test2"))
          .thenAnswer((_) async {});
    }

    test(
      "Access token is found and valid",
      () async {
        arrangeAppWideServiceGetAccessTokenFound();
        arrangeAppWideServiceAuthenticateValid();
        arrangeAppWideServiceGetRefreshTokenNotFound();
        arrangeAppWideServiceOtherFunctions();

        bool out = await sut.authenticate();

        expect(out, true);
        expect(sut.accessToken, "test");
        expect(sut.refreshToken, null);
        expect(sut.user!.username, "test");
        expect(sut.user!.fullName, "test");
        verify(() => service.authenticate("test")).called(1);
        verifyNever(() => service.refresh("test"));
        verifyNever(() => service.updateTokens("test", "test"));
        verifyNever(() => service.updateTokens("test2", "test2"));
        verifyNever(() => service.deleteTokens());
      },
    );
    test(
      "Access token is found and invalid, refresh token is found and valid",
      () async {
        arrangeAppWideServiceGetAccessTokenFound();
        arrangeAppWideServiceAuthenticateInvalid();
        arrangeAppWideServiceGetRefreshTokenFound();
        arrangeAppWideServiceRefreshValid();
        arrangeAppWideServiceOtherFunctions();

        bool out = await sut.authenticate();

        expect(out, true);
        expect(sut.accessToken, "test2");
        expect(sut.refreshToken, "test2");
        expect(sut.user!.username, "test");
        expect(sut.user!.fullName, "test");
        verify(() => service.authenticate("test")).called(1);
        verify(() => service.authenticate("test2")).called(1);
        verify(() => service.refresh("test")).called(1);
        verifyNever(() => service.updateTokens("test", "test"));
        verify(() => service.updateTokens("test2", "test2")).called(1);
        verifyNever(() => service.deleteTokens());
      },
    );
    test(
      "Access token is found and invalid, refresh token is found and invalid",
      () async {
        arrangeAppWideServiceGetAccessTokenFound();
        arrangeAppWideServiceAuthenticateInvalid();
        arrangeAppWideServiceGetRefreshTokenFound();
        arrangeAppWideServiceRefreshInvalid();
        arrangeAppWideServiceOtherFunctions();

        bool out = await sut.authenticate();

        expect(out, false);
        expect(sut.accessToken, null);
        expect(sut.refreshToken, null);
        expect(sut.user, null);
        verify(() => service.authenticate("test")).called(1);
        verifyNever(() => service.authenticate("test2"));
        verify(() => service.refresh("test")).called(1);
        verifyNever(() => service.updateTokens("test", "test"));
        verifyNever(() => service.updateTokens("test2", "test2"));
        verify(() => service.deleteTokens()).called(1);
      },
    );
    test(
      "Access token is not found, refresh token is found and valid",
      () async {
        arrangeAppWideServiceGetAccessTokenNotFound();
        arrangeAppWideServiceGetRefreshTokenFound();
        arrangeAppWideServiceAuthenticateValid();
        arrangeAppWideServiceRefreshValid();
        arrangeAppWideServiceOtherFunctions();

        bool out = await sut.authenticate();

        expect(out, true);
        expect(sut.accessToken, "test2");
        expect(sut.refreshToken, "test2");
        expect(sut.user!.username, "test");
        expect(sut.user!.fullName, "test");
        verifyNever(() => service.authenticate("test"));
        verify(() => service.authenticate("test2")).called(1);
        verify(() => service.refresh("test")).called(1);
        verifyNever(() => service.updateTokens("test", "test"));
        verify(() => service.updateTokens("test2", "test2")).called(1);
        verifyNever(() => service.deleteTokens());
      },
    );
    test(
      "Access token is not found, refresh token is found and invalid",
      () async {
        arrangeAppWideServiceGetAccessTokenNotFound();
        arrangeAppWideServiceGetRefreshTokenFound();
        arrangeAppWideServiceRefreshInvalid();
        arrangeAppWideServiceOtherFunctions();

        bool out = await sut.authenticate();

        expect(out, false);
        expect(sut.accessToken, null);
        expect(sut.refreshToken, null);
        expect(sut.user, null);
        verifyNever(() => service.authenticate("test"));
        verify(() => service.refresh("test")).called(1);
        verifyNever(() => service.updateTokens("test", "test"));
        verifyNever(() => service.updateTokens("test2", "test2"));
        verify(() => service.deleteTokens()).called(1);
      },
    );
    test(
      "Access token is not found, refresh token is not found",
      () async {
        arrangeAppWideServiceGetAccessTokenNotFound();
        arrangeAppWideServiceGetRefreshTokenNotFound();
        arrangeAppWideServiceOtherFunctions();

        bool out = await sut.authenticate();

        expect(out, false);
        expect(sut.accessToken, null);
        expect(sut.refreshToken, null);
        expect(sut.user, null);
        verifyNever(() => service.authenticate("test"));
        verifyNever(() => service.refresh("test"));
        verifyNever(() => service.updateTokens("test", "test"));
        verifyNever(() => service.updateTokens("test2", "test2"));
        verifyNever(() => service.deleteTokens());
      },
    );
  });
}
