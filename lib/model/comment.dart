import 'package:oasis_flutter/model/user.dart';

class Comment {
  int cid = 0;
  String text = "";
  User user = User();
  bool reply = false;
  int createTime = 0;

  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) {
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
