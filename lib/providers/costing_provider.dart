import 'package:flutter/material.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/costing_row.dart';
import 'package:web_app/services/sheet.dart';
import "package:googleapis_auth/auth_browser.dart";

class CostingProvider with ChangeNotifier {
  CostingProvider(this._sheetID);
  final String _sheetID;
  List<CostingRow>? _db;
  List<CostingRow>? _filteredDB;

  Stream<Set<String>> getMonth() async* {
    if (_filteredDB != null) {
      yield _db!.map((e) => e.month).toSet();
    }
  }

  Future<List<CostingRow>?> getAll(client) async {
    if (_filteredDB == null) {
      _db = await getDataFromSheet(client);
      _filteredDB = _db;
    }
    notifyListeners();
    return _filteredDB;
  }

  filter(String t) {
    _filteredDB =
        _db!.where((element) => element.bldgName.contains(t)).toList();
    notifyListeners();
  }

  Future<List<CostingRow>?> getDataFromSheet(client) async {
    try {
      AuthClient? _client = (await client);

      if (_client != null) {
        _db = await proceed(_client);
      } else {
        // Initialize the browser oauth2 flow functionality.
        var id = ClientId(gID, null);
        BrowserOAuth2Flow flow = await createImplicitBrowserFlow(id, scopes);
        _client = await flow.clientViaUserConsent();
        // Authenticated and auto refreshing client is available in [client].
        _db = await proceed(_client);
        _client.close();
        flow.close();
      }
      return _db;
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<CostingRow>?> proceed(_client) async {
    var data =
        await SheetsServices().loadSheets(_client, _sheetID, 'COSTING!A2:CA');
    if (data != null) {
      List<CostingRow> r = SheetsServices()
          .sheetToTable<CostingRow>(data, (l) => CostingRow.fromArray(l));
      return r;
    } else {
      return null;
    }
  }
}
