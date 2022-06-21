import 'package:flutter/widgets.dart';

import '../domain/domain.dart';

class MainProvider extends ChangeNotifier {
  bool _isLoading = false;
  late final MainRepository _service;
  int _selectedIndex = 0;
  List<DailyProgram>? dailyProgram;

  MainProvider() {
    _service = MainService();
  }

  MainProvider.fromService(MainRepository ds) {
    _service = ds;
  }

  bool get isLoading => _isLoading;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  void _changeLoadingState() {
    _isLoading = !_isLoading;
    //notifyListeners();
  }

  Future<List<DailyProgram>> getProgram(String token) async {
    if (dailyProgram == null) {
      _changeLoadingState();
      dailyProgram = await _service.getProgram(token);
      _changeLoadingState();
    }
    return dailyProgram!;
  }
}
