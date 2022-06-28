import 'package:fitness_app/features/main/index.dart';

abstract class DailyRepository {
  Future<List<DailyProgram>?> getProgram(String token);
}
