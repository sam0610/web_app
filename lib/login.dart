import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/app.dart';
import 'package:web_app/providers/auth.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.login),
          onPressed: () async {
            appProvider.changeLoading();
            Map result = await authProvider.sigInWithGoogle();
            bool success = result['success'];
            String message = result['message'];

            if (!success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              appProvider.changeLoading();
            }
            appProvider.changeLoading();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
      ),
    );
  }
}
