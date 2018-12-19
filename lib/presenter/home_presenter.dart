import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/today.dart';
import '../api/api.dart' as api;

class HomePresenter {
  fetchToday() async {
    // await Future.delayed((new Duration(seconds: 5)));
    final response = await http.get(api.API_TODAY_URL);
    Today ret;
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      ret = Today.fromJson(data);
    }
    return ret;
  }
}
