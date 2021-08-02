import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AgingRow {
  String invNumber;
  DateTime? date;
  String projectCode;
  String bldgCode;
  String customerName;
  String chineseName;
  double d0_30;
  double d31_60;
  double d61_90;
  double d91_180;
  double d181_365;
  double y1_2;
  double y2_3;
  double over3;
  double amount;
  String bldgName;
  String? remark;
  String rename;

  String getDateStr() =>
      (date != null) ? DateFormat("yyyy-MM-dd").format(date!) : "";

  AgingRow(
      this.invNumber,
      this.date,
      this.projectCode,
      this.customerName,
      this.chineseName,
      this.d0_30,
      this.d31_60,
      this.d61_90,
      this.d91_180,
      this.d181_365,
      this.y1_2,
      this.y2_3,
      this.over3,
      [this.bldgName = "",
      this.remark])
      : amount = sumIfNotNull(
            [d0_30, d31_60, d61_90, d91_180, d181_365, y1_2, y2_3, over3]),
        bldgCode = projectCode.substring(8),
        rename = chineseName;

  AgingRow.fromJson(Map<String, Object?> json)
      : this(
          json['invNumber'] as String,
          (json['date'] as Timestamp).toDate(),
          json['projectCode'] as String,
          json['customerName'] as String,
          json['chineseName'] as String,
          json['d0_30'] as double,
          json['d31_60'] as double,
          json['d61_90'] as double,
          json['d91_180'] as double,
          json['d181_365'] as double,
          json['y1_2'] as double,
          json['y2_3'] as double,
          json['over3'] as double,
          json['bldgName'] != null ? json['bldgName'] as String : "",
          json['remark'] != null ? json['remark'] as String : "",
        );

  Map<String, Object?> toJson() {
    Map<String, Object?> tmp = {
      'invNumber': invNumber,
      'date': date,
      'projectCode': projectCode,
      'customerName': customerName,
      'chineseName': chineseName,
      'd0_30': d0_30,
      'd31_60': d31_60,
      'd61_90': d61_90,
      'd91_180': d91_180,
      'd181_365': d181_365,
      'y1_2': y1_2,
      'y2_3': y2_3,
      'over3': over3,
      'amount': amount,
      'bldgCode': bldgCode,
      'bldgName': bldgName,
      'rename': rename,
    };
    if (remark != null) tmp.addAll({'remark': remark});
    return tmp;
  }

  static String inv2DB(String str) =>
      str.toString().replaceAll(RegExp('/'), '_');

  static String db2Inv(String str) =>
      str.toString().replaceAll(RegExp('_'), '/');

  AgingRow.fromArray(List json)
      : this(
            json[0] as String,
            dateFromGsheets(json[1] as String),
            json[2] as String,
            json[3] as String,
            json[4] as String,
            json.length > 5 ? double.parse(json[5] ?? "0.0") : 0.0,
            json.length > 6 ? double.parse(json[6] ?? "0.0") : 0,
            json.length > 7 ? double.parse(json[7] ?? "0.0") : 0,
            json.length > 8 ? double.parse(json[8] ?? "0.0") : 0,
            json.length > 9 ? double.parse(json[9] ?? "0.0") : 0,
            json.length > 10 ? double.parse(json[10] ?? "0.0") : 0,
            json.length > 11 ? double.parse(json[11] ?? "0.0") : 0,
            json.length > 12 ? double.parse(json[12] ?? "0.0") : 0,
            "",
            null);
}

double sumIfNotNull(List l) {
  double total = 0;
  List.generate(l.length, (index) {
    if (l[index] != null) {
      var value = l[index];
      total += value;
    }
  });
  return total;
}

const gsDateBase = 2209161600 / 86400;
const gsDateFactor = 86400000;

double dateToGsheets(DateTime dateTime, {bool localTime = true}) {
  final offset = dateTime.millisecondsSinceEpoch / gsDateFactor;
  final shift = localTime ? dateTime.timeZoneOffset.inHours / 24 : 0;
  return gsDateBase + offset + shift;
}

DateTime? dateFromGsheets(String? value, {bool localTime = true}) {
  final date = double.tryParse(value ?? '');
  if (date == null) return null;
  final millis = (date - gsDateBase) * gsDateFactor;
  return DateTime.fromMillisecondsSinceEpoch(millis.round(), isUtc: localTime);
}
