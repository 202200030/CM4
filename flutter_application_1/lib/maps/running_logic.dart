import 'dart:async';

import 'package:flutter/material.dart';
import '../history_item.dart'; // Import your HistoryItem class

class RunningLogic {
  bool _isRunning = false;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  double _distanceTraveled = 0.0;

  bool get isRunning => _isRunning;
  Duration get elapsedTime => _elapsedTime;

  void startRun(VoidCallback setState) {
    if (!_isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState();
        _elapsedTime = _stopwatch.elapsed;
      });
      _isRunning = true;
    }
  }

  HistoryItem stopRun(VoidCallback setState, String type, String title, String subtitle, double distance) {
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _elapsedTime = _stopwatch.elapsed;
      _stopwatch.reset(); // Reset stopwatch
      _isRunning = false;
      _distanceTraveled = distance;

      // Create history item
      HistoryItem historyItem = HistoryItem(
        type: type,
        title: title,
        subtitle: subtitle,
        date: DateTime.now(),
        elapsedTime: _elapsedTime,
        distance: _distanceTraveled,
      );

      setState();
      return historyItem;
    }

    throw StateError('Cannot stop run because it is not running.');
  }

  double getDistanceTraveled() {
    return _distanceTraveled;
  }

  String getFormattedElapsedTime() {
    int hours = _elapsedTime.inHours;
    int minutes = _elapsedTime.inMinutes.remainder(60);
    int seconds = _elapsedTime.inSeconds.remainder(60);

    String hoursStr = hours < 10 ? '0$hours' : '$hours';
    String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsStr = seconds < 10 ? '0$seconds' : '$seconds';

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
