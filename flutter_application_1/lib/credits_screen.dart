import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Sporty', style: TextStyle(fontSize: 24)),
            SizedBox(width: 5),
            Icon(Icons.sports_soccer, size: 24),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/megafone.png', width: 40, height: 40),
                SizedBox(width: 10),
                Text('Updates', style: TextStyle(fontSize: 24)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Credits:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Author 1: Filipe Pereira', style: TextStyle(fontSize: 18)),
            Text('Author 2: Rodrigo Maduro', style: TextStyle(fontSize: 18)),
            Text('Author 3: Vera Fernadnes', style: TextStyle(fontSize: 18)),
            Text('Author 4: Ricardo Pinto', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
