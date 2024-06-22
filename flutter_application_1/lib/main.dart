import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sporty_home_page.dart';
import 'customization_screen.dart';
import 'createAccount_screen.dart';
import 'recoverPassword_screen.dart';
import 'credits_screen.dart';

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
        '/customize': (context) => CustomizationScreen(),
        '/register': (context) => CreateAccountScreen(),
        '/recoverPass': (context) => RecoverPasswordScreen(),
        '/credits': (context) => CreditsScreen(),
      },
    );
  }
}
