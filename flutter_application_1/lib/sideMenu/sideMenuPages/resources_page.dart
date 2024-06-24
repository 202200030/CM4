import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Recursos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF00D6A3),
      ),
      body: Center(
        child: Text(
          'Resources Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
