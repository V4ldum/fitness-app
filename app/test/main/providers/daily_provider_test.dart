import 'package:fitness_app/features/main/domain/services/daily_service.dart';
import 'package:fitness_app/features/main/providers/providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDailyService extends Mock implements DailyService {}

main() {
  late DailyProvider sut;
  late MockDailyService service;

  setUp(() {
    service = MockDailyService();
    sut = DailyProvider.fromService(service);
  });

  test("Initial values are correct", () {
    expect(sut.isLoading, false);
    expect(sut.programs, null);
  });

  group("getProgram()", () {
    void arrangeDailyServiceTestingValue() {
      when(() => service.getProgram("test")).thenAnswer((_) async => []);
    }

    test(
      "getProgram() is called",
      () async {
        arrangeDailyServiceTestingValue();
        await sut.getProgram("test");
        verify(() => service.getProgram("test")).called(1);
      },
    );
    test(
      "getProgram() is not called if program has already been queried",
      () async {
        arrangeDailyServiceTestingValue();
        sut.programs = [];
        await sut.getProgram("test");
        verifyNever(() => service.getProgram("test"));
      },
    );
    test("getProgram loads, queries then returns result of the operation",
        () async {
      arrangeDailyServiceTestingValue();
      final future = sut.getProgram("test");
      expect(sut.isLoading, true);
      await future;
      expect(sut.isLoading, false);
    });
  });
}
