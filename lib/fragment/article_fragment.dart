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

class _ArticleFragmentState extends State<ArticleFragment>
    with AutomaticKeepAliveClientMixin {
  int _mCurrentPageIndex = 0;
  bool _mIsLoading = true;
  bool _mHasMore = true;
  List<Article> _mArticleList = List<Article>();
  ScrollController _mScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _mScrollController.addListener(() {
      if (_mScrollController.position.pixels >= _mScrollController.position.maxScrollExtent) {
        _fetchMore();
      }
    });
    _fetchFirst();
  }

  void _fetchFirst() async {
    await _fetchData();
    setState(() {
      _mIsLoading = false;
    });
  }

  void _fetchMore() async {
    await _fetchData();
  }

  Future<Null> _onRefresh() async {
    _mCurrentPageIndex = 0;
    _mHasMore = true;
    return _fetchData();
  }

  Future<Null> _fetchData() async {
    if (!_mHasMore) {
      return null;
    }
    await Api.fetchData(widget._mLabel, _mCurrentPageIndex + 1).then((data) {
      if (data != null) {
        if (data.isEmpty) {
          _mHasMore = false;
        }
        setState(() {
          if (_mCurrentPageIndex == 0) {
            _mArticleList.clear();
          }
          _mArticleList.addAll(data);
        });
        _mCurrentPageIndex++;
      }
    }).catchError((error) {
      print(error);
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
      onRefresh: _onRefresh,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _mScrollController,
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
