import 'package:gym_trackr/domain/model/exercise.dart';

class User {
  String email;
  List<Exercise> exercises;

  User({
    required this.email,
    required this.exercises,
  });
}