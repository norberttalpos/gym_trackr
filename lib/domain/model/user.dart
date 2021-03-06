import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String userId;
  List<Exercise> exercises;

  User({
    required this.userId,
    List<Exercise>? exercises,
  }) : exercises = exercises ?? [];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}