import 'package:flutter/material.dart';

class AudioSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Áudio',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF00D6A3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text(
          'Audio Settings',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
