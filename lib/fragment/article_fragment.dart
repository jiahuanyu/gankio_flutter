import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../api/api.dart' as Api;
import '../model/article.dart';
import '../pages/article_detail_page.dart';
import '../pages/image_preview_page.dart';

class ArticleFragment extends StatefulWidget {
  final String _mLabel;

  ArticleFragment(this._mLabel);

  @override
  State<StatefulWidget> createState() {
    return _ArticleFragmentState();
  }
}

class _ArticleFragmentState extends State<ArticleFragment> with AutomaticKeepAliveClientMixin {
  bool _mIsLoading = true;
  List<Article> _mArticleList;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<Null> _fetchData() async {
    await Api.fetchData(widget._mLabel).then((data) {
      setState(() {
        _mArticleList = data;
      });
    }).catchError((error) {
      print(error);
    });
    setState(() {
      _mIsLoading = false;
    });
    return null;
  }

  Widget _buildImageDisplay(index) {
    List<String> images = _mArticleList[index].images;
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
          child: CachedNetworkImage(
            imageUrl: images[i],
            width: MediaQuery.of(context).size.width / 3.6,
            height: 100,
            fit: BoxFit.cover,
            placeholder: Container(
              color: Colors.grey,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
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
    if (_mIsLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_mArticleList == null || _mArticleList.isEmpty) {
      return Center(
        child: Text("empty"),
      );
    }
    return RefreshIndicator(
      onRefresh: _fetchData,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _mArticleList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ArticleDetailPage(
                    _mArticleList[index].desc, _mArticleList[index].url);
              }));
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        _mArticleList[index].desc,
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
                      child:
                          Text(_mArticleList[index].createdAt.substring(0, 10)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
