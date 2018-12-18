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
    video.url = json['video_hd'];
    video.duration = json['video_duration'];
    video.imageUrl = json['image_url'];
    video.imageWidth = json['image_width'];
    video.imageHeight = json['image_height'];
    return video;
  }

  @override
  String toString() {
    return 'Video{url: $url, width: $width, height: $height, duration: $duration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth}';
  }
}
