import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/mock/mock_exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise/body_weight_exercise.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/exercise/weighted_exercise.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';
import 'package:gym_trackr/domain/model/record/record.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';
import 'package:gym_trackr/ui/common/dialog_base.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';

class AddRecordDialog extends DialogBase {

  AddRecordDialog({
    Key? key,
    required Exercise exercise,
    required textFormFields,
  }) : super(
    key: key,
    exerciseName: exercise.name,
    textFormFields: textFormFields,
    title: "Add ${exercise.name} result",
    buttonText: "Add result",
  );

  @override
  void addRecordButtonClickHandler(
      List<String> values,
      ExerciseDataSourceProvider exerciseDataSourceProvider
      ) async {

    Exercise? exercise = await exerciseDataSourceProvider.getExerciseByName(exerciseName);

    if(exercise is BodyWeightExercise) {
      exerciseDataSourceProvider.updateExercise(exercise..records.add(
        BodyWeightExerciseRecord(reps: int.parse(values[0]))
      ));
    } else if(exercise is WeightedExercise) {
      exerciseDataSourceProvider.updateExercise(exercise..records.add(
          WeightedExerciseRecord(reps: int.parse(values[0]), weight: double.parse(values[1]))
      ));
    }
  }
}