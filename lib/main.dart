import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/app.dart';
import 'package:web_app/providers/auth.dart';
import 'helper/constants.dart';

import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: AuthProvider.init()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat room',
          theme: themeData(),
          home: const AppScreensController())));
}

class AppScreensController extends StatelessWidget {
  const AppScreensController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    print(authProvider.status);
    switch (authProvider.status) {
      case Status.Uninitialized:
        return const Loading();
      case Status.Unauthenticated:
        return const LoginScreen();
      case Status.Authenticating:
        return const Loading();
      case Status.Authenticated:
        return const Home();
      default:
        return const LoginScreen();
    }
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
