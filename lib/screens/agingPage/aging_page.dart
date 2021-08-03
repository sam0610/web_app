import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/aging_provider.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/screens/agingPage/components/aging_report.dart';
import 'package:web_app/screens/agingPage/components/aging_title.dart';

class AgingPage extends StatefulWidget {
  const AgingPage({Key? key}) : super(key: key);

  @override
  State<AgingPage> createState() => _AgingPageState();
}

class _AgingPageState extends State<AgingPage> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var div = authProvider.userModel!.divData;
    return Provider<AgingProvider>(
        create: (_) => AgingProvider(div),
        dispose: (_, __) => AgingProvider(div).dispose(),
        builder: (context, _) {
          return SafeArea(
              child: Column(children: const [
            TitleWidget(title: 'Aging Report'),
            Expanded(child: AgingReport())
          ]));
        });
  }
}
