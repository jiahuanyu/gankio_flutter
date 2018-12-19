import 'package:flutter/material.dart';

class ImagePreviewPage extends StatefulWidget {
  final List<String> _mImageList;
  final int _mCurrentIndex;

  ImagePreviewPage(this._mImageList, this._mCurrentIndex);

  @override
  State<StatefulWidget> createState() {
    return _ImagePreviewPage(_mImageList, _mCurrentIndex);
  }
}

class _ImagePreviewPage extends State<ImagePreviewPage> {
  final List<String> _mImageList;
  final int _mCurrentIndex;

  _ImagePreviewPage(this._mImageList, this._mCurrentIndex);

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
        controller: PageController(initialPage: _mCurrentIndex),
        itemCount: _mImageList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _mImageList[index],
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
