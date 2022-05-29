import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable(explicitToJson: true)
class Record {

  int reps;
  double? weight;
  DateTime date;

  Record({
    required this.reps,
    this.weight,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);

  String formattedDate() {
    final DateFormat formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(date);
  }

  double calculateOneRepMax() {
    return weight! * (36 / (37 - reps));
  }
}