import 'package:fitness_app/features/main/providers/providers.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late MainProvider sut;

  setUp(() {
    sut = MainProvider();
  });

  test("Initial values are correct", () {
    expect(sut.selectedIndex, 0);
  });

  test("selectedIndex can be changed", () {
    sut.selectedIndex = 1;
    expect(sut.selectedIndex, 1);
  });
}
