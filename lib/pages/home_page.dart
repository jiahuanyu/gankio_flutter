import 'package:flutter/material.dart';

import '../fragment/today_fragment.dart';

class HomePage extends StatefulWidget {
  final String _mTitle;

  HomePage(this._mTitle);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TodayFragment _mTodayFragment = TodayFragment();

  Widget _mBody;


  @override
  void initState() {
    super.initState();
    _mBody = _mTodayFragment;
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
            _mBody = _mTodayFragment;
          }),
          _buildDrawerItem("闲读", Icons.chrome_reader_mode, null),
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
        title: Text(widget._mTitle),
      ),
      body: _mBody,
    );
  }
}
