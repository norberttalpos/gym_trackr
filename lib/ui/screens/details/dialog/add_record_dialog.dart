import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';
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

    var record = exercise!.isBodyWeightExercise() ?
      Record(reps: int.parse(values[0])) : Record(reps: int.parse(values[0]), weight: double.parse(values[1]));

    exerciseDataSourceProvider.addRecordToExercise(exerciseName, record);
  }
}