import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/bldg_data.dart';

class BldgServices {
  final DocumentReference _divReference;
  static List<BldgData> _bldgData = [];

  BldgServices(this._divReference) {
    init();
  }

  Future<void> init() async {
    if (_bldgData.isEmpty) {
      await loadData();
    }
  }

  List<BldgData>? get bldgData => _bldgData;

  BldgData getBldg(String bldgCode) {
    var result =
        _bldgData.where((element) => element.agingBldgCode == bldgCode);
    if (result.isNotEmpty) return result.first;

    var tmp = BldgData(bldgCode, bldgCode);
    createBldg(tmp);
    return tmp;
  }

  Future<void> createBldg(BldgData bldg) async {
    bldgInfoRef.doc(bldg.agingBldgCode).set(bldg);
  }

  Stream<QuerySnapshot> streamBldgList() {
    print('streaming bldg');
    return bldgInfoRef.snapshots();
  }

  Future<void> loadData() async {
    print('load bldg from db');
    var value = await bldgInfoRef.get().then((value) => value.docs);
    if (value.isNotEmpty) {
      _bldgData = value.map((e) => e.data() as BldgData).toList();
    } else {
      _bldgData = [];
    }
  }

  CollectionReference get bldgInfoRef =>
      _divReference.collection('bldgData').withConverter<BldgData>(
          fromFirestore: ((snapshot, _) {
            var v = BldgData.fromJson(snapshot.data()!);
            v.reference = snapshot.reference;
            return v;
          }),
          toFirestore: (bldgData, _) => bldgData.toJson());
}
