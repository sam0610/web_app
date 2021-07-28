import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/screens/costing.dart';
import 'package:web_app/services/sheet.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('welcome ${authProvider.user!.displayName}'),
          const Text("Let's Begin"),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const CostingPage()));
              },
              icon: const Icon(Icons.file_copy)),
          IconButton(
              onPressed: () {
                authProvider.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      )),
    );
  }
}
