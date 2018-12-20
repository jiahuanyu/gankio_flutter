import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/article.dart';

const API_APP_URL = "https://gank.io/api/data/App/10/1";
const API_ANDROID_URL = "https://gank.io/api/data/Android/10/1";
const API_IOS_URL = "https://gank.io/api/data/iOS/10/1";

const Map<String, String> API_URL_MAP = {
  "App": API_APP_URL,
  "Android": API_ANDROID_URL,
  "iOS": API_IOS_URL
};

Future<List<Article>> fetchData(String label) async {
  // await Future.delayed((new Duration(seconds: 5)));
  final response = await http.get(API_URL_MAP[label]);
  List<Article> ret;
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data != null) {
      List results = data["results"];
      if (results != null) {
        ret = results.map((item) => Article.fromJson(item)).toList();
      }
    }
  }
  return ret;
}
