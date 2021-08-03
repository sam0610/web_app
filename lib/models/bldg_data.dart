import 'package:cloud_firestore/cloud_firestore.dart';

class BldgData {
  String agingBldgCode;
  String bldgName;
  DocumentReference? reference;

  BldgData(this.agingBldgCode, this.bldgName);

  BldgData.fromJson(Map<String, Object?> json)
      : this(json['agingBldgCode']! as String, json['bldgName']! as String);

  Map<String, Object?> toJson() =>
      {'agingBldgCode': agingBldgCode, 'bldgName': bldgName};

  save() {
    if (reference != null) reference!.set(toJson());
  }
}
