import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/ui/common/theme_data.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/details/dialog/add_record_dialog.dart';
import 'package:gym_trackr/ui/screens/details/dialog/dialog_base.dart';
import 'package:provider/src/provider.dart';

class AddRecordButton extends StatelessWidget {

  final Exercise exercise;

  const AddRecordButton({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    List<TextFormField> _buildTextFormFields(CustomThemeData themeData) {

      final textFormFields = [
        DialogBase.createTextFormField("Reps", themeData)
      ];

      if(exercise.isWeightedExercise()) {
        textFormFields.add(DialogBase.createTextFormField("Weight", themeData));
      }

      return textFormFields;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddRecordDialog(
                  exercise: exercise,
                  textFormFields: _buildTextFormFields(
                    themeDataProvider.themeData,
                  ),
                );
              }
          );
        },
        child: Icon(
          Icons.add,
          color: themeDataProvider.themeData.mainTextColor,
          size: 35,
        ),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(13),
          primary: themeDataProvider.themeData.themeData.primaryColor,
        ),
      )
    );
  }
}