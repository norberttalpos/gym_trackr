import '../record/record.dart';

abstract class Exercise {
  String name;
  String img;
  bool tracked;

  Exercise({
    required this.name,
    required this.img,
    required this.tracked
  });

  List<Record> getRecords();

  String getDisplayedScore();
}