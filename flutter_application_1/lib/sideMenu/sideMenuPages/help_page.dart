import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Ajuda',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF00D6A3),
      ),
      body: Center(
        child: Text(
          'Help Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
