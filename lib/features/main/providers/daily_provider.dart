import 'package:fitness_app/features/main/index.dart';
import 'package:flutter/material.dart';

class DailyProvider extends ChangeNotifier {
  bool _isLoading = false;
  late final DailyRepository _service;
  List<DailyProgram>? programs;

  DailyProvider() {
    _service = DailyService();
  }

  DailyProvider.fromService(DailyRepository ms) {
    _service = ms;
  }

  bool get isLoading => _isLoading;

  void _changeLoadingState() {
    _isLoading = !_isLoading;
  }

  Future<List<DailyProgram>> getProgram(String token) async {
    if (programs == null) {
      _changeLoadingState();
      programs = await _service.getProgram(token);
      _changeLoadingState();
    }
    return programs!;
  }
}
