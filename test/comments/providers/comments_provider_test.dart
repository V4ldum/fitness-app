import 'package:fitness_app/features/comments/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCommentsService extends Mock implements CommentsService {}

void main() {
  late CommentsProvider sut;
  late MockCommentsService service;

  setUp(() {
    service = MockCommentsService();
    sut = CommentsProvider.fromService(service);
  });

  test("Initial values are correct", () {
    expect(sut.isLoading, false);
    expect(sut.comments, null);
  });

  group("getComments()", () {
    void arrangeCommentsTestingValues() {
      when(() => service.getComments("token", 1)).thenAnswer((_) async => []);
    }

    test("service is called", () async {
      arrangeCommentsTestingValues();
      await sut.getComments("token", 1);
      verify(() => service.getComments("token", 1)).called(1);
    });
    test(
      "service is not called if comments has already been queried",
      () async {
        arrangeCommentsTestingValues();
        sut.comments = [];
        await sut.getComments("token", 1);
        verifyNever(() => service.getComments("token", 1));
      },
    );
    test("getComments loads, queries then returns result of the operation",
        () async {
      arrangeCommentsTestingValues();
      final future = sut.getComments("token", 1);
      expect(sut.isLoading, true);
      await future;
      expect(sut.isLoading, false);
    });
  });
}
