import 'package:flutter/material.dart';
import 'package:gym_trackr/data/exercise_data_source.dart';
import 'package:gym_trackr/data/implementation/mock/mock_exercise_data_source.dart';
import 'package:gym_trackr/domain/model/exercise/exercise.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ExerciseDataSource dataSource = MockExerciseDataSource();

  Widget _buildExerciseScore(Exercise exercise) {
    return Text(
      exercise.getDisplayedScore().toString(),
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildExerciseTile(Exercise exercise) {

    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: const Offset(3.0, 3.0)
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: const Image(
                  height: 80.0,
                  width: 80.0,
                  image: NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
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
                        child: Text(
                          exercise.name,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      _buildExerciseScore(exercise),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Exercise>>(
                    future: dataSource.getExercises(),
                    builder: (context, exerciserListSnap) {

                    if(exerciserListSnap.hasData) {
                      List<Exercise> trackedExercises = exerciserListSnap.data!.where((el) => el.tracked).toList();

                      return ListView.builder(
                          itemCount: trackedExercises.length,
                          itemBuilder: (BuildContext context, int idx) {
                              return _buildExerciseTile(trackedExercises[idx]);
                          });
                    } else {
                        return ListView();
                    }
                  }
                )
            )
          ]
        )
      ),
    );
  }
}