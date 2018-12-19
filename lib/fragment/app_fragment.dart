import 'package:flutter/material.dart';
import '../model/app.dart';
import '../pages/image_preview_page.dart';

class AppFragment extends StatefulWidget {
  final List<App> _mAppList;
  final RefreshCallback _mRefreshCallback;

  AppFragment(this._mAppList, this._mRefreshCallback);

  @override
  State<StatefulWidget> createState() {
    return _AppFragmentState(_mAppList, _mRefreshCallback);
  }
}

class _AppFragmentState extends State<AppFragment> {
  final List<App> _mAppList;
  final RefreshCallback _mRefreshCallback;

  _AppFragmentState(this._mAppList, this._mRefreshCallback);

  Widget _buildGridView(index) {
    List<String> images = _mAppList[index].images;
    if (images != null && images.isNotEmpty) {
      return GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: images
            .map((item) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ImagePreviewPage(images, index);
                      }),
                    );
                  },
                  child: Image.network(
                    item,
                    width: MediaQuery.of(context).size.width / 3.6,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _mRefreshCallback,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _mAppList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      _mAppList[index].desc,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  _buildGridView(index),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Text(_mAppList[index].createdAt.substring(0, 10)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
