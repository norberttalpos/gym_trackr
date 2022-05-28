import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';

import '../../exercise_data_source.dart';

class FireStoreExerciseDataSource implements ExerciseDataSource {
  final CollectionReference _exerciseCollection = FirebaseFirestore.instance.collection('exercises');

  @override
  Future<void> addRecordToExercise(String exerciseName, Record record) async {
    QuerySnapshot querySnapshot = await _exerciseCollection.where("name", isEqualTo: exerciseName).get();

    final doc = querySnapshot.docs.first;

    final data = doc.data() as Map<String, dynamic>;
    final exercise = Exercise.fromJson(data)..records.insert(0, record);

    _exerciseCollection.doc(doc.id).update(exercise.toJson());
  }

  @override
  Future<void> createExercise(String exerciseName, String type) async {
    _exerciseCollection.add(Exercise(name: exerciseName, tracked: true, type: type).toJson());
  }

  @override
  Future<Exercise?> getExerciseByName(String name) async {
    QuerySnapshot querySnapshot = await _exerciseCollection.where("name", isEqualTo: name).get();

    return querySnapshot.docs.map((doc) {
      return Exercise.fromJson(doc.data() as Map<String, Object?>);
    }).first;
  }

  @override
  Future<List<Exercise>> getExercises() async {
    QuerySnapshot querySnapshot = await _exerciseCollection.get();

     return querySnapshot.docs.map((doc) {
      return Exercise.fromJson(doc.data() as Map<String, Object?>);
    }).toList();
  }

  @override
  Future<void> init() async {}
}