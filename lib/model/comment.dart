import 'user.dart';

class Comment {
  int sid = -1;
  int cid = 0;
  String text = "";
  int createTime = 0;
  User user = User();
  User? sourceUser;

  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment()
      ..sid = json['sid']
      ..cid = json['cid']
      ..text = json['text']
      ..user = User.fromJson(json['user'])
      ..sourceUser = User.fromJson(json['source_user'])
      ..createTime = json['create_time'];
  }

  @override
  String toString() {
    return 'Comment{sid: $sid, cid: $cid, text: $text, createTime: $createTime, user: $user, sourceUser: $sourceUser}';
  }
}
