import 'package:flutter/material.dart';
import 'package:web_app/screens/costing_page/costing_page.dart';
import 'package:web_app/widgets/home_drawer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: const [
//      Flexible(flex: 1, child: HomeDrawer()),
      Expanded(flex: 5, child: CostingPage()),
    ]));
  }
}
