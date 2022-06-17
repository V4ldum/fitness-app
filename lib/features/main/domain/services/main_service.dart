import 'dart:convert';

import 'package:fitness_app/shared/helpers/network.dart';
import 'package:flutter/services.dart';

import '../repository/main_repository.dart';

class MainService implements MainRepository {
  @override
  Future<List> getProgram() async {
    await Network.emulate();
    return json.decode(await rootBundle.loadString('assets/program_data.json'));
  }
}

// TODO network query
