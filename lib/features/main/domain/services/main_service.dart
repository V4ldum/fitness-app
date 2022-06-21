import 'dart:convert';

import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/main/domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:week_of_year/date_week_extensions.dart';

class MainService implements MainRepository {
  @override
  Future<List<DailyProgram>?> getProgram(String token) async {
    List<DailyProgram>? out;
    final http.Response response = await http.get(
      Uri.http(
        Strings.apiHost,
        Strings.apiDailyPath,
        {
          "week": DateTime.now().weekOfYear.toString(),
          "token": token,
        },
      ),
    );

    if (response.statusCode == 200) {
      out = [];

      final List json = jsonDecode(
          jsonDecode(utf8.decode(response.bodyBytes))["result"]["data"]);
      for (var element in json) {
        out.add(DailyProgram.fromJson(element));
      }
    }
    return out;
  }
}
