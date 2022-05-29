import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/ui/common/exercise_tile_base.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/settings/dialog/add_exercise_dialog.dart';
import 'package:provider/src/provider.dart';

import '../dialog/exercise_deletion_confirmation_dialog.dart';

class SettingsExerciseTile extends StatefulWidget {
  final Exercise exercise;
  final bool deleteMode;

  const SettingsExerciseTile({
    Key? key,
    required this.exercise,
    required this.deleteMode,
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
    final dataSourceProvider = context.watch<ExerciseDataSourceProvider>();

    _buildInteractionWidget() {
      if(!widget.deleteMode) {
        return Switch(
          value: _isTracked,
          onChanged: (val) {
            _setIsTracked(val);
          },
          inactiveThumbColor: themeDataProvider.themeData.themeData.scaffoldBackgroundColor,
          activeColor: themeDataProvider.themeData.themeData.primaryColor,
          activeTrackColor: themeDataProvider.themeData.themeData.primaryColor,
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ExerciseDeletionConfirmationDialog(
                      title: "Are you sure you want to delete ${widget.exercise.name}?",
                      buttonText: "Delete",
                      onButtonPressed: () {
                        dataSourceProvider.deleteExercise(widget.exercise.name);
                      },
                    );
                  }
              );
            },
            child: Icon(
              Icons.delete,
              color: themeDataProvider.themeData.mainTextColor,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              primary: Colors.red.shade700,
            ),
          ),
        );
      }
    }

    return ExerciseTileBase(
      onTap: () {
        if(!widget.deleteMode) {
          _setIsTracked(!_isTracked);
        }
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
                    _buildInteractionWidget(),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}