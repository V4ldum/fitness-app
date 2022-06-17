import 'package:flutter/widgets.dart';

import '../domain/domain.dart';

class MainProvider extends ChangeNotifier {
  bool _isLoading = false;
  late final MainRepository _service;
  int selectedIndex = 0;
  List? program;

  MainProvider() {
    _service = MainService();
  }

  MainProvider.fromService(MainRepository ds) {
    _service = ds;
  }

  get isLoading => _isLoading;

  void _changeLoadingState() {
    _isLoading = !_isLoading;
    //notifyListeners();
  }

  Future<List> getProgram() async {
    if (program == null) {
      _changeLoadingState();
      program = await _service.getProgram();
      _changeLoadingState();
    }
    return program!;
  }

  void onBottomNavigationChanged(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
