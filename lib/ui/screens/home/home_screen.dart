import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/ui/common/providers/details_page_shown_provider.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/details/details_screen.dart';
import 'package:gym_trackr/ui/screens/home/components/home_exercise_tile.dart';
import 'package:provider/provider.dart';

import '../../common/providers/exercise_deleted_provider.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool detailsPageShown = false;

  @override
  Widget build(BuildContext context) {
    final detailsPageShownProvider = context.watch<DetailsPageShownProvider>();
    final dataSourceProvider = context.watch<ExerciseDataSourceProvider>();
    final themeDataProvider = context.watch<ThemeDataProvider>();

    if(!detailsPageShownProvider.detailsPageShown || context.read<ExerciseDeletedProvider>().exerciseDeleted) {
      if(context.read<ExerciseDeletedProvider>().exerciseDeleted) {
        context.read<ExerciseDeletedProvider>().setIsExerciseDeleted(false);
        context.read<DetailsPageShownProvider>().setDetailsPageShown(val: false);
      }

      return Column(children: [
        Expanded(
          child: FutureBuilder<List<Exercise>>(
            future: dataSourceProvider.getExercises(),
            builder: (context, exerciserListSnap) {
              if (exerciserListSnap.hasData) {
                List<Exercise> trackedExercises = exerciserListSnap.data!
                    .where((el) => el.tracked)
                    .toList();

                if(trackedExercises.isEmpty) {
                  return Center(
                    child: Text(
                      "No tracked exercises",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: themeDataProvider.themeData.tileColor,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: trackedExercises.length,
                      itemBuilder: (BuildContext context, int idx) {
                        return HomeExerciseTile(
                          exercise: trackedExercises[idx],
                        );
                      });
                }
              } else {
                return ListView();
              }
            },
          ),
        )
      ]);
    } else {
      return DetailsScreen(exerciseName: detailsPageShownProvider.selectedExercise);
    }
  }
}
