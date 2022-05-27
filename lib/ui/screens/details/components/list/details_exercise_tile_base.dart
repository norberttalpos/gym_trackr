import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/exercise_tile_base.dart';
import 'package:gym_trackr/ui/common/theme_data.dart';

abstract class DetailsExerciseTileBase extends StatelessWidget {

  const DetailsExerciseTileBase({
    Key? key,
  }) : super(key: key);

  Widget buildDetailsExerciseTileColumn({
    required String title,
    required String data,
    required CustomThemeData themeData,
    double fontSize = 19.5,
  }) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w600,
              color: themeData.themeData.primaryColor,
            ),
            maxLines: 1,
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: fontSize,
              color: themeData.mainTextColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  List<Widget> buildTileColumns(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildTileColumns(context),
      ),
    );
  }
}