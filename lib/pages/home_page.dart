import 'package:flutter/material.dart';
import '../fragment/article_fragment.dart';
import '../presenter/home_presenter.dart';
import '../model/article.dart';

class HomePage extends StatefulWidget {
  final String _mTitle;

  HomePage(this._mTitle);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomePresenter _mHomePresenter = HomePresenter();
  bool _mIsLoading = true;
  List<Tab> _mTabs = <Tab>[
    Tab(
      text: 'App',
    ),
    Tab(
      text: 'Android',
    ),
    Tab(
      text: 'iOS',
    ),
  ];
  TabController _mTabController;
  Map<String, dynamic> _mContents = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    print("initState");
    _mTabController = TabController(vsync: this, length: _mTabs.length);
    _fetchToady();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    _mTabController.dispose();
  }

  Future<Null> _fetchToady() async {
    await _mHomePresenter.fetchToday().then((today) {
      setState(() {
        _mContents["App"] = today.app;
        _mContents["Android"] = today.android;
        _mContents["iOS"] = today.ios;
        _mIsLoading = false;
      });
    }).catchError((error) {
      print(error);
    });
    return null;
  }

  Widget _buildDrawerItem(String title, IconData iconData) {
    return ListTile(
      leading: Icon(
        iconData,
      ),
      title: Text(
        title,
      ),
      onTap: () {
        print("asdasd");
      },
    );
  }

  Widget _buildBody() {
    if (_mIsLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    List<Widget> tabViews = _mTabs.map((Tab tab) {
      List<Article> articleList = (_mContents[tab.text] as List);
      if (articleList != null && articleList.isNotEmpty) {
        return ArticleFragment(
            articleList.map((dynamic item) => (item as Article)).toList(),
            _fetchToady);
      }
      return Center(
        child: Text("empty"),
      );
    }).toList();
    return TabBarView(
      children: tabViews,
      controller: _mTabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Image.asset(
                'images/lake.jpg',
                height: 240.0,
                fit: BoxFit.cover,
              ),
            ),
            _buildDrawerItem("每日干货", Icons.today),
            _buildDrawerItem("历史干货", Icons.history),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget._mTitle),
        bottom: TabBar(
          tabs: _mTabs,
          controller: _mTabController,
        ),
      ),
      body: _buildBody(),
    );
  }
}
