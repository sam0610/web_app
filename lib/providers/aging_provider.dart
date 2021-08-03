import 'dart:async';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/aging_row.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/services/bldg.dart';
import 'package:web_app/services/sheet.dart';
import "package:googleapis_auth/auth_browser.dart";

class AgingProvider {
  AgingProvider(this.divData) : _sheetID = divData.db;
  final DivData divData;
  final String _sheetID;
  List<AgingRow>? _db;
  List<AgingRow>? _filteredDB;
  final _bldgStream = StreamController<Set<String>>();
  final _agingStream = StreamController<List<AgingRow>?>();

  Stream<Set<String>> get getBldg => _bldgStream.stream;
  Stream<List<AgingRow>?> get getAging => _agingStream.stream;

  void dispose() {
    _bldgStream.close();
    _agingStream.close();
  }

  Future<List<AgingRow>?> getAll(client) async {
    if (_filteredDB == null) {
      _db = await getDataFromSheet(client);
      _filteredDB = _db;
    }
    _bldgStream.sink.add(_db!.map((e) => e.bldgName).toSet());
    _agingStream.sink.add(_filteredDB);
    //return _filteredDB;
  }

  String _filterText = "";
  List<String> _selBldg = [];
  filter(String t) {
    _filterText = t.toLowerCase();
    _filter();
  }

  setBldg(List<String> sel) {
    _selBldg = sel;
    _filter();
  }

  _filter() {
    _filteredDB = _db!;
    if (_filterText.isNotEmpty) {
      _filteredDB = _db!
          .where(
              (element) => element.rename.toLowerCase().contains(_filterText))
          .toList();
    }
    if (_selBldg.isNotEmpty) {
      List<AgingRow> tmp2 = [];
      for (var m in _selBldg) {
        var tmp = _filteredDB!
            .where((element) => element.bldgCode.contains(m))
            .toList();
        tmp2.addAll(tmp);
      }
      _filteredDB = tmp2;
    }

    _agingStream.sink.add(_filteredDB);
    //notifyListeners();
  }

  Future<List<AgingRow>?> getDataFromSheet(client) async {
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

  Future<List<AgingRow>?> proceed(_client) async {
    var data =
        await SheetsServices().loadSheets(_client, _sheetID, 'AGING!A2:N');
    if (data != null) {
      List<AgingRow> r = SheetsServices()
          .sheetToTable<AgingRow>(data, (l) => AgingRow.fromArray(l));
      BldgServices bldgServices = BldgServices(divData.ref);

      for (var a in r) {
        a.bldgName = bldgServices.getBldg(a.bldgCode).bldgName;
      }
      return r;
    } else {
      return null;
    }
  }
}
