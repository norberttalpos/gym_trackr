import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/ui/common/exercise_tile_base.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

class HomeExerciseTile extends StatelessWidget {
  final Exercise exercise;

  const HomeExerciseTile({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    return ExerciseTileBase(
      onTap: () {

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const Image(
              height: 80.0,
              width: 80.0,
              image: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/3412/3412862.png"),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name,
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w600,
                              color: themeDataProvider.themeData.mainTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            exercise.getDisplayDate(),
                            style: TextStyle(
                              fontSize: 15.5,
                              color: themeDataProvider.themeData.themeData.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      exercise.getDisplayedScore().toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: themeDataProvider.themeData.mainTextColor,
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}