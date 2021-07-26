class UserModel {
  final String id;
  final String name;
  final String photo;

  UserModel(this.id, this.name, this.photo);

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          json['id'] as String,
          json['name'] as String,
          json['photo'] as String,
        );

  Map<String, Object?> toJson() {
    var json = {
      'id': id,
      'name': name,
      'photo': photo,
    };
    return json;
  }
}
