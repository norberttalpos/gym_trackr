import 'package:floor/floor.dart';
import 'package:gym_trackr/data/implementation/persistent/entity/exercise.dart';

@Entity(
  tableName: "record",
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_name'],
      parentColumns: ['name'],
      entity: FloorExercise,
    )
  ],
)
class FloorRecord {

  @PrimaryKey(autoGenerate: true)
  int? id;
  int reps;
  double? weight;
  int date;
  @ColumnInfo(name: 'exercise_name')
  int exerciseName;

  FloorRecord({
    int? id,
    required this.reps,
    int? date,
    double? weight,
    required this.exerciseName,
  }) : id = id, weight = weight, date = date ?? DateTime.now().millisecondsSinceEpoch;

}