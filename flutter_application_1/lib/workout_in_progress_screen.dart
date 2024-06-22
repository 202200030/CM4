import 'dart:async'; // Import async library for Timer

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WorkoutInProgressScreen extends StatefulWidget {
  @override
  _WorkoutInProgressScreenState createState() => _WorkoutInProgressScreenState();
}

class _WorkoutInProgressScreenState extends State<WorkoutInProgressScreen> {
  Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;
  Timer? _timer; // Timer object for periodic UI updates

  late GoogleMapController _mapController;
  LatLng _initialCameraPosition = LatLng(37.422, -122.084);

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel(); // Cancel the timer when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout in Progress'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialCameraPosition,
                  zoom: 15,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<int>(
                  stream: Stream.periodic(Duration(seconds: 1), (i) => _stopwatch.elapsedMilliseconds ~/ 1000),
                  builder: (context, snapshot) {
                    return Text(
                      _formatTime(_stopwatch.elapsedMilliseconds),
                      style: TextStyle(fontSize: 48),
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _isRunning ? _pauseTimer : _startTimer,
                      child: Text(_isRunning ? 'Pause' : 'Start'),
                    ),
                    ElevatedButton(
                      onPressed: _stopTimer,
                      child: Text('Stop Workout'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    seconds = seconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Update the UI with elapsed time
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    _stopwatch.stop();
    _timer?.cancel(); // Cancel the periodic timer updates
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer?.cancel(); // Cancel the periodic timer updates
    Navigator.pop(context); // Navigate back to previous screen
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }
}
