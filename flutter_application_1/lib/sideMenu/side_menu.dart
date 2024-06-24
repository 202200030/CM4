import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sideMenuPages/audio_settings.dart';
import 'sideMenuPages/music_page.dart';
import 'sideMenuPages/vibration_page.dart';
import 'sideMenuPages/resources_page.dart';
import 'sideMenuPages/help_page.dart';
import '../login_screen.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              color: Colors.teal,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    _createDrawerItem(
                      icon: Icons.volume_up,
                      text: 'Áudio',
                      onTap: () => _navigateTo(context, AudioSettingsPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.music_note,
                      text: 'Música',
                      onTap: () => _navigateTo(context, MusicPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.vibration,
                      text: 'Vibração',
                      onTap: () => _navigateTo(context, VibrationPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.book,
                      text: 'Recursos',
                      onTap: () => _navigateTo(context, ResourcesPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.help,
                      text: 'Ajuda',
                      onTap: () => _navigateTo(context, HelpPage()),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).pop(); // Close the drawer
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
