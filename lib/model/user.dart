class User {
  int id = 0;
  String name = "";
  String image = "";
  String description = "";

  User();

  factory User.fromJson(Map<String, dynamic>? json) {
    return User()
      ..id = json?['uid'] ?? 0
      ..name = json?['name'] ?? ""
      ..image = json?['image'] ?? ""
      ..description = json?['description'] ?? "";
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, description: $description}';
  }
}
