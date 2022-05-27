import 'package:flutter/material.dart';
import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/mock/mock_exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/record/body_weight_exercise_record.dart';
import 'package:gym_trackr/domain/model/record/record.dart';
import 'package:gym_trackr/domain/model/record/weighted_exercise_record.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/details/components/exercise_profile.dart';
import 'package:provider/src/provider.dart';

import 'components/add_record_button.dart';
import 'components/list/details_bw_exercise_tile.dart';
import 'components/list/details_weighted_exercise_tile.dart';

class DetailsScreen extends StatefulWidget {
  final String exerciseName;

  const DetailsScreen({Key? key, required this.exerciseName}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ExerciseDataSource dataSource = MockExerciseDataSource();

  Widget _buildList(AsyncSnapshot<Exercise?> exerciseSnap) {
    if (exerciseSnap.hasData) {
      List<Record> exerciseRecords = exerciseSnap.data!.getRecords().toList();

      if (exerciseRecords.isNotEmpty) {
        return ListView.builder(
            itemCount: exerciseRecords.length,
            itemBuilder: (BuildContext context, int idx) {
              Record record = exerciseRecords[idx];

              if (record is BodyWeightExerciseRecord) {
                return DetailsBodyWeightExerciseTile(exerciseRecord: record);
              } else if (record is WeightedExerciseRecord) {
                return DetailsWeightedExerciseTile(exerciseRecord: record);
              } else {
                throw Exception(
                    "Illegal state: not body-weight or weighted exercise");
              }
            });
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No records yet",
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w600,
                color:
                    context.watch<ThemeDataProvider>().themeData.mainTextColor,
              ),
              maxLines: 1,
            ),
          ],
        );
      }
    } else {
      return ListView();
    }
  }

  Widget _buildExerciseProfile(AsyncSnapshot exerciseSnap) {
    if (exerciseSnap.hasData) {
      return ExerciseProfile(
        exercise: exerciseSnap.data!,
      );
    } else {
      return Container();
    }
  }

  Widget _buildAddRecordButton(AsyncSnapshot<Exercise?> exerciseSnap) {
    if(exerciseSnap.hasData) {
      return AddRecordButton(exercise: exerciseSnap.data!,);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Exercise?>(
        future: dataSource.getExerciseByName(widget.exerciseName),
        builder: (context, exerciseSnap) {
          return Column(children: [
            SizedBox(
              height: 180,
              child: _buildExerciseProfile(exerciseSnap),
            ),
            Expanded(
              child: Stack(
                children: [
                  _buildList(exerciseSnap),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12, bottom: 3),
                            child: _buildAddRecordButton(exerciseSnap),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ]);
        });
  }
}
