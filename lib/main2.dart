import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/admin_account_provider.dart'; // Import the new provider
import 'provider/login.dart'; // Import the new provider
import 'provider/register.dart'; // Import the new provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AdminAccountProvider()), // Register the provider
      ],
      child: MaterialApp(
        title: 'SA-CLUBS',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen2(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}
