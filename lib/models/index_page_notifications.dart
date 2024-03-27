import 'package:flutter/foundation.dart';

class IndexPageNotifications with ChangeNotifier {
  int _selectedIndex = 0;

  int get index => _selectedIndex;

  void setIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}