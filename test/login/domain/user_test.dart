import 'package:fitness_app/features/login/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late User sut;

  setUp(() {
    sut = User();
  });

  group("User Construction", () {
    test(
      "Initial values are correct",
      () {
        expect(sut.username, "");
        expect(sut.password, "");
      },
    );
  });
}
