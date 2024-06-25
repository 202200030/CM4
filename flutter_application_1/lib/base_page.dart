import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'sporty_home_page.dart';
import 'history_screen.dart';
import 'maps/home_map_state.dart'; 
import 'achievements_screen.dart';
import 'customization_screen.dart';
import 'sideMenu/side_menu.dart';
import 'compass_screen.dart';

class BasePage extends StatefulWidget {
  final int initialIndex;

  const BasePage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _currentIndex;
  double _speed = 0.0;

  final List<Widget> _pages = [
    SportyHomePage(),
    HomeMap(), 
    HistoryScreen(),
    AchievementsScreen(),
    CustomizationScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _speed = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      });
    });
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openCompass() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompassScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(), 
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _openCompass,
                  child: Icon(Icons.explore),
                ),
                SizedBox(height: 10),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${_speed.toStringAsFixed(1)} km/h',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
            icon: Icon(Icons.history),
            label: 'History',
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
