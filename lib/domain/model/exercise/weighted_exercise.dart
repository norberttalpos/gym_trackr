import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/exercise/record_orderable_mixin.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';

import '../record/record.dart';

class WeightedExercise extends Exercise with RecordOrderableMixin {

  List<WeightedExerciseRecord> records;

  WeightedExercise({
    required name,
    required imgPath,
    required tracked,
    required this.records,
  }) : super(name: name, imgPath: imgPath, tracked: tracked);

  @override
  List<Record> getRecords() => records;

  @override
  String getDisplayedScore() =>
      records.isNotEmpty ? '${roundDouble(records.first.calculateOneRepMax())} kg' : "-";

  static double roundDouble(double num) {
    double fraction = num - num.truncate();
    if(fraction < 0.5) {
      return num.truncateToDouble();
    } else {
      return num.truncateToDouble() + 0.5;
    }
  }

  @override
  void orderRecords() {
    orderRecordList(records);
  }
}