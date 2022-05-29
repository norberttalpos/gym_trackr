import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExerciseDeletedProvider with ChangeNotifier {

  void setIsExerciseDeleted(bool val) {
    _exerciseDeleted = val;
    notifyListeners();
  }

  bool _exerciseDeleted = false;

  bool get exerciseDeleted => _exerciseDeleted;
}