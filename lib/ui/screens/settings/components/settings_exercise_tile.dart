import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/ui/common/exercise_tile_base.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

class SettingsExerciseTile extends StatefulWidget {
  final Exercise exercise;

  const SettingsExerciseTile({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  State<SettingsExerciseTile> createState() => _SettingsExerciseTileState();
}

class _SettingsExerciseTileState extends State<SettingsExerciseTile> {

  late bool _isTracked;

  @override
  void initState() {
    super.initState();

    _isTracked = widget.exercise.tracked;
  }

  void _setIsTracked(bool isTracked) {
    setState(() {
      _isTracked = isTracked;
    });

    context.read<ExerciseDataSourceProvider>().toggleTracked(widget.exercise.name, isTracked);
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    return ExerciseTileBase(
      onTap: () {
        _setIsTracked(!_isTracked);
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
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.exercise.name,
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w600,
                              color: themeDataProvider.themeData.mainTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ]
                      )
                    ),
                    Switch(
                      value: _isTracked,
                      onChanged: (val) {
                        _setIsTracked(val);
                      },
                      activeColor: themeDataProvider.themeData.themeData.primaryColor,
                      activeTrackColor: themeDataProvider.themeData.themeData.primaryColor,
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