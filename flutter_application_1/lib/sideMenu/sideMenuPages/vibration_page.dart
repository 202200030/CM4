import 'package:flutter/material.dart';

class VibrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vibração', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF00D6A3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text(
          'Vibration Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
