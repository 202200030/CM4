import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'customization_provider.dart';

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
                Text(
                  'Customization',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
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
                _buildGridItem(context, 'assets/glasses.png', 'assets/chitaG.png'),
                _buildGridItem(context, 'assets/sunglasses.png', 'assets/chitaG2.png'),
                _buildGridItem(context, 'assets/watch.png', 'assets/chitaW.png'),
                _buildGridItem(context, 'assets/headphones.png', 'assets/chitaH.png'),
                _buildGridItem(context, 'assets/helmet.png', 'assets/chitaHel.png'),
                _buildGridItem(context, 'assets/cap.png', 'assets/chitaCap.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String assetPath, String cheetahImagePath) {
    return GestureDetector(
      onTap: () {
        Provider.of<CustomizationProvider>(context, listen: false)
            .updateCheetahImage(cheetahImagePath);
      },
      child: Card(
        child: Center(
          child: Image.asset(assetPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
