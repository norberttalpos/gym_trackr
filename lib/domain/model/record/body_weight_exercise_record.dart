import 'package:gym_trackr/domain/model/record/record.dart';

class BodyWeightExerciseRecord extends Record {

  BodyWeightExerciseRecord({
    required reps,
    DateTime? date,
  }) : super(reps: reps, date: date);

}