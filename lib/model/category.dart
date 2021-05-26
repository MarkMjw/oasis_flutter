class Category {
  String cid = "";
  String name = "";

  Category();

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category()
      ..cid = json['cid']
      ..name = json['name'];
  }

  @override
  String toString() {
    return 'Category{cid: $cid, name: $name}';
  }
}
