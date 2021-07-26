import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/user.dart';

class UserServices {
  String collection = "users";

  void createUser({
    required String id,
    required String name,
    required String photo,
  }) {
    firebaseFirestore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "photo": photo,
    });
  }

  Future<UserModel> getUserById(String id) => userCollectionReference
      .doc(id)
      .get()
      .then((value) => value.data() as UserModel);

  Future<bool> doesUserExist(String id) async => firebaseFirestore
      .collection(collection)
      .doc(id)
      .get()
      .then((value) => value.exists);

  Future<List<UserModel>> getAll() async => userCollectionReference
      .get()
      .then((value) => value.docs.map((e) => e as UserModel).toList());

  CollectionReference<UserModel> get userCollectionReference =>
      firebaseFirestore.collection(collection).withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson());
}
