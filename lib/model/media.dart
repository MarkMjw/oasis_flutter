class Media {
  String url = "";
  String normalUrl = "";
  String mediumUrl = "";
  String smallUrl = "";
  String thumbnailUrl = "";
  String originUrl = "";
  int width = 0;
  int height = 0;
  double duration = 0.0;

  Media();

  double aspectRatio() {
    if (width > 0 && height > 0) {
      return width * 1.0 / height;
    } else {
      return 1.0;
    }
  }

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media()
      ..url = json['url']
      ..normalUrl = json['normal_url'] ?? ""
      ..mediumUrl = json['medium_url'] ?? ""
      ..smallUrl = json['small_url'] ?? ""
      ..thumbnailUrl = json['thumbnail_Url'] ?? ""
      ..originUrl = json['origin_url'] ?? ""
      ..width = json['width'] ?? 0
      ..height = json['height'] ?? 0
      ..duration = json['duration'] ?? 0.0;
  }

  @override
  String toString() {
    return 'Media{url: $url, normalUrl: $normalUrl, mediumUrl: $mediumUrl, smallUrl: $smallUrl, thumbnailUrl: $thumbnailUrl, originUrl: $originUrl, width: $width, height: $height, duration: $duration}';
  }
}
