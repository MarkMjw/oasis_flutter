import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis_flutter/config/api.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/comment.dart';
import 'package:oasis_flutter/model/status.dart';
import 'package:oasis_flutter/util/util.dart';
import 'package:oasis_flutter/widget/feed_item.dart';
import 'package:oasis_flutter/widget/scroll_behavior_ext.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  final Status? status;

  DetailPage({super.key, this.status});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  final _items = [];
  var cursor = "-1";
  var _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  _DetailPageState() {
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
    return _items.isNotEmpty == true ? _items.length * 2 : 1;
  }

  @override
  void initState() {
    super.initState();
    // initPlayer();
    _loadData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: const Text("详情"),
      ),
      body: Column(
        children: <Widget>[
          // _buildPlayer(),
          _buildListView(),
        ],
      ),
    );
  }

  // Stack _buildPlayer() {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         color: ColorConfig.background1,
  //         child: _controller!.value.isInitialized
  //             ? AspectRatio(
  //                 aspectRatio: _controller!.value.aspectRatio,
  //                 child: VideoPlayer(_controller!),
  //               )
  //             : Container(),
  //       ),
  //       SizedBox(
  //         height: 180,
  //         width: double.infinity,
  //         child: Center(
  //           child: IconButton(
  //             padding: EdgeInsets.zero,
  //             icon: Image.asset(_controller!.value.isPlaying ? "assets/images/pause.png" : "assets/images/play.png"),
  //             onPressed: _controller!.value.isPlaying ? _controller!.pause : _controller!.play,
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 48,
  //         height: 48,
  //         child: IconButton(
  //           icon: const Icon(Icons.arrow_back, color: Colors.white),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Expanded _buildListView() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollBehaviorExt(),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _itemCount(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int position) {
            if (position == 0) {
              return FeedItem(widget.status!);
            } else if (position.isOdd) {
              if (position == _itemCount() - 1) {
                if (_hasMore) {
                  return _buildLoadMore();
                } else {
                  return Container();
                }
              } else {
                return Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
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

  // Widget _buildHeader() {
  //   return Column(
  //     children: <Widget>[
  //       _buildTitle(),
  //       _buildPlayInfo(),
  //       _buildShare(),
  //       Container(margin: const EdgeInsets.only(left: 10, right: 10), height: 0.5, color: ColorConfig.background1),
  //       _buildAuthor(),
  //       Container(height: 5, color: ColorConfig.background1),
  //     ],
  //   );
  // }
//
//   Widget _buildTitle() {
//     return Offstage(
//       offstage: widget.status?.title.trim().isEmpty == true,
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//         alignment: Alignment.topLeft,
//         child: Text(
//           widget.status!.title,
//           maxLines: 3,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Container _buildPlayInfo() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//       alignment: Alignment.topLeft,
//       child: Text(
//         "${formatNumberZh(widget.status!.commentTotal)}次播放  |  ${formatDate(widget.status!.createTime, "yyyy年MM月dd日")}发布",
//         style: const TextStyle(
//           fontSize: 12,
//           color: Color(0xff4c4c4c),
//         ),
//       ),
//     );
//   }
//
//   Container _buildShare() {
//     return Container(
//       height: 48,
//       margin: const EdgeInsets.only(left: 10, right: 10),
//       child: Row(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Image.asset(
//               "assets/images/icon_weibo.webp",
//               width: 75,
//               height: 25,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Image.asset(
//               "assets/images/icon_wechat.webp",
//               width: 75,
//               height: 25,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Image.asset(
//               "assets/images/icon_pyq.webp",
//               width: 75,
//               height: 25,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Image.asset(
//               "assets/images/icon_go_weibo.webp",
//               width: 75,
//               height: 25,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container _buildAuthor() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10, right: 10),
//       height: 48,
//       child: Row(
//         children: <Widget>[
// //          Container(
// //            width: 36,
// //            height: 36,
// //            child: CircleAvatar(
// //              backgroundImage: FadeInImage.assetNetwork(
// //                placeholder: "assets/images/default_head.png",
// //                image: widget.status.user.image,
// //                fit: BoxFit.cover,
// //              ).image,
// //              radius: 100,
// //            ),
// //          ),
//           ClipOval(
//             child: CachedNetworkImage(
//               imageUrl: widget.status!.user.image,
//               fit: BoxFit.fill,
//               width: 36,
//               height: 36,
//               // placeholder: Image.asset("assets/images/default_head.png", width: 36, height: 36),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   margin: const EdgeInsets.only(left: 10),
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     widget.status!.user.name,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(left: 10, top: 1),
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     widget.status!.user.description,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: ColorConfig.colorText1,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  Widget _buildCommentRow(int position) {
    Comment comment = _items[position];
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: comment.user.image,
                fit: BoxFit.fill,
                width: 36,
                height: 36,
                // placeholder: Image.asset("assets/images/default_head.png", width: 36, height: 36),
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
                          color: ColorConfig.commonColorSecond,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      formatDate(comment.createTime, "yyyy-hh-mm"),
                      style: TextStyle(
                        color: ColorConfig.commonColorSecond,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    comment.text,
                    style: TextStyle(
                      color: ColorConfig.commonColor,
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
          margin: const EdgeInsets.only(right: 10),
          child: const CircularProgressIndicator(strokeWidth: 2),
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

  // void initPlayer() {
  //   print("play url:${widget.status!.medias[0].url}");
  //   _controller = VideoPlayerController.network(widget.status!.medias[0].url)
  //     ..addListener(() {
  //       final bool isPlaying = _controller!.value.isPlaying;
  //       if (isPlaying != _isPlaying) {
  //         setState(() {
  //           _isPlaying = isPlaying;
  //         });
  //       }
  //     })
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  void _loadData() async {
    // widget.status?.id = 4438907896614858;
    String url = "comment/list?sid=${widget.status!.id}&cursor=$cursor&count=20&${Api.COMMON_PARAM}";
    final response = await dio.get(url);

    // String res = response.data;
    // int index = res.indexOf("代码折叠", 0);
    // String fixBody;
    // if (index > 0) {
    //   fixBody = res.substring(0, index);
    // } else {
    //   fixBody = res;
    // }
    // final body = json.decode(fixBody);
    final body = response.data;
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
