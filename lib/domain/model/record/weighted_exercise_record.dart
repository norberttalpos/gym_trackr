import 'package:gym_trackr/domain/model/record/record.dart';

class WeightedExerciseRecord implements Record {

  int reps;
  double weight;

  WeightedExerciseRecord({
    required this.reps,
    required this.weight
  });

  @override
  int getReps() => reps;

  double getWeight() => weight;

  double calculateOneRepMax() {
    return weight * (36 / (37 - reps));
  }
}