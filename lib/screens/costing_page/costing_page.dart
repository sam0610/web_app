import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/providers/costing_provider.dart';

import 'components/costing_report.dart';
import 'components/searchbar.dart';
import 'components/title.dart';

class CostingPage extends StatelessWidget {
  const CostingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var db = authProvider.userModel!.divData.db;

    return ChangeNotifierProvider.value(
        value: CostingProvider(db),
        builder: (context, _) {
          return SafeArea(
            child: Scaffold(
                body: Column(
              children: const [
                TitleWidget(title: 'Costing Report'),
                Expanded(child: CostingReport()),
              ],
            )),
          );
        });
  }
}
