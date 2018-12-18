class User {
  int id;
  String name;
  String image;
  String description;

  User();

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    var user = User();
    user.id = json['id'];
    user.name = json['name'];
    user.image = json['image'];
    user.description = json['description'];
    return user;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, description: $description}';
  }
}
