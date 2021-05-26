import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/status.dart';
import 'package:flutter_app/page/video_detail_page.dart';
import 'package:flutter_app/util/util.dart';
import 'package:http/http.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VideoPage extends StatefulWidget {
  final String cid;

  VideoPage({Key key, this.cid = "1"}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
            color: ColorConfig.colorPrimary,
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              controller: _scrollController,
              itemCount: _items.length * 2,
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) {
                  if (position == _items.length * 2 - 1) {
                    if (_hasMore) {
                      return _buildLoadMore();
                    } else {
                      return Container();
                    }
                  } else {
                    return Divider(color: Colors.transparent, height: 5);
                  }
                }

                final index = position ~/ 2;
                return _buildRow(index);
              },
            ),
            onRefresh: () async {
              cursor = "-1";
              _loadData(true);
            }));
  }

  Widget _buildRow(int position) {
    Status status = _items[position];
    return Column(
      children: <Widget>[
        _createVideoContent(status),
        _createVideoToolbar(status),
      ],
    );
  }

  Widget _createVideoContent(Status status) {
    return Container(
      height: 180,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorConfig.colorPlaceHolder, borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: CachedNetworkImage(imageUrl: status.video.imageUrl, fit: BoxFit.fitWidth),
            ),
          ),
          _buildShadow("assets/images/shadow_up.png", Alignment.topCenter, 100),
          _buildShadow("assets/images/shadow_down.png", Alignment.bottomCenter, 80),
          Container(
            height: double.infinity,
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
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Text(
              status.title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            left: 10,
            child: Text(
              "${formatDuration(status.video.duration)}  |  ${formatNumberZh(status.playCount)}次播放",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildShadow(String image, AlignmentGeometry alignment, double height) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: alignment,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: Image.asset(
          image,
          fit: BoxFit.fill,
          width: double.infinity,
          height: height,
        ),
      ),
    );
  }

  Widget _createVideoToolbar(Status status) {
    return Container(
      width: double.infinity,
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: status.user.image,
              fit: BoxFit.fill,
              width: 36,
              height: 36,
              // placeholder: Image.asset("assets/images/default_head.png", width: 36, height: 36),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                status.user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConfig.colorText1,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              InkWell(
                child: _createToolbarMenu("assets/images/zan.png", formatNumberZh(status.likeCount)),
                onTap: () {
                  Fluttertoast.showToast(msg: "点赞👍 +1", backgroundColor: ColorConfig.colorToastBackground);
                },
              ),
              InkWell(
                child: _createToolbarMenu("assets/images/comment.png", formatNumberZh(status.commentCount)),
                onTap: () {
                  Fluttertoast.showToast(msg: "评论😊 +1", backgroundColor: ColorConfig.colorToastBackground);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _createToolbarMenu(String icon, String text) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 3),
      child: Row(
        children: <Widget>[
          Image.asset(icon, width: 24, height: 24),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: ColorConfig.colorText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          margin: EdgeInsets.only(right: 10),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        Text(
          "加载中...",
          style: TextStyle(
            color: ColorConfig.colorText1,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  void _loadData(bool isRefresh) async {
    String url = "${Api.HOST}/status/list?cid=${widget.cid}&cursor=$cursor&count=10&${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(Uri.parse(url));

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
