class Article {
  String desc;
  List<String> images = List<String>();
  String createdAt;
  String url;

  Article(this.desc, this.images, this.createdAt, this.url);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        json["desc"],
        (json["images"] != null)
            ? (json["images"] as List).map((item) => (item as String)).toList()
            : List<String>(),
        json["createdAt"],
        json["url"]);
  }
}
