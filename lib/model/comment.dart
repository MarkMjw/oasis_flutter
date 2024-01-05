import 'user.dart';

class Comment {
  int cid = 0;
  String text = "";
  int createTime = 0;
  User user = User();
  User? sourceUser;

  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment()
      ..cid = json['cid'] ?? 0
      ..text = json['text'] ?? ""
      ..user = User.fromJson(json['user'])
      ..sourceUser = User.fromJson(json['source_user'])
      ..createTime = json['create_time'] ?? 0;
  }

  @override
  String toString() {
    return 'Comment{cid: $cid, text: $text, createTime: $createTime, user: $user, sourceUser: $sourceUser}';
  }
}
