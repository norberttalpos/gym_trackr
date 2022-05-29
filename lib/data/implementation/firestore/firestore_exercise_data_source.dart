import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';

import '../../exercise_data_source.dart';

class FireStoreExerciseDataSource implements ExerciseDataSource {
  final CollectionReference _exerciseCollection = FirebaseFirestore.instance.collection('exercises');

  @override
  Future<void> addRecordToExercise(String exerciseName, Record record) async {
    final doc = await getDocRefByExerciseName(exerciseName);

    final data = doc.data() as Map<String, dynamic>;
    final exercise = Exercise.fromJson(data)..records.insert(0, record);

    _exerciseCollection.doc(doc.id).update(exercise.toJson());
  }

  @override
  Future<void> toggleTracked(String exerciseName, bool isTracked) async {
    final doc = await getDocRefByExerciseName(exerciseName);

    final data = doc.data() as Map<String, dynamic>;
    final exercise = Exercise.fromJson(data)..tracked = isTracked;

    _exerciseCollection.doc(doc.id).update(exercise.toJson());
  }

  @override
  Future<void> createExercise(String exerciseName, String type) async {
    final exerciseByName = await getExerciseByName(exerciseName);

    if(exerciseByName == null) {
      _exerciseCollection.add(Exercise(name: exerciseName, tracked: true, type: type).toJson());
    }
  }

  @override
  Future<Exercise?> getExerciseByName(String name) async {
    QuerySnapshot querySnapshot = await _exerciseCollection.where("name", isEqualTo: name).get();

    if(querySnapshot.docs.isEmpty) {
      return null;
    } else {
      return querySnapshot.docs.map((doc) {
        return Exercise.fromJson(doc.data() as Map<String, Object?>);
      }).first;
    }
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

  @override
  Future<void> deleteExercise(String exerciseName) async {
    final doc = await getDocRefByExerciseName(exerciseName);

    _exerciseCollection.doc(doc.id).delete();
  }

  Future<QueryDocumentSnapshot<Object?>> getDocRefByExerciseName(String exerciseName) async {
    QuerySnapshot querySnapshot = await _exerciseCollection.where("name", isEqualTo: exerciseName).get();

    return querySnapshot.docs.first;
  }

}