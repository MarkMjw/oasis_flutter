import 'comment.dart';
import 'dynamic_cover.dart';
import 'media.dart';
import 'topic.dart';
import 'user.dart';

class Status {
  static const int TYPE_IMAGE = 1;
  static const int TYPE_VIDEO = 2;

  int id = 0;
  int type = TYPE_IMAGE;
  String title = "";
  String text = "";
  String cover = "";
  DynamicCover dynamicCover = DynamicCover();

  User user = User();
  List<Media> medias = List.empty(growable: true);

  int createTime = 0;
  String source = "";
  String recommendReason = "";

  bool isFavorited = false;

  bool isLike = false;
  List<User> likes = List.empty(growable: true);
  int likeTotal = 0;

  int commentTotal = 0;
  List<Comment> comments = List.empty(growable: true);

  List<Topic> topics = List.empty(growable: true);

  Status();

  String fixText() {
    if (title.isNotEmpty) {
      return title;
    } else if (text.isNotEmpty) {
      return text;
    } else {
      return "";
    }
  }

  String firstTopic() {
    if (topics.isNotEmpty) {
      return topics[0].name;
    } else {
      return "";
    }
  }

  String fixCover() {
    if (dynamicCover.url.isNotEmpty) {
      return dynamicCover.url;
    } else {
      return cover;
    }
  }

  String commentText(int index) {
    var len = comments.length;
    if (index < len) {
      return comments[index].text;
    } else {
      return "";
    }
  }

  User commentUser(int index) {
    var len = comments.length;
    if (index < len) {
      return comments[index].user;
    } else {
      return User();
    }
  }

  User likeUser(int index) {
    var len = likes.length;
    if (index < len) {
      return likes[index];
    } else {
      return User();
    }
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    var status = Status()
      ..id = json['id'] ?? 0
      ..type = json['type'] ?? TYPE_IMAGE
      ..title = json['title'] ?? ""
      ..text = json['text'] ?? ""
      ..cover = json['cover'] ?? ""
      ..dynamicCover = DynamicCover.fromJson(json['dynamic_cover'])
      ..user = User.fromJson(json['user'])
      ..createTime = json['create_time'] ?? 0
      ..source = json['source'] ?? ""
      ..recommendReason = json['recommend_reason'] ?? ""
      ..isFavorited = json['is_favorited'] ?? false
      ..isLike = json['is_like'] ?? false
      ..likeTotal = json['like_total'] ?? 0
      ..commentTotal = json['comment_total'] ?? 0;

    if (json['medias'] != null) {
      status.medias = List<Media>.from(json['medias'].map((i) => Media.fromJson(i)), growable: true);
    }
    if (json['likes'] != null) {
      status.likes = List<User>.from(json['likes'].map((i) => User.fromJson(i)), growable: true);
    }
    if (json['comments'] != null) {
      status.comments = List<Comment>.from(json['comments'].map<Comment>((i) => Comment.fromJson(i)), growable: true);
    }
    if (json['topics'] != null) {
      status.topics = List<Topic>.from(json['topics'].map<Topic>((i) => Topic.fromJson(i)), growable: true);
    }
    return status;
  }

  @override
  String toString() {
    return 'Status{id: $id, type: $type, title: $title, text: $text, cover: $cover, dynamicCover: $dynamicCover, user: $user, medias: $medias, createTime: $createTime, source: $source, recommendReason: $recommendReason, isFavorited: $isFavorited, isLike: $isLike, likes: $likes, likeTotal: $likeTotal, commentTotal: $commentTotal, comments: $comments, topics: $topics}';
  }
}
