// running_logic.dart

import 'dart:async';

import 'package:flutter/material.dart';

class RunningLogic {
  bool _isRunning = false;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

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

  void stopRun(VoidCallback setState) {
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _isRunning = false;
    }
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
