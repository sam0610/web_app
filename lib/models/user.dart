import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String photo;
  final String email;
  final String div;
  late DivData divData;

  UserModel(
      {required this.id,
      required this.name,
      required this.photo,
      required this.email,
      required this.div});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          photo: json['photo'] as String,
          email: json['email'] as String,
          div: json['div'] as String,
        );

  Map<String, Object?> toJson() {
    var json = {
      'id': id,
      'name': name,
      'photo': photo,
      'email': email,
      'div': div
    };
    return json;
  }
}

class DivData {
  String db;
  late DocumentReference ref;

  DivData({required this.db});

  DivData.fromJson(Map<String, dynamic> json) : this(db: json['db'] as String);

  Map<String, dynamic> toJson() {
    var json = {'db': db};
    return json;
  }
}
