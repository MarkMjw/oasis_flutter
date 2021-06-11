class Category {
  int id = 0;
  String name = "";

  Category();

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category()
      ..id = json['id']
      ..name = json['name'];
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name}';
  }
}
