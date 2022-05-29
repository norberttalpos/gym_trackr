import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/data/exercise/exercise_data_source.dart';
import 'package:gym_trackr/data/exercise/implementation/firestore/firestore_exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';

class ExerciseDataSourceProvider with ChangeNotifier {

  final ExerciseDataSource _exerciseDataSource = FireStoreExerciseDataSource();

  Future<List<Exercise>> getExercises() {
    return _exerciseDataSource.getExercises();
  }

  Future<Exercise?> getExerciseByName(String name) {
    return _exerciseDataSource.getExerciseByName(name);
  }

  Future<void> addRecordToExercise(String exerciseName, Record record) async {
    await _exerciseDataSource.addRecordToExercise(exerciseName, record);
    notifyListeners();
  }

  Future<void> toggleTracked(String exerciseName, bool isTracked) async {
    await _exerciseDataSource.toggleTracked(exerciseName, isTracked);
    notifyListeners();
  }

  Future<void> createExercise(String exerciseName, String type) async {
    await _exerciseDataSource.createExercise(exerciseName, type);
    notifyListeners();
  }

  Future<void> deleteExercise(String exerciseName) async {
    await _exerciseDataSource.deleteExercise(exerciseName);
    notifyListeners();
  }
}
