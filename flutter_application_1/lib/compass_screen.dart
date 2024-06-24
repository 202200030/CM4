import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double _magnetometerX = 0.0;
  double _magnetometerY = 0.0;
  double _magnetometerZ = 0.0;

  @override
  void initState() {
    super.initState();
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerX = event.x;
        _magnetometerY = event.y;
        _magnetometerZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bússola'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Magnetômetro:'),
            Text('X: $_magnetometerX µT'),
            Text('Y: $_magnetometerY µT'),
            Text('Z: $_magnetometerZ µT'),
          ],
        ),
      ),
    );
  }
}
