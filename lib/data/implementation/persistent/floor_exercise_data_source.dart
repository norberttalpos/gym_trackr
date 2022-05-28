import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/persistent/dao/floor_exercise_dao.dart';
import 'package:gym_trackr/data/implementation/persistent/dao/floor_record_dao.dart';
import 'package:gym_trackr/domain/model/exercise/body_weight_exercise.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/exercise/weighted_exercise.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';

import 'entity/exercise_type.dart';
import 'entity/record.dart';

class FloorExerciseDataSource implements ExerciseDataSource {

  late ExerciseDao _exerciseDao;
  late RecordDao _recordDao;

  @override
  Future<void> init() async {
    final database = await $FloorExerciseDatabase
        .databaseBuilder("floor_exercise.db")
        .build();

    _exerciseDao = database.exerciseDao;
    _recordDao = database.recordDao;
  }

  List<BodyWeightExerciseRecord> _parseRecordsBW(List<FloorRecord> floorRecords) {
    return floorRecords.map(
            (e) => BodyWeightExerciseRecord(reps: e.reps, date: DateTime.fromMillisecondsSinceEpoch(e.date))
    ).toList();
  }

  List<WeightedExerciseRecord> _parseRecordsW(List<FloorRecord> floorRecords) {
    return floorRecords.map(
            (e) => WeightedExerciseRecord(reps: e.reps, weight: e.weight!, date: DateTime.fromMillisecondsSinceEpoch(e.date))
    ).toList();
  }

  @override
  Future<Exercise?> getExerciseByName(String name) async {
    var exercise = await _exerciseDao.getExerciseByName(name);
    var records = await _recordDao.getRecordsOfExercise(name);

    if(exercise!.type == ExerciseType.bodyWeight.name) {
      return
        BodyWeightExercise(
          name: exercise.name,
          imgPath: exercise.imgPath,
          tracked: exercise.tracked,
          records: _parseRecordsBW(records),
        );
    } else {
      return
        WeightedExercise(
          name: exercise.name,
          imgPath: exercise.imgPath,
          tracked: exercise.tracked,
          records: _parseRecordsW(records),
        );
    }
  }

  @override
  Future<List<Exercise>> getExercises() async  {
    var exercises = await _exerciseDao.getExercises();

    return exercises.map((exercise) async {
      var records = await _recordDao.getRecordsOfExercise(exercise.name);

      return
        WeightedExercise(
          name: exercise.name,
          imgPath: exercise.imgPath,
          tracked: exercise.tracked,
          records: _parseRecordsW(records),
        );
    }).toList();

/*
    throw UnimplementedError();
*/
  }

  @override
  Future<void> insertExercise(Exercise exercise) {
    // TODO: implement insertExercise
    throw UnimplementedError();
  }

  @override
  Future<void> updateExercise(Exercise exercise) {
    throw UnimplementedError();
  }

}