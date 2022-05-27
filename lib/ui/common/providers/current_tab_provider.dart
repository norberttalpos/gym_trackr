import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrentTabProvider with ChangeNotifier {

  void setCurrentTab(int val) {
    _currentTab = val;
    notifyListeners();
  }

  int _currentTab = 0;

  int get currentTab => _currentTab;
}