import 'dart:async';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/costing_row.dart';
import 'package:web_app/services/sheet.dart';
import "package:googleapis_auth/auth_browser.dart";

class CostingProvider {
  CostingProvider(this._sheetID);
  final String _sheetID;
  List<CostingRow>? _db;
  List<CostingRow>? _filteredDB;
  final _monthStream = StreamController<Set<String>>();
  final _costingStream = StreamController<List<CostingRow>?>();

  Stream<Set<String>> get getMonth => _monthStream.stream;
  Stream<List<CostingRow>?> get getCosting => _costingStream.stream;

  void dispose() {
    _monthStream.close();
    _costingStream.close();
  }

  Future<List<CostingRow>?> getAll(client) async {
    if (_filteredDB == null) {
      _db = await getDataFromSheet(client);
      _filteredDB = _db;
    }
    _monthStream.sink.add(_db!.map((e) => e.month).toSet());
    _costingStream.sink.add(_filteredDB);
    //return _filteredDB;
  }

  String _filterText = "";
  List<String> _selMonth = [];
  filter(String t) {
    _filterText = t.toLowerCase();
    _filter();
  }

  setMonth(List<String> sel) {
    _selMonth = sel;
    _filter();
  }

  _filter() {
    _filteredDB = _db!;
    if (_filterText.isNotEmpty) {
      _filteredDB = _db!
          .where(
              (element) => element.bldgName.toLowerCase().contains(_filterText))
          .toList();
    }
    if (_selMonth.isNotEmpty) {
      List<CostingRow> tmp2 = [];
      for (var m in _selMonth) {
        var tmp =
            _filteredDB!.where((element) => element.month.contains(m)).toList();
        tmp2.addAll(tmp);
      }
      _filteredDB = tmp2;
    }
    _costingStream.sink.add(_filteredDB);
    //notifyListeners();
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
