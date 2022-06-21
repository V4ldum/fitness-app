import 'package:fitness_app/features/main/index.dart';

abstract class MainRepository {
  Future<List<DailyProgram>?> getProgram(String token);
}
