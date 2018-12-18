class Category {
  String cid;
  String name;

  Category();

  factory Category.fromJson(Map<String, dynamic> json) {
    var category = Category();
    category.cid = json['cid'];
    category.name = json['name'];
    return category;
  }

  @override
  String toString() {
    return 'Category{cid: $cid, name: $name}';
  }
}
