import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';

import '../record/record.dart';

class WeightedExercise extends Exercise {

  List<WeightedExerciseRecord> records;

  WeightedExercise({
    required name,
    required img,
    required tracked,
    required this.records,
  }) : super(name: name, img: img, tracked: tracked);

  @override
  List<Record> getRecords() => records;

  @override
  String getDisplayedScore() =>
      '${records.first.calculateOneRepMax().toString()} kg';
}