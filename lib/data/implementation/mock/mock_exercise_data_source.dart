import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';

class MockExerciseDataSource implements ExerciseDataSource {

  late List<Exercise> _exerciseList;

  MockExerciseDataSource() {
    init();
  }

  @override
  Future<void> init() async {

    _exerciseList = [
      Exercise(name: "Pull up", tracked: true, type: 'bodyWeight', records: [
        Record(reps: 15),
        Record(reps: 13),
      ]),
      Exercise(name: "Dip", tracked: true, type: 'bodyWeight', records: [
        Record(reps: 15),
        Record(reps: 13),
      ]),
      Exercise(name: "Pistol squat", tracked: false, type: "bodyWeight"),
      Exercise(name: "Bench press", tracked: true, type: "weighted", records: [
        Record(reps: 10, weight: 95.0),
        Record(reps: 10, weight: 90.0),
        Record(reps: 5, weight: 105.0),
      ]),
      Exercise(name: "Back squat", tracked: true, type: "weighted", records: [
        Record(reps: 10, weight: 110.0),
        Record(reps: 5, weight: 130.0),
      ]),
      Exercise(name: "Deadlift", tracked: true, type: "weighted", records: [
        Record(reps: 10, weight: 120.0),
        Record(reps: 5, weight: 150.0),
        Record(reps: 10, weight: 120.0),
        Record(reps: 5, weight: 150.0),
        Record(reps: 10, weight: 120.0),
        Record(reps: 5, weight: 150.0),
        Record(reps: 10, weight: 120.0),
        Record(reps: 5, weight: 150.0),
      ]),
      Exercise(name: "Bicep curl", tracked: true, type: "weighted", records: [
        Record(reps: 10, weight: 18.0),
        Record(reps: 12, weight: 16.0),
      ]),
    ];
  }

  @override
  Future<List<Exercise>> getExercises() async {
    return _exerciseList;
  }

  @override
  Future<Exercise?> getExerciseByName(String name) async {
    return _exerciseList.firstWhere((el) => el.name == name);
  }

  @override
  Future<void> addRecordToExercise(String exerciseName, Record record) async {
    int idx = _exerciseList.indexWhere((el) => el.name == exerciseName);
    _exerciseList[idx].records.add(record);
  }

  @override
  Future<void> createExercise(String exerciseName, String type) async {
    _exerciseList.add(Exercise(name: exerciseName, tracked: true, type: type));
  }

  @override
  Future<void> toggleTracked(String exerciseName, bool isTracked) async {
    int idx = _exerciseList.indexWhere((el) => el.name == exerciseName);
    _exerciseList[idx].tracked = isTracked;
  }

  @override
  Future<void> deleteExercise(String exerciseName) async {
    int idx = _exerciseList.indexWhere((el) => el.name == exerciseName);
    _exerciseList.removeAt(idx);
  }
}