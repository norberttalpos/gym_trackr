import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

class ExerciseProfile extends StatelessWidget {
  final Exercise exercise;

  const ExerciseProfile({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  String _scoreLabel() {
    return exercise.isBodyWeightExercise() ? "Max" : "One-rep max";
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    const imageSize = 130.0;

    _buildScoreCard(BuildContext context) {
      final themeDataProvider = context.watch<ThemeDataProvider>();

      if(exercise.records.isNotEmpty) {
        return Card(
            elevation: 4.0,
            color: themeDataProvider.themeData.tileColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    _scoreLabel(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: themeDataProvider.themeData.mainTextColor,
                    ),
                  ),
                  Text(
                    exercise.getDisplayedScore(),
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: themeDataProvider.themeData.themeData.primaryColor,
                    ),
                  ),
                ],
              ),
            )
        );
      } else {
        return Container();
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: Card(
                        elevation: 4.0,
                        color: themeDataProvider.themeData.tileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            width: 3,
                            color:
                            themeDataProvider.themeData.themeData.primaryColor,
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/512/3412/3412862.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w500,
                                  color: context
                                      .watch<ThemeDataProvider>()
                                      .themeData
                                      .mainTextColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: _buildScoreCard(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              )
          )
        ]
    );
  }
}
