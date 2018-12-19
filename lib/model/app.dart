class App {
  String desc;
  List<String> images = List<String>();
  String createdAt;
  String url;

  App(this.desc, this.images, this.createdAt, this.url);

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
        json["desc"],
        (json["images"] != null)
            ? (json["images"] as List).map((item) => (item as String)).toList()
            : List<String>(),
        json["createdAt"],
        json["url"]);
  }
}
