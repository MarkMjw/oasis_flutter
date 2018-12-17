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
    status.user = User.fromJson(json['user']);
    status.isLike = json['is_like'];
    status.playCount = json['play_count'];
    status.likeCount = json['lide_count'];
    status.commentCount = json['comment_count'];
    status.video = Video.fromJson(json['video']);
    status.createTime = json['create_time'];
    status.source = json['source'];
    return status;
  }
}
