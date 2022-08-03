import 'package:fitness_app/features/comments/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCommentsService extends Mock implements CommentsService {}

void main() {
  late RepliesProvider sut;
  late MockCommentsService service;

  setUp(() {
    service = MockCommentsService();
    sut = RepliesProvider.fromService(service);
  });

  test("Initial values are correct", () {
    expect(sut.isLoading, false);
    expect(sut.comment, null);
    expect(sut.replies, null);
  });

  group("getReplies()", () {
    void arrangeCommentTestingValues() {
      when(() => service.getComment("token", 1)).thenAnswer(
        (_) async => Comment(
          id: 1,
          username: "test",
          userDisplayName: "Test",
          message: "Testing",
          timestamp:
              DateTime(2020, 5, 3, 15, 36).millisecondsSinceEpoch ~/ 1000,
          nbReplies: 0,
        ),
      );
    }

    void arrangeRepliesTestingValues() {
      when(() => service.getReplies("token", 1)).thenAnswer((_) async => []);
    }

    test("service is called", () async {
      arrangeCommentTestingValues();
      arrangeRepliesTestingValues();
      await sut.getReplies("token", 1);
      verify(() => service.getComment("token", 1)).called(1);
      verify(() => service.getReplies("token", 1)).called(1);
    });
    test(
      "service is not called if replies has already been queried",
      () async {
        arrangeCommentTestingValues();
        arrangeRepliesTestingValues();
        sut.replies = [];
        sut.comment = Comment(
          id: 1,
          username: "test",
          userDisplayName: "Test",
          message: "Testing",
          timestamp:
              DateTime(2020, 5, 3, 15, 36).millisecondsSinceEpoch ~/ 1000,
          nbReplies: 0,
        );
        await sut.getReplies("token", 1);
        verifyNever(() => service.getComment("token", 1));
        verifyNever(() => service.getReplies("token", 1));
      },
    );
    test("getReplies loads, queries then returns result of the operation",
        () async {
      arrangeCommentTestingValues();
      arrangeRepliesTestingValues();
      final future = sut.getReplies("token", 1);
      expect(sut.isLoading, true);
      await future;
      expect(sut.isLoading, false);
    });
  });
}
