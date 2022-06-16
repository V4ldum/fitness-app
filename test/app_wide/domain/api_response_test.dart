import 'package:fitness_app/features/app_wide/index.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("APIResponse Construction", () {
    test(
      "full construction is correct",
      () {
        APIResponse<String> sut = APIResponse<String>(APICode.ok, "Test");

        expect(sut.statusCode, APICode.ok);
        expect(sut.content, "Test");
      },
    );
    test(
      "Construction with null content",
      () {
        APIResponse<String> sut = APIResponse<String>(APICode.ok, null);

        expect(sut.statusCode, APICode.ok);
        expect(sut.content, null);
      },
    );
    test(
      "Construction with all types of status codes",
      () {
        APIResponse<String> sut;

        for (APICode item in APICode.values) {
          sut = APIResponse<String>(item, null);

          expect(sut.statusCode, item);
          expect(sut.content, null);
        }
      },
    );
  });

  group("isStatus()", () {
    test("isStatus works with all status codes", () {
      APIResponse<String> sut;

      for (APICode initItem in APICode.values) {
        sut = APIResponse<String>(initItem, null);

        // Correct APICode
        expect(sut.isStatus(initItem), true);
        // All incorrect APICodes
        for (APICode item in APICode.values) {
          if (item != initItem) {
            expect(sut.isStatus(item), false);
          }
        }
      }
    });
  });
}
