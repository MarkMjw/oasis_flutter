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
    var comment = Comment();
    comment.cid = json['cid'];
    comment.text = json['text'];
    comment.user = User.fromJson(json['user']);
    comment.reply = json['reply'];
    comment.createTime = json['create_time'];
    return comment;
  }
}
