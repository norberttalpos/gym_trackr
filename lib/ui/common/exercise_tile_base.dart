import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:provider/provider.dart';

class ExerciseTileBase extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const ExerciseTileBase({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          height: 110.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.watch<ThemeDataProvider>().themeData.tileColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              context.watch<ThemeDataProvider>().themeData.tileShadow,
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: child,
          ),
        )
    );
  }
}