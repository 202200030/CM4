import 'package:flutter/material.dart';

class CustomizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/hat.png', width: 40, height: 40),
                SizedBox(width: 10),
                Text('Customization', style: TextStyle(fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],)),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildGridItem('assets/headphones.png'),
                _buildGridItem('assets/cap.png'),
                _buildGridItem('assets/glasses.png'),
                _buildGridItem('assets/watch.png'),
                _buildGridItem('assets/helmet.png'),
                _buildGridItem('assets/sunglasses.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String assetPath) {
    return Card(
      child: Center(
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }
}
