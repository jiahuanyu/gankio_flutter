import '../model/article.dart';

class Today {
  List<String> category = List<String>();
  List<Article> app = List<Article>();
  List<Article> android = List<Article>();
  List<Article> ios = List<Article>();

  Today(this.category, this.app, this.android, this.ios);

  factory Today.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> results = json["results"];
    return Today(
      (json["category"] as List).map((item) => (item as String)).toList(),
      (results["App"] != null)
          ? (results["App"] as List)
              .map((dynamic item) => Article.fromJson(item))
              .toList()
          : null,
      (results["Android"] != null)
          ? (results["Android"] as List)
              .map((dynamic item) => Article.fromJson(item))
              .toList()
          : null,
      (results["iOS"] != null)
          ? (results["iOS"] as List)
              .map((dynamic item) => Article.fromJson(item))
              .toList()
          : null,
    );
  }
}
