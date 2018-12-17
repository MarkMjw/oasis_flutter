class Video {
  String url;
  int width;
  int height;
  int duration;
  String imageUrl;
  int imageHeight;
  int imageWidth;

  Video();

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    var video = Video();
    video.url = json['url'];
    video.width = json['width'];
    video.height = json['height'];
    video.duration = json['duration'];
    video.imageUrl = json['image_url'];
    video.imageWidth = json['image_width'];
    video.imageHeight = json['image_height'];
    return video;
  }
}
