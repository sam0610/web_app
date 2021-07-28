import 'package:googleapis/sheets/v4.dart';

class SheetsServices {
  Future<List<dynamic>?> loadSheets(client, sheetID, range) async {
    try {
      SheetsApi sheetsApi = SheetsApi(client);
      ValueRange ss = await sheetsApi.spreadsheets.values.get(sheetID, range,
          valueRenderOption: 'UNFORMATTED_VALUE',
          majorDimension: 'ROWS',
          dateTimeRenderOption: 'SERIAL_NUMBER');
      return ss.values as List;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  sheetToTable<T>(List<dynamic> values, Function(List l) f) {
    List<T> list = <T>[];

    for (final List value in values) {
      List<dynamic> json = [];
      for (final v in value) {
        json.add(parseString(v));
      }
      try {
        list.add(f(json));
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  parseString(dynamic v) {
    if (v == "") return null;
    return v.toString();
  }
}
