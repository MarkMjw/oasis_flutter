import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/status.dart';
import 'package:flutter_app/util/util.dart';
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

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("视频详情"),
      ),
      body: Column(
        children: <Widget>[
          _buildPlayer(),
          _buildTitle(),
          _buildSummary(),
          _buildPlayInfo(),
          _buildShare(),
          Container(margin: EdgeInsets.only(left: 10, right: 10), height: 1, color: ColorConfig.colorBackground1),
          _buildAuthor(),
          Container(height: 5, color: ColorConfig.colorBackground1),
        ],
      ),
    );
  }

  Stack _buildPlayer() {
    return Stack(
      children: <Widget>[
        Container(
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
      ],
    );
  }

  Container _buildTitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      alignment: Alignment.topLeft,
      child: Text(
        widget.status.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Container _buildSummary() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
      alignment: Alignment.topLeft,
      child: Text(
        widget.status.summary,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13.0,
          color: ColorConfig.colorText1,
        ),
      ),
    );
  }

  Container _buildPlayInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      alignment: Alignment.topLeft,
      child: Text(
        "${formatNumberZh(widget.status.playCount)}次播放  |  ${formatDate(widget.status.createTime, "MM-dd HH:mm")}发布",
        style: TextStyle(
          fontSize: 11,
          color: Color(0xff9d9d9d),
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
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              "分享到:",
              style: TextStyle(
                fontSize: 11,
                color: Color(0xff9d9d9d),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
            child: Image.asset(
              "assets/images/icon_weibo.png",
              width: 23,
              height: 23,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
            child: Image.asset(
              "assets/images/icon_wechat.png",
              width: 23,
              height: 23,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
            child: Image.asset(
              "assets/images/icon_pyq.png",
              width: 20,
              height: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
            child: Image.asset(
              "assets/images/icon_qq.png",
              width: 20,
              height: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
            child: Image.asset(
              "assets/images/icon_qzone.png",
              width: 20,
              height: 20,
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
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: widget.status.user.image,
              fit: BoxFit.fill,
              width: 36,
              height: 36,
              placeholder: Image.asset("assets/images/default_head.png", width: 36, height: 36),
            ),
          ),
          Column(
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
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorConfig.colorText1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
}
