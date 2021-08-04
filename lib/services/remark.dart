import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/bldg_data.dart';

class RemarkServices {
  final DocumentReference _divReference;
  static List<Remarks> _remarks = [];

  RemarkServices(this._divReference) {
    init();
  }

  Future<void> init() async {
    if (_remarks.isEmpty) {
      await loadData();
    }
  }

  List<Remarks>? get remarks => _remarks;

  String getRmk(String invoiceNumber) {
    var result =
        _remarks.where((element) => element.invoiceNumber == invoiceNumber);
    if (result.isNotEmpty) return result.first.remark;

    return "";
  }

  Future<void> createRmk(Remarks remark) async {
    var inv = remark.invoiceNumber.toString().replaceAll(RegExp("/"), "_");
    await remarkInfoRef.doc(inv).set(remark);
  }

  Future<void> loadData() async {
    print('load remark from db');

    var value = await remarkInfoRef.get().then((value) => value.docs);
    if (value.isNotEmpty) {
      _remarks = value.map((e) => e.data() as Remarks).toList();
    } else {
      _remarks = [];
    }
  }

  CollectionReference get remarkInfoRef =>
      _divReference.collection('remark').withConverter<Remarks>(
          fromFirestore: ((snapshot, _) {
            var v = Remarks.fromJson(snapshot.data()!);
            v.reference = snapshot.reference;
            return v;
          }),
          toFirestore: (remark, _) => remark.toJson());
}

class Remarks {
  String invoiceNumber;
  String remark;

  DocumentReference? reference;

  Remarks(this.invoiceNumber, this.remark);

  Remarks.fromJson(Map<String, Object?> json)
      : this(json['invoiceNumber']! as String, json['remark']! as String);

  Map<String, Object?> toJson() =>
      {'invoiceNumber': invoiceNumber, 'remark': remark};

  save() {
    if (reference != null) reference!.set(toJson());
  }
}
