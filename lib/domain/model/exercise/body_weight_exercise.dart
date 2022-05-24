import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';

import '../record/record.dart';

class BodyWeightExercise extends Exercise {

  List<BodyWeightExerciseRecord> records;

  BodyWeightExercise({
    required name,
    required img,
    required tracked,
    required this.records,
  }) : super(name: name, img: img, tracked: tracked);

  @override
  List<Record> getRecords() => records;

  @override
  String getDisplayedScore() =>
      '${records.first.reps.toString()} reps';
}