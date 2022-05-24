import 'package:gym_trackr/domain/model/exercise/exercise.dart';

abstract class ExerciseDataSource {

  Future<List<Exercise>> getExercises();

  Future<Exercise?> getExerciseByName(String name);

  Future<void> updateExercise(Exercise exercise);

  Future<void> insertExercise(Exercise exercise);
}