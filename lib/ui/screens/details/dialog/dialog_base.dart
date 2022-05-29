import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/common/theme_data.dart';
import 'package:provider/src/provider.dart';

abstract class DialogBase extends StatefulWidget {

  final String exerciseName;
  final List<TextFormField> textFormFields;
  final String title;
  final String buttonText;

  const DialogBase({
    Key? key,
    required this.exerciseName,
    required this.textFormFields,
    required this.title,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<DialogBase> createState() => _DialogBaseState();

  void addRecordButtonClickHandler(
      List<String> values,
      ExerciseDataSourceProvider exerciseDataSourceProvider
  );

  static TextFormField createTextFormField({
    required String labelText,
    required CustomThemeData themeData,
    TextEditingController? controller,
    TextInputType? textInputType,
  }) {

    controller ??= TextEditingController();
    textInputType ??= TextInputType.number;

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
      keyboardType: textInputType,
      controller: controller,
    );
  }
}

class _DialogBaseState extends State<DialogBase> {

  List<Widget> _buildTextFormFieldsWithPaddings() {
    return widget.textFormFields.map((e) =>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: e,
        )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();
    final dataSourceProvider = context.watch<ExerciseDataSourceProvider>();

    return AlertDialog(
      backgroundColor: themeDataProvider.themeData.tileColor,
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 23.0,
          fontWeight: FontWeight.w600,
          color: themeDataProvider.themeData.mainTextColor,
        ),
      ),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildTextFormFieldsWithPaddings(),
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
                      bool allFilled = true;

                      for (var element in widget.textFormFields) {
                        if(element.controller?.text.isEmpty ?? true) {
                          allFilled = false;
                        }
                      }

                      if(allFilled) {
                        widget.addRecordButtonClickHandler(
                            widget.textFormFields.map((e) => e.controller!.text).toList(),
                            dataSourceProvider
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