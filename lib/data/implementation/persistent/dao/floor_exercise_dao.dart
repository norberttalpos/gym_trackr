import 'package:floor/floor.dart';
import 'package:gym_trackr/data/implementation/persistent/entity/exercise.dart';

@dao
abstract class ExerciseDao {

  @Query('SELECT * FROM exercise')
  Future<List<FloorExercise>> getExercises();

  @Query('SELECT * FROM exercise WHERE name = :name')
  Future<FloorExercise?> getExerciseByName(String name);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateExercise(FloorExercise exercise);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertExercise(FloorExercise exercise);
}