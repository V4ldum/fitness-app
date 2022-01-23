import 'package:fitness_app/utils/api.dart';

abstract class ProgramManager {
  static Future<void> _emulateNetwork() async {
    return Future.delayed(const Duration(seconds: 2));
  }

  static Future<List> getProgramOfTheWeek() async {
    await _emulateNetwork();
    return API.programOfTheWeek();
  }
}
