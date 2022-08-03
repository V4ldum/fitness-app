import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/profile/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileService extends Mock implements ProfileService {}

main() {
  late ProfileProvider sut;
  late MockProfileService service;

  setUp(() async {
    service = MockProfileService();
    // Spaghetti code
    when(() => service.getSetting(Strings.notificationSettingKey))
        .thenAnswer((_) async => null);
    sut = ProfileProvider.fromService(service);
  });

  test(
    "Initial values are correct",
    () {
      expect(sut.notificationSelectedItem, 0);
      expect(sut.isLoadingExternal, false);
      expect(sut.isLoadingProfile, false);
    },
  );

  group("Setters are working", () {
    test(
      "set notificationSelectedItem",
      () {
        sut.notificationSelectedItem = 1;
        expect(sut.notificationSelectedItem, 1);
      },
    );
  });

  group("openMyAccountPage()", () {
    void arrangeProfileServiceMyAccount() {
      when(() => service.openMyAccount()).thenAnswer((_) async => true);
    }

    test(
      "openMyAccount() is called",
      () async {
        arrangeProfileServiceMyAccount();
        await sut.openMyAccountPage();
        verify(() => service.openMyAccount()).called(1);
      },
    );
    test(
      "openMyAccount() loads, queries then returns result of the operation",
      () async {
        arrangeProfileServiceMyAccount();
        final future = sut.openMyAccountPage();
        expect(sut.isLoadingExternal, true);
        expect(sut.isLoadingProfile, false);
        await future;
        expect(sut.isLoadingExternal, false);
        expect(sut.isLoadingProfile, false);
      },
    );
  });

  group("openAppSettings()", () {
    void arrangeProfileServiceAppSettings() {
      when(() => service.openAppSettings()).thenAnswer((_) async => true);
    }

    test(
      "openAppSettings() is called",
      () async {
        arrangeProfileServiceAppSettings();
        await sut.openAppSettings();
        verify(() => service.openAppSettings()).called(1);
      },
    );
    test(
      "openAppSettings() loads, queries then returns result of the operation",
      () async {
        arrangeProfileServiceAppSettings();
        final future = sut.openAppSettings();
        expect(sut.isLoadingExternal, true);
        expect(sut.isLoadingProfile, false);
        await future;
        expect(sut.isLoadingExternal, false);
        expect(sut.isLoadingProfile, false);
      },
    );
  });

  group("saveSetting()", () {
    void arrangeProfileServiceSaveSetting() {
      when(() => service.saveSetting("test", "test")).thenAnswer((_) {});
    }

    test(
      "saveSetting() is called",
      () async {
        arrangeProfileServiceSaveSetting();
        sut.saveSetting("test", "test");
        verify(() => service.saveSetting("test", "test")).called(1);
      },
    );
  });

  group("getSetting()", () {
    void arrangeProfileServiceGetSetting() {
      when(() => service.getSetting("test")).thenAnswer((_) async => "test");
    }

    test(
      "getSetting() is called",
      () async {
        arrangeProfileServiceGetSetting();
        await sut.getSetting("test");
        verify(() => service.getSetting("test")).called(1);
      },
    );
  });

  group("removeSetting()", () {
    void arrangeProfileServiceRemoveSetting() {
      when(() => service.removeSetting("test")).thenAnswer((_) {});
    }

    test(
      "arrangeProfileServiceRemoveSetting() is called",
      () async {
        arrangeProfileServiceRemoveSetting();
        sut.removeSetting("test");
        verify(() => service.removeSetting("test")).called(1);
      },
    );
  });

  group("updateImage()", () {
    void arrangeProfileServiceUpdateImage() {
      when(() => service.updateImage()).thenAnswer((_) {});
    }

    test(
      "arrangeProfileServiceRemoveSetting() is called",
      () async {
        arrangeProfileServiceUpdateImage();
        sut.updateImage();
        verifyNever(() => service.updateImage());
      },
    );
  });

  group("onNotificationOptionChanged()", () {
    test(
      "saveSetting() is called and the correct value is selected",
      () async {
        sut.onNotificationOptionChanged(Notifications.Aucune);
        verify(() => sut.saveSetting(Strings.notificationSettingKey, "Aucune"))
            .called(1);
        expect(sut.notificationSelectedItem, 2);
      },
    );
  });
}
