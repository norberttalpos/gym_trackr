import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';

abstract class ExerciseDataSource {

  ExerciseDataSource() {
    init();
  }

  Future<void> init();

  Future<List<Exercise>> getExercises();

  Future<Exercise?> getExerciseByName(String name);

  Future<void> addRecordToExercise(String exerciseName, Record record);

  Future<void> createExercise(String exerciseName, String type);

  Future<void> toggleTracked(String exerciseName, bool isTracked);

  Future<void> deleteExercise(String exerciseName);
}