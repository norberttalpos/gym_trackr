import 'record.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable(explicitToJson: true)
class Exercise {

  String name;
  bool tracked;
  List<Record> records;
  String type;

  Exercise({
    required this.name,
    required this.tracked,
    required this.type,
    List<Record>? records,
  }) : records = records ?? [];

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  static double roundDouble(double num) {
    double fraction = num - num.truncate();
    if(fraction < 0.5) {
      return num.truncateToDouble();
    } else {
      return num.truncateToDouble() + 0.5;
    }
  }

  String getDisplayedScore() {
    if(isWeightedExercise()) {
      return
        records.isNotEmpty ? '${roundDouble(records.first.calculateOneRepMax())} kg' : "";
    } else {
      return
        records.isNotEmpty ? '${records.first.reps.toString()} reps' : "";
    }
  }

  String getDisplayDate() {
    return records.isNotEmpty ? records.first.formattedDate() : "Empty";
  }

  bool isWeightedExercise() {
    return type == "weighted";
  }

  bool isBodyWeightExercise() {
    return type == "bodyWeight";
  }
}