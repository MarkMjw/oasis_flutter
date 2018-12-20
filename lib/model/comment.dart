import 'package:flutter_app/model/user.dart';

class Comment {
  int cid;
  String text;
  User user;
  bool reply;
  int createTime;

  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Comment()
      ..cid = json['cid']
      ..text = json['text']
      ..user = User.fromJson(json['user'])
      ..reply = json['reply']
      ..createTime = json['create_time'];
  }

  @override
  String toString() {
    return 'Comment{cid: $cid, text: $text, user: $user, reply: $reply, createTime: $createTime}';
  }
}
