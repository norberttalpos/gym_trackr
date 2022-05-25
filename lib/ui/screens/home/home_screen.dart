import 'package:flutter/material.dart';
import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/mock/mock_exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';
import 'package:gym_trackr/ui/screens/home/components/home_exercise_tile.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExerciseDataSource dataSource = MockExerciseDataSource();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: FutureBuilder<List<Exercise>>(
          future: dataSource.getExercises(),
          builder: (context, exerciserListSnap) {
            if (exerciserListSnap.hasData) {
              List<Exercise> trackedExercises = exerciserListSnap.data!
                  .where((el) => el.tracked)
                  .toList();

              return ListView.builder(
                  itemCount: trackedExercises.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return HomeExerciseTile(
                        exercise: trackedExercises[idx],
                    );
                  });
            } else {
              return ListView();
            }
          },
        ),
      )
    ]);
  }
}
