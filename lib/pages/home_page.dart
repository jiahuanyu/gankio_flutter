import 'package:flutter/material.dart';
import '../model/article.dart';
import '../presenter/home_presenter.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var mArticleList = List<Article>();
  final mHomePresenter = HomePresenter();

  @override
  void initState() {
    super.initState();
    print('initState');
    fetchArticles();
  }

  void fetchArticles() async {
    final data = await mHomePresenter.fetchArticles();
    print(data);
    setState(() {
      mArticleList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: mArticleList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(mArticleList[index].url)
            );
          },
      ),
    );
  }
}
