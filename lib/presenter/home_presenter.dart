import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article.dart';

class HomePresenter {
  static const _URL = "https://gank.io/api/today";

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(_URL);
      if(response.statusCode == 200) {
        final List ret = List<Article>();
         final results = json.decode(response.body)['results'] as Map;
         final androidArticles = results['Android'] as List;
         androidArticles.forEach( (item) {
           ret.add(Article.fromJson(item as Map));
         });
         return ret;
      }
    } catch(error) {
      print('$error错误');
    }
    return null;
  }
}