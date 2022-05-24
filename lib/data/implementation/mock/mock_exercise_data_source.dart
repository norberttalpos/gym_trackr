import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise/body_weight_exercise.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/exercise/weighted_exercise.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';

class MockExerciseDataSource implements ExerciseDataSource {

  final List<Exercise> _exerciseList = [
    BodyWeightExercise(name: "Pull up", imgPath: "pull_up.png", tracked: true, records: [
      BodyWeightExerciseRecord(reps: 15),
      BodyWeightExerciseRecord(reps: 13)
    ]),
    BodyWeightExercise(name: "Dip", imgPath: "dip.png", tracked: true, records: [
      BodyWeightExerciseRecord(reps: 10),
      BodyWeightExerciseRecord(reps: 12)
    ]),
    BodyWeightExercise(name: "Pistol squat", imgPath: "pistol_squat.png", tracked: false, records: []),
    WeightedExercise(name: "Bench press", imgPath: "bench_press.png", tracked: true, records: [
      WeightedExerciseRecord(reps: 10, weight: 90.0),
      WeightedExerciseRecord(reps: 5, weight: 105.0),
    ]),
  ];

  @override
  Future<List<Exercise>> getExercises() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _exerciseList;
  }

  @override
  Future<Exercise?> getExerciseByName(String name) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _exerciseList.firstWhere((el) => el.name == name);
  }

  @override
  Future<void> updateExercise(Exercise exercise) async {
    int idx = _exerciseList.indexWhere((el) => el.name == exercise.name);
    _exerciseList[idx] = exercise;
  }

  @override
  Future<void> insertExercise(Exercise exercise) async {
    _exerciseList.add(exercise);
  }
}