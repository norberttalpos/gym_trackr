import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/settings/dialog/add_exercise_dialog.dart';
import 'package:provider/src/provider.dart';

class AddExerciseButton extends StatelessWidget {

  const AddExerciseButton({
    Key? key,
  }) : super(key: key);

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
                  return const AddExerciseDialog(
                    buttonText: "Add exercise",
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