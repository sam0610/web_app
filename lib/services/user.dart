import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/user.dart';

class UserServices {
  String collection = "users";
  String divCollection = "divData";

  void createUser({
    required String id,
    required String name,
    required String photo,
    required String email,
  }) {
    firebaseFirestore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "photo": photo,
      "email": email,
      "div": "NKIV"
    });
  }

  Future<UserModel> getUserById(String id) =>
      userCollectionReference.doc(id).get().then((value) {
        var user = value.data() as UserModel;
        return firebaseFirestore
            .collection(divCollection)
            .doc(user.div)
            .get()
            .then((value) {
          var div = DivData.fromJson(value.data()!);
          div.ref = value.reference;
          user.divData = div;
          return user;
        });
      });

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
