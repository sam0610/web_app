import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/helper/loader.dart';
import 'package:web_app/models/aging_row.dart';
import 'package:web_app/providers/aging_provider.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/screens/agingPage/components/aging_datagrid.dart';

class AgingReport extends StatefulWidget {
  const AgingReport({Key? key}) : super(key: key);

  @override
  State<AgingReport> createState() => _AgingReportState();
}

class _AgingReportState extends State<AgingReport> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var client = authProvider.getClient();

    var agingServices = Provider.of<AgingProvider>(context);
    agingServices.getAll(client);

    return StreamProvider<List<AgingRow>?>(
        initialData: null,
        create: (_) => agingServices.getAging,
        builder: (ctx, _) {
          return const AgingDataGrid();
        });
  }
}
