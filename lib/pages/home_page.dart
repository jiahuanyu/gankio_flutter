import 'package:flutter/material.dart';
import '../fragment/app_fragment.dart';
import '../presenter/home_presenter.dart';
import '../model/app.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomePresenter _mHomePresenter = HomePresenter();
  bool _mIsLoading = true;
  List<Tab> _mTabs = List<Tab>();
  TabController _mTabController;
  Map<String, dynamic> _mContents = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    print("initState");
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
        today.category.forEach((item) {
          _mTabs.add(Tab(
            text: item,
          ));
        });
        _mContents["App"] = today.app;
        _mContents["Android"] = today.android;
        _mContents["iOS"] = today.ios;
        _mTabController = TabController(vsync: this, length: _mTabs.length);
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
      List<App> appList = (_mContents[tab.text] as List);
      if (appList != null && appList.isNotEmpty) {
        return AppFragment(
            appList.map((dynamic item) => (item as App)).toList(), _fetchToady);
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

  Widget _buildAppBarBottom() {
    if (!_mIsLoading) {
      return TabBar(
        tabs: _mTabs,
        isScrollable: true,
        controller: _mTabController,
      );
    }
    return null;
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
        title: Text(widget.title),
        bottom: _buildAppBarBottom(),
      ),
      body: _buildBody(),
    );
  }
}
