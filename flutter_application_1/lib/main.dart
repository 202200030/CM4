import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'sideMenu/side_menu.dart';
import 'customization_provider.dart';
import 'customization_screen.dart';
import 'workouts_screen.dart';
import 'achievements_screen.dart';
import 'sporty_home_page.dart';
import 'history_screen.dart';
import 'splash_screen.dart';
import 'base_page.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomizationProvider(),
      child: MaterialApp(
        home: SplashScreen(),
        routes: {
          '/home': (context) => BasePage(initialIndex: 0),
          '/history': (context) => BasePage(initialIndex: 1),
          '/achievements': (context) => BasePage(initialIndex: 2),
          '/customize': (context) => BasePage(initialIndex: 3),
          '/workouts': (context) => BasePage(initialIndex: 4),
        },
      ),
    );
  }
}
