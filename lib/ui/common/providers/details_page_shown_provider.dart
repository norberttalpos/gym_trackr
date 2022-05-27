import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsPageShownProvider with ChangeNotifier {

  void setDetailsPageShown(bool val, String exercise) {
    _detailsPageShown = val;
    _selectedExercise = exercise;
    notifyListeners();
  }

  bool _detailsPageShown = false;

  String _selectedExercise = "";

  bool get detailsPageShown => _detailsPageShown;

  String get selectedExercise => _selectedExercise;
}