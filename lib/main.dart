import 'package:flutter/material.dart';
import 'package:back_pal/pages/loading_page.dart';
import 'package:back_pal/pages/home_page.dart';
import 'package:back_pal/pages/about_page.dart';
import 'package:back_pal/pages/settings_page.dart';
import 'package:back_pal/pages/proFeatures_page.dart';
// import 'package:back_pal/services/notification_service.dart';

void main() {
  runApp(MyApp());
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationService().initNotification();
//
//
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posture Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/settings': (context) => SettingsPage(),
        '/pro': (context) => ProFeaturesPage(),
        // Add more routes as needed
      },
    );
  }
}


// void main() {
//   runApp(MyApp());
// }