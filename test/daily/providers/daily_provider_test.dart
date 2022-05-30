import 'package:fitness_app/features/daily/domain/services/daily_service.dart';
import 'package:fitness_app/features/daily/providers/providers.dart';
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
  });

  group("getProgram()", () {
    void arrangeDailyServiceTestingValue() {
      when(() => service.getProgram()).thenAnswer((_) async => []);
    }

    test(
      "getProgram() is called",
      () async {
        arrangeDailyServiceTestingValue();
        await sut.getProgram();
        verify(() => service.getProgram()).called(1);
      },
    );
    test("getProgram loads, queries then returns result of the operation",
        () async {
      arrangeDailyServiceTestingValue();
      final future = sut.getProgram();
      expect(sut.isLoading, true);
      await future;
      expect(sut.isLoading, false);
    });
  });
}
