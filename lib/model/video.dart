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
    return Video()
      ..url = json['video_hd']
      ..duration = json['video_duration']
      ..imageUrl = json['image_url']
      ..imageWidth = json['image_width']
      ..imageHeight = json['image_height'];
  }

  @override
  String toString() {
    return 'Video{url: $url, width: $width, height: $height, duration: $duration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth}';
  }
}
