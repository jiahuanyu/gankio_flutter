import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';

enum MoreOptions { copy }

class ArticleDetailPage extends StatelessWidget {
  final String _mTitle;
  final String _mUrl;

  ArticleDetailPage(this._mTitle, this._mUrl);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(_mTitle),
        actions: <Widget>[
          PopupMenuButton<MoreOptions>(
            onSelected: (MoreOptions result) {
              if (result == MoreOptions.copy) {
                Clipboard.setData(ClipboardData(
                  text: _mUrl,
                ));
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<MoreOptions>>[
                const PopupMenuItem(
                  value: MoreOptions.copy,
                  child: Text("复制本文链接"),
                ),
              ];
            },
          ),
        ],
      ),
      url: _mUrl,
      withJavascript: true,
      withZoom: false,
      withLocalStorage: true,
    );
  }
}
