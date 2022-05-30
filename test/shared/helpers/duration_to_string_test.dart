import 'package:fitness_app/shared/helpers/duration_to_string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("durationToString testing", () {
    test("should be empty string", () {
      String out = Converter.durationToString(Duration.zero);
      expect(out, "");
    });
    test("should be 30\"", () {
      String out = Converter.durationToString(const Duration(seconds: 30));
      expect(out, "30\"");
    });
    test("should be 1'", () {
      String out = Converter.durationToString(const Duration(minutes: 1));
      expect(out, "1'");
    });
    test("should be 1'30\"", () {
      String out =
          Converter.durationToString(const Duration(minutes: 1, seconds: 30));
      expect(out, "1'30\"");
    });
  });
}
