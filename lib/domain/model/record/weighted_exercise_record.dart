import 'package:gym_trackr/domain/model/record/record.dart';

class WeightedExerciseRecord extends Record {

  double weight;

  WeightedExerciseRecord({
    required reps,
    required this.weight,
    DateTime? date
  }) : super(reps: reps, date: date);

  double calculateOneRepMax() {
    return weight * (36 / (37 - reps));
  }

}