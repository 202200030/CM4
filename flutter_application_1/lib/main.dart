import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporty_application/maps/home_map_state.dart';
import 'package:sporty_application/maps/home_map_state.dart';
import 'sideMenu/side_menu.dart';
import 'customization_provider.dart';
import 'customization_screen.dart';
import 'achievements_screen.dart';
import 'sporty_home_page.dart';
import 'history_screen.dart';
import 'history_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomizationProvider(),
      child: MaterialApp(
        home: BasePage(initialIndex: 0),
        routes: {
          '/home': (context) => BasePage(initialIndex: 0),
          '/history': (context) => BasePage(initialIndex: 1),
          '/achievements': (context) => BasePage(initialIndex: 2),
          '/customize': (context) => BasePage(initialIndex: 3),
          '/workouts': (context) => BasePage(initialIndex: 4),
          '/workoutMap': (context) => BasePage(initialIndex: 5),
        },
      ),
    );
  }
}

class BasePage extends StatefulWidget {
  final int initialIndex;

  const BasePage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _currentIndex;

  final List<Widget> _pages = [
    SportyHomePage(),
    HomeMap(),
    AchievementsScreen(),
    CustomizationScreen(),
  
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, size: 35),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_rounded),
            label: 'Trophies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_outlined),
            label: 'Customize',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.teal,
        onTap: _navigateToPage,
      ),
    );
  }
}
