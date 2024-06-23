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
          AchievementItem('assets/gold.png', 'First Achievement'),
          AchievementItem('assets/gold.png', 'Second Achievement'),
          AchievementItem('assets/gold.png', 'Third Achievement'),
          AchievementItem('assets/silver.png', 'Fourth Achievement'),
          AchievementItem('assets/silver.png', 'Fifth Achievement'),
          AchievementItem('assets/silver.png', 'Sixth Achievement'),
          AchievementItem('assets/bronze.png', 'Seventh Achievement'),
          AchievementItem('assets/bronze.png', 'Seventh Achievement'),
          AchievementItem('assets/bronze.png', 'Seventh Achievement')
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
