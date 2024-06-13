import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sporty_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', 
      routes: {
        '/login': (context) => LoginScreen(), 
        '/home': (context) => SportyHomePage(), 
      },
    );
  }
}
