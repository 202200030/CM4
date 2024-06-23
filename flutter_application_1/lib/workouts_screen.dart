import 'package:flutter/material.dart';

class WorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitleRow(),
        SizedBox(height: 20),
        buildCenteredText('Select your workout:'),
        SizedBox(height: 20),
        buildWorkoutGrid(context), // Pass context to buildWorkoutGrid
      ],
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

  Expanded buildWorkoutGrid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2, // Changed to 2 columns for running and walking
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          WorkoutItem('assets/Workouts_Assests/corrida.png', () {
            Navigator.pop(context, 'assets/Workouts_Assests/corrida.png');
          }),
          WorkoutItem('assets/Workouts_Assests/caminhada.png', () {
            Navigator.pop(context, 'assets/Workouts_Assests/caminhada.png');
          }),
        ],
      ),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  WorkoutItem(this.assetPath, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(assetPath, width: 70),
          SizedBox(height: 5),
          Text(
            _getWorkoutLabel(assetPath), // Assuming a function to get label based on assetPath
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  String _getWorkoutLabel(String assetPath) {
    // Implement logic to derive label from assetPath
    return assetPath.replaceAll('assets/Workouts_Assests/', '').replaceAll('.png', '');
  }
}

class BottomSheetWorkouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: WorkoutsPage(),
    );
  }
}