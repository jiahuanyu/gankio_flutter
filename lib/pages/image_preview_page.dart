import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePreviewPage extends StatefulWidget {
  final List<String> _mImageList;
  final int _mCurrentIndex;

  ImagePreviewPage(this._mImageList, this._mCurrentIndex);

  @override
  State<StatefulWidget> createState() {
    return _ImagePreviewPage();
  }
}

class _ImagePreviewPage extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: PageView.builder(
        onPageChanged: (index) {
          print("page = $index");
        },
        controller: PageController(initialPage: widget._mCurrentIndex),
        itemCount: widget._mImageList.length,
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            imageUrl: widget._mImageList[index],
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
