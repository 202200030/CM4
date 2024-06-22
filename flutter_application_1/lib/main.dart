import 'package:flutter/material.dart';
import 'package:sporty_application/workouts_page.dart';
import 'login_screen.dart';
import 'sporty_home_page.dart';
import 'customization_screen.dart';
import 'createAccount_screen.dart';
import 'recoverPassword_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', 
      routes: {

        '/login': (context) => LoginScreen(), 
        '/home': (context) => SportyHomePage(),
        '/customize': (context) => CustomizationScreen(),
        '/workouts':(context) => WorkoutsPage(),
        '/register': (context) => CreateAccountScreen(),
        '/recoverPass': (context) => RecoverPasswordScreen(),
      },
    );
  }
}
