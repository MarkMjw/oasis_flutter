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
    return Status()
      ..lid = json['lid']
      ..sid = json['sid']
      ..type = json['type']
      ..title = json['title'] ?? ""
      ..summary = json['summary']
      ..user = User.fromJson(json['user'])
      ..isLike = json['is_like']
      ..playCount = json['play_count']
      ..likeCount = json['like_count']
      ..commentCount = json['comment_count']
      ..video = Video.fromJson(json['video'])
      ..createTime = json['create_time']
      ..source = json['source'];
  }

  @override
  String toString() {
    return 'Status{lid: $lid, sid: $sid, type: $type, title: $title, summary: $summary, user: $user, isLike: $isLike, playCount: $playCount, likeCount: $likeCount, commentCount: $commentCount, video: $video, createTime: $createTime, source: $source}';
  }
}
