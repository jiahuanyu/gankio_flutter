import 'package:flutter/material.dart';
import '../model/article.dart';
import '../pages/image_preview_page.dart';

class ArticleFragment extends StatefulWidget {
  final List<Article> _mAppList;
  final RefreshCallback _mRefreshCallback;

  ArticleFragment(this._mAppList, this._mRefreshCallback);

  @override
  State<StatefulWidget> createState() {
    return _ArticleFragmentState();
  }
}

class _ArticleFragmentState extends State<ArticleFragment> {
  Widget _buildImageDisplay(index) {
    List<String> images = widget._mAppList[index].images;
    if (images != null && images.isNotEmpty) {
      List<Widget> gridViewChildren = new List<Widget>();
      for (int i = 0; i < images.length; i++) {
        gridViewChildren.add(InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ImagePreviewPage(images, i);
              }),
            );
          },
          child: Image.network(
            images[i],
            width: MediaQuery.of(context).size.width / 3.6,
            height: 100,
            fit: BoxFit.cover,
          ),
        ));
      }

      return GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: gridViewChildren,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget._mRefreshCallback,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget._mAppList.length,
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
                      widget._mAppList[index].desc,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  _buildImageDisplay(index),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Text(
                        widget._mAppList[index].createdAt.substring(0, 10)),
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
