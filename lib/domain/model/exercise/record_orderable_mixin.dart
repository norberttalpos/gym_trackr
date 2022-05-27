import 'package:gym_trackr/domain/model/record/record.dart';

mixin RecordOrderableMixin {

  void orderRecordList(List<Record> records) {
    records.sort((a, b) => b.date.compareTo(a.date));
  }
}