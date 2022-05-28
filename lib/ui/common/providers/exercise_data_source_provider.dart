import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/mock/mock_exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/persistent/floor_exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';

class ExerciseDataSourceProvider with ChangeNotifier {

  final ExerciseDataSource _exerciseDataSource = MockExerciseDataSource();

  Future<List<Exercise>> getExercises() {
    return _exerciseDataSource.getExercises();
  }

  Future<Exercise?> getExerciseByName(String name) {
    return _exerciseDataSource.getExerciseByName(name);
  }

  Future<void> updateExercise(Exercise exercise) async {
    _exerciseDataSource.updateExercise(exercise);
    notifyListeners();
  }

  Future<void> insertExercise(Exercise exercise) async {
    _exerciseDataSource.insertExercise(exercise);
    notifyListeners();
  }
}