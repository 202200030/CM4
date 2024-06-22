import 'package:flutter/material.dart';

class WorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTitleRow(),
            SizedBox(height: 20),
            buildCenteredText('Select your workout:'),
            SizedBox(height: 20),
            buildWorkoutGrid(),
          ],
        ),
      ),
    );
  }

  Center buildTitleRow() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/flag.png', width: 50),
          SizedBox(width: 10),
          Text(
            'Workouts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Center buildCenteredText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Expanded buildWorkoutGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          WorkoutItem('assets/Workouts_Assests/caminhada.png', 'Walk'),
          WorkoutItem('assets/Workouts_Assests/corrida.png', 'Run'),
          WorkoutItem('assets/Workouts_Assests/cycling.png', 'Cycling'),
          WorkoutItem('assets/Workouts_Assests/gym.png', 'Gym'),
          WorkoutItem('assets/Workouts_Assests/desportos.png', 'Sports'),
          WorkoutItem('assets/Workouts_Assests/Basketball.png', 'Basketball'),
          WorkoutItem('assets/Workouts_Assests/free_training.png', 'Free Training'),
        ],
      ),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String assetPath;
  final String label;

  WorkoutItem(this.assetPath, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(assetPath, width: 70),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
