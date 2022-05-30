import '../domain/domain.dart';

class DailyProvider {
  bool isLoading = false;
  late final DailyRepository _service;

  DailyProvider() {
    _service = DailyService();
  }

  DailyProvider.fromService(DailyRepository ds) {
    _service = ds;
  }

  Future<List> getProgram() async {
    isLoading = true;
    List out = await _service.getProgram();
    isLoading = false;

    return out;
  }
}
