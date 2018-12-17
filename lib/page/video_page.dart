import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/model/status.dart';
import 'package:http/http.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  var _items = [];
  var cursor = "-1";
  var _hasMore = true;
  ScrollController _controller = new ScrollController();

  _VideoPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && _hasMore) {
        // scroll to bottom, get next page data
        _loadData(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("视频"),
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
              cursor = "-1";
              _loadData(true);
            }));
  }

  Widget _buildRow(int i) {
    Status status = _items[i];
    return ListTile(
        title: Text(
          status.title,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text('${status.createTime} @${status.user.name}'),
        onTap: () {
          print(status.title);
        });
  }

  void _loadData(bool isRefresh) async {
    String url = "${Api.HOST}/status/list?cid=1&cursor=$cursor&count=20&${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(url);

    print(response);
    final body = json.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      cursor = body["data"]["next_cursor"];
      _hasMore = cursor != "0";

      final statuses = body["data"]["statuses"];
      var items = [];
      statuses.forEach((item) => items.add(Status.fromJson(item)));

      setState(() {
        if (isRefresh) {
          _items = items;
        } else {
          _items.addAll(items);
        }
      });
    }
  }
}
