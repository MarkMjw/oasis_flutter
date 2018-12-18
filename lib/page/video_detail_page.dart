import 'package:flutter/material.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/status.dart';
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
          Stack(
            children: <Widget>[
//              AnimatedOpacity(
//                opacity: _isPlaying ? 0 : 1,
//                duration: Duration(microseconds: 300),
//                child: Container(
//                  height: 180,
//                  width: double.infinity,
//                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: Image.network(widget.status.video.imageUrl).image,
//                      fit: BoxFit.fitWidth,
//                    ),
//                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                  ),
//                ),
//              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Center(
                  child: _controller.value.initialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
              ),
              Container(
                height: 180,
                width: double.infinity,
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: _controller.value.isPlaying
                        ? Image.asset("assets/images/pause.png")
                        : Image.asset("assets/images/play.png"),
                    onPressed: _controller.value.isPlaying ? _controller.pause : _controller.play,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.status.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.status.summary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: ColorConfig.colorText1,
                ),
              ),
            ),
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
