import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DemoList extends StatefulWidget {
  @override
  createState() => _ContentListState();
}

class _ContentListState extends State<DemoList> {
  var _items = [];
  var _curPage = 1;
  var _hasMore = true;
  ScrollController _controller = new ScrollController();

  _ContentListState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && _hasMore) {
        // scroll to bottom, get next page data
        _curPage++;
        _loadData(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _curPage = 1;
    _loadData(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List demo"),
        ),
        body: RefreshIndicator(
            color: Colors.red,
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              controller: _controller,
              itemCount: _items.length * 2,
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) return Divider();

                final index = position ~/ 2;
                return _buildRow(index);
              },
            ),
            onRefresh: () async {
              _curPage = 1;
              _loadData(true);
            }));
  }

  Widget _buildRow(int i) {
    Feed feed = _items[i];
    return ListTile(
        title: Text(
          feed.title,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text('${feed.postdate} @${feed.author}'),
        onTap: () {
          print(feed.title);
        });
  }

  void _loadData(bool isRefresh) async {
    String url =
        "https://app.kangzubin.com/iostips/api/feed/list?page=$_curPage&from=flutter-app&version=1.0";
    Response response = await get(url);

    final body = json.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      final feeds = body["data"]["feeds"];
      var items = [];
      feeds.forEach((item) =>
          items.add(Feed(item["author"], item["title"], item["postdate"])));

      setState(() {
        if (isRefresh) {
          _items = items;
          _hasMore = items.length >= 10;
        } else {
          _items.addAll(items);
          _hasMore = items.length >= 10;
        }
      });
    }
  }
}

class Feed {
  final String author;
  final String title;
  final String postdate;

  Feed(this.author, this.title, this.postdate);
}
