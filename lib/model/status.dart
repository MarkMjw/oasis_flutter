import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/model/video.dart';

class Status {
  int lid;
  String sid;
  int type;
  String title;
  String summary;
  User user;
  bool isLike;
  int playCount;
  int likeCount;
  int commentCount;
  Video video;
  int createTime;
  String source;

  Status();

  factory Status.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    var status = Status();
    status.lid = json['lid'];
    status.sid = json['sid'];
    status.type = json['type'];
    status.title = json['title'] ?? "";
    status.summary = json['summary'];
    var jsonUser = json['user'];
    status.user = User.fromJson(jsonUser);
    status.isLike = json['is_like'];
    status.playCount = json['play_count'];
    status.likeCount = json['like_count'];
    status.commentCount = json['comment_count'];
    var jsonVideo = json['video'];
    status.video = Video.fromJson(jsonVideo);
    status.createTime = json['create_time'];
    status.source = json['source'];
    return status;
  }

  @override
  String toString() {
    return 'Status{lid: $lid, sid: $sid, type: $type, title: $title, summary: $summary, user: $user, isLike: $isLike, playCount: $playCount, likeCount: $likeCount, commentCount: $commentCount, video: $video, createTime: $createTime, source: $source}';
  }
}
