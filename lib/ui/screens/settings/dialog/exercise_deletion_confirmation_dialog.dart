import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/providers/exercise_deleted_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:provider/provider.dart';

class ExerciseDeletionConfirmationDialog extends StatelessWidget {

  final String title;
  final String buttonText;
  final Function onButtonPressed;

  const ExerciseDeletionConfirmationDialog({
    Key? key,
    required this.buttonText,
    required this.title,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            color: themeDataProvider.themeData.mainTextColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: themeDataProvider.themeData.tileColor,
      content: ElevatedButton(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: themeDataProvider.themeData.mainTextColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(13),
          primary: themeDataProvider.themeData.themeData.primaryColor,
        ),
        onPressed: () {
          onButtonPressed();
          context.read<ExerciseDeletedProvider>().setIsExerciseDeleted(true);

          Navigator.of(context).pop();
        },
      ),
    );
  }

}