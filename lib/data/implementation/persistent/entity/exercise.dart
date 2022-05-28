import 'package:floor/floor.dart';

@Entity(
    tableName: "exercise"
)
class FloorExercise {

  @PrimaryKey()
  String name;
  String imgPath;
  bool tracked;
  String type;

  FloorExercise({
    required this.name,
    required this.imgPath,
    required this.tracked,
    required this.type,
  });
}