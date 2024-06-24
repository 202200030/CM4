import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerService {
  void listenToAccelerometer() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration = event.x * event.x + event.y * event.y + event.z * event.z;
      
      print('Acceleration: $acceleration');
    });
  }
}