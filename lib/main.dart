import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/app.dart';
import 'package:web_app/providers/auth.dart';
import 'helper/constants.dart';

import 'home.dart';

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
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
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
        return const LoginScreen();
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
