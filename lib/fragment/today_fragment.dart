import 'package:flutter/material.dart';

import '../fragment/article_fragment.dart';

class TodayFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodayFragmentState();
  }
}

class _TodayFragmentState extends State<TodayFragment>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          color: Colors.blue,
          child: new TabBar(
            indicatorColor: Colors.white,
            controller: _mTabController,
            tabs: _mTabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            children: _mTabs.map((Tab tab) {
              return ArticleFragment(tab.text);
            }).toList(),
            controller: _mTabController,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    _mTabController = TabController(vsync: this, length: _mTabs.length);
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    _mTabController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
