import '../record/record.dart';

abstract class Exercise {
  String name;
  String imgPath;
  bool tracked;

  Exercise({
    required this.name,
    required this.imgPath,
    required this.tracked
  });

  List<Record> getRecords();

  String getDisplayedScore();

  String getDisplayDate() {
    return getRecords().first.formattedDate();
  }
}