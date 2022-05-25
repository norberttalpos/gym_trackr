import 'package:intl/intl.dart';


abstract class Record {

  int reps;
  DateTime date;

  Record({
    required this.reps,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  String formattedDate() {
    final DateFormat formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(date);
  }
}