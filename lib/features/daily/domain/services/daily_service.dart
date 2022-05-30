import 'dart:convert';

import 'package:fitness_app/shared/helpers/network.dart';
import 'package:flutter/services.dart';

import '../repository/daily_repository.dart';

class DailyService implements DailyRepository {
  @override
  Future<List> getProgram() async {
    await Network.emulate();
    return json.decode(await rootBundle.loadString('assets/program_data.json'));
  }
}

// TODO network query
