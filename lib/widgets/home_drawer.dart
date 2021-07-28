import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/auth.dart';
import 'package:web_app/screens/costing_page/costing_page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Align(
                alignment: Alignment.bottomLeft, child: Text('Nixon WebApp')),
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('Costing'),
                    leading: const Icon(Icons.monetization_on),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const CostingPage()));
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ]),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              authProvider.signOut();
            },
          )
        ],
      ),
    );
  }
}
