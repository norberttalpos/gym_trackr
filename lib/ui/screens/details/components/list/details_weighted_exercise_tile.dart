import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise/weighted_exercise.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

import 'details_exercise_tile_base.dart';

class DetailsWeightedExerciseTile extends DetailsExerciseTileBase {
  final WeightedExerciseRecord exerciseRecord;

  const DetailsWeightedExerciseTile({
    Key? key,
    required this.exerciseRecord,
  }) : super(key: key);

  @override
  List<Widget> buildTileColumns(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    return [
      buildDetailsExerciseTileColumn(
          title: "Date",
          data: exerciseRecord.formattedDate(),
          themeData: themeDataProvider.themeData,
      ),
      buildDetailsExerciseTileColumn(
          title: "Reps",
          data: exerciseRecord.reps.toString(),
          themeData: themeDataProvider.themeData,
          fontSize: 23,
      ),
      buildDetailsExerciseTileColumn(
          title: "Weight",
          data: "${WeightedExercise.roundDouble(exerciseRecord.weight).toString()} kg",
          themeData: themeDataProvider.themeData,
          fontSize: 23,
      ),
    ];
  }

}