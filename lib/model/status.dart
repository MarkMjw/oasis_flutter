import 'package:oasis_flutter/model/user.dart';
import 'package:oasis_flutter/model/video.dart';

class Status {
  int id = 0;
  int type = 0;
  String title = "";
  String text = "";
  String cover = "";
  User user = User();
  bool isLike = false;
  int likeCount = 0;
  int commentCount = 0;
  Video video = Video();
  int createTime = 0;
  String source = "";

  Status();

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status()
      ..id = json['id']
      ..type = json['type']
      ..title = json['title'] ?? ""
      ..text = json['text']
      ..cover = json['cover']
      ..user = User.fromJson(json['user'])
      ..isLike = json['is_like']
      ..likeCount = json['like_total']
      ..commentCount = json['comment_total']
      ..createTime = json['create_time']
      ..source = json['source'];
  }

  @override
  String toString() {
    return 'Status{id: $id, type: $type, title: $title, text: $text, cover: $cover, user: $user, isLike: $isLike, likeCount: $likeCount, commentCount: $commentCount, video: $video, createTime: $createTime, source: $source}';
  }
}
