import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;

  setBottomIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
