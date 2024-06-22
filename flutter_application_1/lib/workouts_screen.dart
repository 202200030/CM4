import 'package:flutter/material.dart';
import 'workout_in_progress_screen.dart'; // Import your workout in progress screen

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
            buildWorkoutGrid(context), // Pass context to buildWorkoutGrid
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

  Expanded buildWorkoutGrid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          WorkoutItem('assets/Workouts_Assests/caminhada.png', 'Walk', () {
            _startWorkout(context);
          }),
          WorkoutItem('assets/Workouts_Assests/corrida.png', 'Run', () {
            _startWorkout(context);
          }),
          WorkoutItem('assets/Workouts_Assests/cycling.png', 'Cycling', () {
            _startWorkout(context);
          }),
          WorkoutItem('assets/Workouts_Assests/gym.png', 'Gym', () {
            _startWorkout(context);
          }),
          WorkoutItem('assets/Workouts_Assests/desportos.png', 'Sports', () {
            _startWorkout(context);
          }),
          WorkoutItem('assets/Workouts_Assests/Basketball.png', 'Basketball', () {
            _startWorkout(context);
          }),
          WorkoutItem('assets/Workouts_Assests/free_training.png', 'Free Training', () {
            _startWorkout(context);
          }),
        ],
      ),
    );
  }

  void _startWorkout(BuildContext context) {
    Navigator.pop(context); // Close the modal
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutInProgressScreen()),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onPressed;

  WorkoutItem(this.assetPath, this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7, // Adjust height as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset(assetPath, width: 70),
                        SizedBox(height: 20),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: onPressed,
                          child: Text('Start Workout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Column(
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
      ),
    );
  }
}
