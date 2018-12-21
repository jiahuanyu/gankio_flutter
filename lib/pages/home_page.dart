import 'package:flutter/material.dart';

import '../fragment/read_fragment.dart';
import '../fragment/today_fragment.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TodayFragment _mTodayFragment = TodayFragment();
  ReadFragment _mReadFragment = ReadFragment();
  String _mTitle = "干货";
  int _mCurrentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDrawerItem(
      String title, IconData iconData, GestureTapCallback callback) {
    return ListTile(
      leading: Icon(
        iconData,
      ),
      title: Text(
        title,
      ),
      onTap: callback,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
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
          _buildDrawerItem("干货", Icons.today, () {
            Navigator.pop(context);
            setState(() {
              _mTitle = "干货";
              _mCurrentSelectedIndex = 0;
            });
          }),
          _buildDrawerItem("闲读", Icons.chrome_reader_mode, () {
            Navigator.pop(context);
            setState(() {
              _mTitle = "阅读";
              _mCurrentSelectedIndex = 1;
            });
          }),
          // _buildDrawerItem("历史干货", Icons.history),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        primary: true,
        title: Text(_mTitle),
      ),
      body: Stack(
        children: <Widget>[
          new Offstage(
            offstage: _mCurrentSelectedIndex != 0,
            child: _mTodayFragment,
          ),
          new Offstage(
            offstage: _mCurrentSelectedIndex != 1,
            child: _mReadFragment,
          ),
        ],
      ),
    );
  }
}
