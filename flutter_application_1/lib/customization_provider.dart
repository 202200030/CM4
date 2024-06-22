import 'package:flutter/material.dart';

class CustomizationProvider extends ChangeNotifier {
  String _defaultCheetahImage = 'assets/chita.png';
  String _cheetahImage = 'assets/chita.png';
  String _lastSelectedImage = '';

  String get cheetahImage => _cheetahImage;

  void updateCheetahImage(String newImage) {
    if (_cheetahImage == newImage) {
      _cheetahImage = _defaultCheetahImage;
      _lastSelectedImage = '';
    } else {
      _cheetahImage = newImage;
      _lastSelectedImage = newImage;
    }
    notifyListeners();
  }
}
