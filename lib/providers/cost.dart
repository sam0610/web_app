import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/costing.dart';
import 'package:web_app/services/sheet.dart';
import "package:googleapis_auth/auth_browser.dart";

class CostingProvider {
  CostingProvider(this._sheetID);
  final String _sheetID;
  List<CostingRow>? _db;

  Future<List<CostingRow>?> getAll(client) async {
    if (_db == null) {
      _db = await getDataFromSheet(client);
      return _db;
    }
  }

  Future<List<CostingRow>?> getDataFromSheet(client) async {
    try {
      // Initialize the browser oauth2 flow functionality.
      // Initialize the browser oauth2 flow functionality.
      var id = ClientId(gID, null);
      List<CostingRow>? DB;
      BrowserOAuth2Flow flow = await createImplicitBrowserFlow(id, scopes);
      AuthClient client = await flow.clientViaUserConsent();
      // Authenticated and auto refreshing client is available in [client].
      var data =
          await SheetsServices().loadSheets(client, _sheetID, 'COSTING!A2:CA');
      if (data != null) {
        DB = SheetsServices()
            .sheetToTable<CostingRow>(data, (l) => CostingRow.fromArray(l));
        _db = DB;
      }
      client.close();
      flow.close();
      return DB;
    } catch (ex) {
      throw ex;
    }
  }
}
