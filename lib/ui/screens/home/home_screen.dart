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
        print(exercise.getRecords().first.formattedDate());
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(246, 202, 189, 0.4),
                spreadRadius: 3.0,
                blurRadius: 8.0,
                offset: Offset(5.0, 5.0))
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
                  image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3412/3412862.png"),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise.name,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(
                                height: 6,
                            ),
                            Text(
                              exercise.getDisplayDate(),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
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

  int _currentTab = 0;

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
                  if (exerciserListSnap.hasData) {
                    List<Exercise> trackedExercises = exerciserListSnap.data!
                        .where((el) => el.tracked)
                        .toList();

                    return ListView.builder(
                        itemCount: trackedExercises.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return _buildExerciseTile(trackedExercises[idx]);
                        });
                  } else {
                    return ListView();
                  }
                }))
      ])),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
            ),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
