import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/domain/model/exercise/weighted_exercise.dart';
import 'package:gym_trackr/ui/common/theme_data.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/details/dialog/add_record_dialog.dart';
import 'package:provider/src/provider.dart';

class AddRecordButton extends StatelessWidget {

  final Exercise exercise;

  const AddRecordButton({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  TextFormField _createTextFormField(String labelText, CustomThemeData themeData) {

    final labelStyle = TextStyle(
      fontSize: 18.0,
      color: themeData.mainTextColor,
    );

    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: themeData.themeData.primaryColor,
              width: 1.0
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: themeData.themeData.scaffoldBackgroundColor,
              width: 1.0
          ),
        ),
      ),
      style: labelStyle,
      keyboardType: TextInputType.number,
      controller: TextEditingController(),
    );
  }

  List<TextFormField> _buildTextFormFields(CustomThemeData themeData) {

    final textFormFields = [
      _createTextFormField("Reps", themeData)
    ];

    if(exercise is WeightedExercise) {
      textFormFields.add(_createTextFormField("Weight", themeData));
    }

    return textFormFields;
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

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