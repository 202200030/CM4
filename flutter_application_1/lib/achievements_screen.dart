import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleRow(),
            SizedBox(height: 20),
            buildCenteredText('Your Achievements:'),
            SizedBox(height: 20),
            buildAchievementsGrid(),
          ],
        ),
      ),
    );
  }

  Widget buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/medal.png', width: 50),
        SizedBox(width: 10),
        Text(
          'Achievements',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget buildCenteredText(String text) {
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

  Expanded buildAchievementsGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          AchievementItem('assets/gold.png', '5 consecutive walks in a week'),
          AchievementItem('assets/gold.png', '5 consecutive runs in a week'),
          AchievementItem('assets/gold.png', '3 consecutive runs in a week'),
          AchievementItem('assets/silver.png', '3 consecutive walks in a week'),
          AchievementItem('assets/silver.png', 'First 15 km - Cycling'),
          AchievementItem('assets/silver.png', 'First 15 km - Run'),
          AchievementItem('assets/bronze.png', 'First 10 km - Run'),
          AchievementItem('assets/bronze.png', 'First 5 km - Walk'),
          AchievementItem('assets/bronze.png', 'First 5 km - Run'),
        ],
      ),
    );
  }
}

class AchievementItem extends StatelessWidget {
  final String assetPath;
  final String label;

  AchievementItem(this.assetPath, this.label);

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
