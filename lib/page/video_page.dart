import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/status.dart';
import 'package:flutter_app/page/video_detail_page.dart';
import 'package:flutter_app/util/time_util.dart';
import 'package:http/http.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoPage extends StatefulWidget {
  final String cid;

  VideoPage({Key key, this.cid = "1"}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with AutomaticKeepAliveClientMixin {
  final double _itemHeight = 180;
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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            color: ColorConfig.colorPrimary,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
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
          height: _itemHeight,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
          decoration: BoxDecoration(color: ColorConfig.colorPlaceHolder, borderRadius: BorderRadius.all(Radius.circular(5))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: CachedNetworkImage(imageUrl: status.video.imageUrl, fit: BoxFit.fitWidth),
          ),
        ),
        Container(
          width: double.infinity,
          height: _itemHeight,
          alignment: Alignment.topCenter,
          margin: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Image.asset(
              "assets/images/shadow_up.png",
              fit: BoxFit.fill,
              width: double.infinity,
              height: 100,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: _itemHeight,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
            child: Image.asset(
              "assets/images/shadow_down.png",
              fit: BoxFit.fill,
              width: double.infinity,
              height: 80,
            ),
          ),
        ),
        Container(
          height: _itemHeight,
          width: double.infinity,
          alignment: Alignment.center,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset("assets/images/play.png"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoDetailPage(status: status)));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Text(
            status.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: _itemHeight,
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            "${formatDuration(status.video.duration)}  |  ${status.playCount}次播放",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  void _loadData(bool isRefresh) async {
    String url = "${Api.HOST}/status/list?cid=${widget.cid}&cursor=$cursor&count=10&${Api.COMMON_PARAM}";
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
