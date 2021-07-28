import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/loader.dart';
import 'package:web_app/models/costing.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/providers/cost.dart';
import 'package:web_app/services/sheet.dart';

class CostingPage extends StatelessWidget {
  const CostingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var db = authProvider.userModel!.divData.db;
    var costingProvider = CostingProvider(db);
    var client = authProvider.getClient();

    return FutureBuilder(
        future: costingProvider.getAll(client),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Loader();
            default:
              if (snapshot.data != null) {
                var d = snapshot.data as List<CostingRow>;
                return Text(d[0].bldgName.toString());
              }
              return const Text('no data');
          }
        });
  }
}
