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
          AchievementItem('assets/achievement1.png', 'First Achievement'),
          AchievementItem('assets/achievement2.png', 'Second Achievement'),
          AchievementItem('assets/achievement3.png', 'Third Achievement'),
          AchievementItem('assets/achievement4.png', 'Fourth Achievement'),
          AchievementItem('assets/achievement5.png', 'Fifth Achievement'),
          AchievementItem('assets/achievement6.png', 'Sixth Achievement'),
          AchievementItem('assets/achievement7.png', 'Seventh Achievement'),
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
