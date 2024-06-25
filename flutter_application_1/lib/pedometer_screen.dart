import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class PedometerScreen extends StatefulWidget {
  @override
  _PedometerScreenState createState() => _PedometerScreenState();
}

class _PedometerScreenState extends State<PedometerScreen> {
  String _stepCountValue = '0';
  late Stream<StepCount> _stepCountStream;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _initPedometer();
    } else {
      setState(() {
        _stepCountValue = 'Permission denied';
      });
    }
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    print('Steps: ${event.steps}');
    setState(() {
      _stepCountValue = event.steps.toString();
    });
  }

  void _onStepCountError(error) {
    print('Step Count Error: $error');
    setState(() {
      _stepCountValue = 'Error: $error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Sporty', style: TextStyle(fontSize: 24)),
            SizedBox(width: 5),
            Icon(Icons.directions_walk, size: 24),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _stepCountValue,
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
