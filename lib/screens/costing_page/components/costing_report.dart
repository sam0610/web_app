import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/loader.dart';
import 'package:web_app/helper/no_data.dart';
import 'package:web_app/models/costing_row.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/providers/costing_provider.dart';

class CostingReport extends StatelessWidget {
  const CostingReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var client = authProvider.getClient();
    var costingProvider = Provider.of<CostingProvider>(context);
    return SafeArea(
      child: FutureBuilder(
          future: costingProvider.getAll(client),
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Loader();
              default:
                if (snapshot.data != null) {
                  var data = snapshot.data as List<CostingRow>;
                  return SafeArea(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(data[index].bldgName),
                            subtitle: Text(data[index].profit.toString()),
                          );
                        }),
                  );
                }
                return const NoDataWidget();
            }
          }),
    );
  }
}
