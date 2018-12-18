import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/status.dart';
import 'package:flutter_app/page/demo_page.dart';
import 'package:flutter_app/page/video_detail_page.dart';
import 'package:http/http.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  var _items = [];
  var cursor = "-1";
  var _hasMore = true;
  ScrollController _scrollController = ScrollController();

  _VideoPageState() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DemoPage()));
                })
          ],
        ),
        body: RefreshIndicator(
            color: ColorConfig.colorPrimary,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0.0, 2.5, 0, 2.5),
              controller: _scrollController,
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int position) {
                return _buildRow(position);
              },
            ),
            onRefresh: () async {
              cursor = "-1";
              _loadData(true);
            }));
  }

  Widget _buildRow(int position) {
    Status status = _items[position];
    return Stack(
      children: <Widget>[
        Container(
          height: 180,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(5.0, 2.5, 5, 2.5),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(status.video.imageUrl).image,
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset("assets/images/play.png"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoDetailPage(status: status)));
              },
            ),
          ),
        ),
        Positioned(
          left: 15.0,
          top: 10.0,
          right: 15.0,
          child: Text(
            status.title,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _loadData(bool isRefresh) async {
    String url = "${Api.HOST}/status/list?cid=1&cursor=$cursor&count=10&${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(url);

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
