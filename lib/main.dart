import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/homepage_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/EditProfileScreen.dart'; // Import the new screen
import 'screens/activity_details_screen.dart'; // Import the new screen
import 'screens/add_activity_screen.dart'; // Import the new screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SA-CLUBS',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(userID: "Null"),
        '/search': (context) => const SearchScreen(userID: "Null"),
        '/profile': (context) => const StudentInfoCard(userID: "Null"),
        '/signup': (context) => const Register(),
        '/notification': (context) => const NotiScreen(userID: "Null"),
        '/edit-profile': (context) => const EditProfileScreen(userID: "Null",phone: "",email: "",), 
        '/activityDetail': (context) =>  ActivityDetailsScreen(),
        '/addActivity': (context) =>  AddActivityScreen(),
      },
    );
  }
}
