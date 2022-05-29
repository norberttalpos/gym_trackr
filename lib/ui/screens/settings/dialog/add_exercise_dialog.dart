import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

import '../../details/dialog/dialog_base.dart';

class AddExerciseDialog extends StatefulWidget {

  final String buttonText;

  const AddExerciseDialog({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {

  String _exerciseType = "BodyWeight";
  final _exerciseNameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();
    final dataSourceProvider = context.watch<ExerciseDataSourceProvider>();

    final exerciseTypes = ["BodyWeight", "Weighted"];

    List<Widget> _buildForm() {

      return [
        DialogBase.createTextFormFieldOwnController(
            "Name",
            themeDataProvider.themeData,
            _exerciseNameInputController
        ),
        const SizedBox(height: 20,),
        DropdownButtonFormField(
          value: _exerciseType,
          items: exerciseTypes.map((e) => DropdownMenuItem(
            value: e,
            child: Container(
              child: Text(
                e,
              ),
              alignment: Alignment.centerLeft,
              width: 200,
              height: 70,
            ),

          )).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _exerciseType = newValue!;
            });
          },
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themeDataProvider.themeData.themeData.primaryColor,
                  width: 1.0
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themeDataProvider.themeData.themeData.scaffoldBackgroundColor,
                  width: 1.0
              ),
            ),
          ),
        )
      ];
    }

    return AlertDialog(
      title: Text(
        "Add exercise",
        style: TextStyle(
          color: themeDataProvider.themeData.mainTextColor,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        ),
      backgroundColor: themeDataProvider.themeData.tileColor,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ..._buildForm(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      widget.buttonText,
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
                      final inputName = _exerciseNameInputController.text;
                      if(inputName.isNotEmpty) {
                        dataSourceProvider.createExercise(
                            inputName,
                            _exerciseType == "BodyWeight" ? "bodyWeight" : "weighted"
                        );

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}