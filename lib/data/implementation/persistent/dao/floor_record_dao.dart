import 'package:floor/floor.dart';
import 'package:gym_trackr/data/implementation/persistent/entity/record.dart';

@dao
abstract class RecordDao {

  @Query('SELECT * FROM record WHERE exerciseName = :exerciseName')
  Future<List<FloorRecord>> getRecordsOfExercise(String exerciseName);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecord(FloorRecord record);
}