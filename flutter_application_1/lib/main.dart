import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'sporty_home_page.dart';
import 'create_account_screen.dart'; 
import 'recover_password_screen.dart'; 
import 'customization_provider.dart';
import 'firebase_options.dart';
import 'base_page.dart';
import 'compass_screen.dart';
import 'pedometer_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomizationProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => BasePage(initialIndex: 0),
          '/createAccount': (context) => CreateAccountScreen(),
          '/recoverPassword': (context) => RecoverPasswordScreen(), 
          '/compass': (context) => CompassScreen(),
        },
      ),
    );
  }
}
