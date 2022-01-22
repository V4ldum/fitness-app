import 'dart:convert';

import 'package:flutter/services.dart';

abstract class API {
  static bool findUser(String username, String password) {
    //emulate API call
    return username == "test" && password == "test";
  }

  static Future programOfTheWeek() async {
    //emulate API call
    return json.decode(await rootBundle.loadString('program_data.json'));
  }
}
