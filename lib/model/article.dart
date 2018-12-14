class Article {
  String url;

  Article({this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      url: json['url']
    );
  }
}
