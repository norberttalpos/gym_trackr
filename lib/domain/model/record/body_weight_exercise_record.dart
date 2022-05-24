import 'package:gym_trackr/domain/model/record/record.dart';

class BodyWeightExerciseRecord implements Record {

  int reps;

  BodyWeightExerciseRecord({
    required this.reps,
  });

  @override
  int getReps() => reps;
}