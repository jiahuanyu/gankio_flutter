import 'package:flutter/material.dart';

class ReadFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReadFragmentState();
  }
}

class _ReadFragmentState extends State<ReadFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("阅读"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
