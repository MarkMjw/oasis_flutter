class Topic {
  int tid = 0;
  String name = "";
  String description = "";
  int statusCount = 0;

  Topic();

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic()
      ..tid = json["tid"] ?? 0
      ..name = json["name"] ?? ""
      ..description = json["description"] ?? ""
      ..statusCount = json["statusCount"] ?? 0;
  }

  @override
  String toString() {
    return 'Topic{tid: $tid, name: $name, description: $description, statusCount: $statusCount}';
  }
}
