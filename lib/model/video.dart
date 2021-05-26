class Video {
  String url = "";
  int width = 0;
  int height = 0;
  int duration = 0;
  String imageUrl = "";
  int imageHeight = 0;
  int imageWidth = 0;

  Video();

  factory Video.fromJson(Map<String, dynamic> json) {
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
