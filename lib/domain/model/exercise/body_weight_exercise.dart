import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';
import 'package:gym_trackr/domain/model/exercise/record_orderable_mixin.dart';

import '../record/record.dart';

class BodyWeightExercise extends Exercise with RecordOrderableMixin {

  List<BodyWeightExerciseRecord> records;

  BodyWeightExercise({
    required name,
    required imgPath,
    required tracked,
    required this.records,
  }) : super(name: name, imgPath: imgPath, tracked: tracked);

  @override
  List<Record> getRecords() => records;

  @override
  String getDisplayedScore() =>
      records.isNotEmpty ? '${records.first.reps.toString()} reps' : "-";

  @override
  void orderRecords() {
    orderRecordList(records);
  }
}