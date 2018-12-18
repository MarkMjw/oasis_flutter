import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("视频详情"),
        ),
        body: Center(
          child: Text("视频详情页"),
        ));
  }

//  void onPlayClick(int position) {
//    if (_curPlayPosition < 0 || _curPlayPosition != position) {
//      play(_items[position].video.url);
//    }
//  }
//
//  Widget getPlayerContainer(int position) {
//    return (_curPlayPosition == position && _controller != null && _controller.value.initialized)
//        ? AspectRatio(
//            aspectRatio: _controller.value.aspectRatio,
//            child: VideoPlayer(_controller),
//          )
//        : Container();
//  }

//  void play(String url) {
//    _controller = VideoPlayerController.network(url)
////      ..addListener(() {
////        final bool isPlaying = _controller.value.isPlaying;
////        if (isPlaying != _isPlaying) {
////          setState(() {
////            _isPlaying = isPlaying;
////          });
////        }
////      })
//      ..initialize().then((_) {
//        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//        setState(() {});
//      });
//  }
//
//  bool isPlaying(int position) {
//    return _curPlayPosition == position && _controller?.value?.isPlaying == true;
//  }
}
