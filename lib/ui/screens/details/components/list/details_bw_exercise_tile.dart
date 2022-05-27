import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

import 'details_exercise_tile_base.dart';

class DetailsBodyWeightExerciseTile extends DetailsExerciseTileBase {
  final BodyWeightExerciseRecord exerciseRecord;

  const DetailsBodyWeightExerciseTile({
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
          fontSize: 24,
      ),
    ];
  }

}