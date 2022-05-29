import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';
import 'package:gym_trackr/ui/common/providers/details_page_shown_provider.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
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

  Widget _buildList(AsyncSnapshot<Exercise?> exerciseSnap) {

    if (exerciseSnap.hasData) {
      List<Record> exerciseRecords = exerciseSnap.data!.records.toList();

      if (exerciseRecords.isNotEmpty) {
        return ListView.builder(
            itemCount: exerciseRecords.length,
            itemBuilder: (BuildContext context, int idx) {
              Record record = exerciseRecords[idx];

              if (exerciseSnap.data!.isBodyWeightExercise()) {
                return DetailsBodyWeightExerciseTile(exerciseRecord: record);
              } else if (exerciseSnap.data!.isWeightedExercise()) {
                return DetailsWeightedExerciseTile(exerciseRecord: record);
              } else {
                throw Exception(
                    "Illegal state: not body-weight or weighted exercise");
              }
            });
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
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
          ),
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
    final themeDataProvider = context.watch<ThemeDataProvider>();
    final dataSourceProvider = context.watch<ExerciseDataSourceProvider>();

    return FutureBuilder<Exercise?>(
        future: dataSourceProvider.getExerciseByName(widget.exerciseName),
        builder: (context, exerciseSnap) {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<DetailsPageShownProvider>(context, listen: false).setDetailsPageShown(false, "");
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: themeDataProvider.themeData.mainTextColor,
                      size: 28,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(13),
                      primary: themeDataProvider.themeData.tileColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 150,
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
                            padding: const EdgeInsets.only(right: 5),
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
