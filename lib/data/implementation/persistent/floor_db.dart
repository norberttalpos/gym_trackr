import 'package:floor/floor.dart';
import 'package:gym_trackr/data/implementation/persistent/dao/floor_exercise_dao.dart';
import 'package:gym_trackr/data/implementation/persistent/dao/floor_record_dao.dart';
import 'package:gym_trackr/data/implementation/persistent/entity/record.dart';
import 'package:gym_trackr/data/implementation/persistent/entity/exercise.dart';

@Database(
  version: 1,
  entities: [
    FloorRecord,
    FloorExercise,
  ],
)
abstract class FloorExerciseDatabase extends FloorDatabase {
  ExerciseDao get exerciseDao;
  RecordDao get recordDao;
}
