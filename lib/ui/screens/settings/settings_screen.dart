import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/settings/components/add_exercise_button.dart';
import 'package:provider/provider.dart';

import 'components/settings_exercise_tile.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool _trackMode = true;

  Widget _buildExerciseList(AsyncSnapshot<List<Exercise>> exerciseListSnapshot) {
    if (exerciseListSnapshot.hasData) {
      List<Exercise> exercises = exerciseListSnapshot.data!.toList();

      return ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (BuildContext context, int idx) {
          return SettingsExerciseTile(
            exercise: exercises[idx],
            deleteMode: !_trackMode,
          );
        },
      );
    } else {
      return ListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataSourceProvider = context.watch<ExerciseDataSourceProvider>();
    final themeDataProvider = context.watch<ThemeDataProvider>();

    _buildModeButton(AsyncSnapshot<List<Exercise>> exerciseListSnap) {
      if(exerciseListSnap.hasData && exerciseListSnap.data!.isNotEmpty) {
        return ElevatedButton(
          child: Text(
            !_trackMode ? "Is tracked" : "Delete",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: themeDataProvider.themeData.mainTextColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.all(13),
            primary: themeDataProvider.themeData.tileColor,
          ),
          onPressed: () {
            setState(() {
              _trackMode = !_trackMode;
            });
          },
        );
      } else {
        return Container();
      }
    }

    return FutureBuilder<List<Exercise>>(
        future: dataSourceProvider.getExercises(),
        builder: (context, exerciserListSnap) {
          return Column(children: [
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      themeDataProvider.isLightTheme ? "Dark mode" : "Light mode",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: themeDataProvider.oppositeThemeData.mainTextColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding: const EdgeInsets.all(15),
                      primary: themeDataProvider.oppositeThemeData.tileColor,
                    ),
                    onPressed: () {
                      themeDataProvider.toggleDarkMode();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Exercises",
                      style: TextStyle(
                        fontSize: 47,
                        fontWeight: FontWeight.w800,
                        color: themeDataProvider.themeData.tileColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _buildModeButton(exerciserListSnap),
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildExerciseList(exerciserListSnap),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: AddExerciseButton(),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]);
        }
    );
  }
}