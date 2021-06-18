class DynamicCover {
  String url = "";
  int width = 0;
  int height = 0;

  DynamicCover();

  factory DynamicCover.fromJson(Map<String, dynamic>? json) {
    return DynamicCover()
      ..url = json?["url"] ?? ""
      ..width = json?["width"] ?? 0
      ..height = json?["height"] ?? 0;
  }

  @override
  String toString() {
    return 'DynamicCover{url: $url, width: $width, height: $height}';
  }
}
