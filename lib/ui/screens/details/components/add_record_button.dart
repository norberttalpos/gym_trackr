import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:provider/src/provider.dart';

class AddRecordButton extends StatelessWidget {

  const AddRecordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {

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