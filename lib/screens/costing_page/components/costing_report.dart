import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/models/costing_row.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/providers/costing_provider.dart';
import 'package:web_app/screens/costing_page/components/costing_datagrid.dart';
import 'package:web_app/screens/costing_page/components/income_chart.dart';

import 'income_datagrid.dart';

class CostingReport extends StatefulWidget {
  const CostingReport({Key? key}) : super(key: key);

  @override
  State<CostingReport> createState() => _CostingReportState();
}

class _CostingReportState extends State<CostingReport>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var client = authProvider.getClient();
    var costingProvider = Provider.of<CostingProvider>(context);
    costingProvider.getAll(client);
    return SafeArea(
        child: StreamProvider<List<CostingRow>?>(
            initialData: null,
            create: (_) => costingProvider.getCosting,
            builder: (ctx, _) {
              return Row(
                children: const [
                  Expanded(flex: 2, child: IncomeChart()),
                  Expanded(flex: 5, child: IncomeDataGrid())
                ],
              );
            }));
  }
}
