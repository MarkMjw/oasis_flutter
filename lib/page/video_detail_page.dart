import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/comment.dart';
import 'package:flutter_app/model/status.dart';
import 'package:flutter_app/util/util.dart';
import 'package:flutter_app/widget/scroll_behavior_ext.dart';
import 'package:http/http.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final Status status;

  VideoDetailPage({Key key, this.status}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  var _items = [];
  var cursor = "-1";
  var _hasMore = true;
  ScrollController _scrollController = ScrollController();

  _VideoDetailPageState() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels && _hasMore) {
        // scroll to bottom, get next page data
        _loadData();
      }
    });
  }

  int _itemCount() {
    return _items?.isNotEmpty == true ? _items.length * 2 : 1;
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildPlayer(),
          _buildListView(),
        ],
      ),
    );
  }

  Stack _buildPlayer() {
    return Stack(
      children: <Widget>[
        Container(
          color: ColorConfig.colorBackground1,
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        Container(
          height: 180,
          width: double.infinity,
          child: Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(_controller.value.isPlaying ? "assets/images/pause.png" : "assets/images/play.png"),
              onPressed: _controller.value.isPlaying ? _controller.pause : _controller.play,
            ),
          ),
        ),
        Container(
          width: 48,
          height: 48,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Expanded _buildListView() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollBehaviorExt(),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _itemCount(),
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int position) {
            if (position == 0) {
              return _buildHeader();
            } else if (position.isOdd) {
              if (position == _itemCount() - 1) {
                if (_hasMore) {
                  return _buildLoadMore();
                } else {
                  return Container();
                }
              } else {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Divider(color: ColorConfig.colorDivider, height: 1),
                );
              }
            } else {
              int index = position - 1;
              return _buildCommentRow(index ~/ 2);
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        _buildTitle(),
        _buildPlayInfo(),
        _buildShare(),
        Container(margin: EdgeInsets.only(left: 10, right: 10), height: 0.5, color: ColorConfig.colorBackground1),
        _buildAuthor(),
        Container(height: 5, color: ColorConfig.colorBackground1),
      ],
    );
  }

  Widget _buildTitle() {
    return Offstage(
      offstage: widget.status?.title?.trim()?.isEmpty == true,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        alignment: Alignment.topLeft,
        child: Text(
          widget.status.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Container _buildPlayInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      alignment: Alignment.topLeft,
      child: Text(
        "${formatNumberZh(widget.status.playCount)}次播放  |  ${formatDate(widget.status.createTime, "yyyy年MM月dd日")}发布",
        style: TextStyle(
          fontSize: 12,
          color: Color(0xff4c4c4c),
        ),
      ),
    );
  }

  Container _buildShare() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/images/icon_weibo.webp",
              width: 75,
              height: 25,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/images/icon_wechat.webp",
              width: 75,
              height: 25,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/images/icon_pyq.webp",
              width: 75,
              height: 25,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/images/icon_go_weibo.webp",
              width: 75,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAuthor() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 48,
      child: Row(
        children: <Widget>[
//          Container(
//            width: 36,
//            height: 36,
//            child: CircleAvatar(
//              backgroundImage: FadeInImage.assetNetwork(
//                placeholder: "assets/images/default_head.png",
//                image: widget.status.user.image,
//                fit: BoxFit.cover,
//              ).image,
//              radius: 100,
//            ),
//          ),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: widget.status.user.image,
              fit: BoxFit.fill,
              width: 36,
              height: 36,
              placeholder: Image.asset("assets/images/default_head.png", width: 36, height: 36),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.status.user.name,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 1),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.status.user.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: ColorConfig.colorText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentRow(int position) {
    Comment comment = _items[position];
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: comment.user.image,
                fit: BoxFit.fill,
                width: 36,
                height: 36,
                placeholder: Image.asset("assets/images/default_head.png", width: 36, height: 36),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        comment.user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      formatDate(comment.createTime, "yyyy-hh-mm"),
                      style: TextStyle(
                        color: Color(0xff9d9d9d),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    comment.text,
                    style: TextStyle(
                      color: ColorConfig.colorText1,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
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

  void initPlayer() {
    print("play url:${widget.status.video.url}");
    _controller = VideoPlayerController.network(widget.status.video.url)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  void _loadData() async {
    String url =
        "${Api.HOST}/comment/list?lid=${widget.status.lid}&type=${widget.status.type}&cursor=$cursor&count=20&${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(url);

    final body = json.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      cursor = body["data"]["next_cursor"];
      _hasMore = cursor != "0";

      final statuses = body["data"]["comments"];
      var items = [];
      statuses.forEach((item) => items.add(Comment.fromJson(item)));

      setState(() {
        _items.addAll(items);
      });
    }
  }
}
