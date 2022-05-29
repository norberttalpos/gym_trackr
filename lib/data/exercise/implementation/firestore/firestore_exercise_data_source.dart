import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_trackr/data/exercise/implementation/firestore/user_docid.dart';
import 'package:gym_trackr/data/user/user_data_source.dart';
import 'package:gym_trackr/domain/model/exercise.dart';
import 'package:gym_trackr/domain/model/record.dart';
import 'package:gym_trackr/domain/model/user.dart';

import '../../exercise_data_source.dart';

class FireStoreExerciseDataSource implements ExerciseDataSource {
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection("users");

  @override
  Future<void> init() async {}

  Future<UserDocId> getUser() async {
    final userId = await UserDataSource.getUserId();
    QuerySnapshot querySnapshot = await _usersCollection.where(
        "userId", isEqualTo: userId).get();

    final doc = querySnapshot.docs.first;
    final data = doc.data() as Map<String, dynamic>;

    return UserDocId(User.fromJson(data), doc.id);
  }

  @override
  Future<List<Exercise>> getExercises() async {
    final userDocId = await getUser();

    return userDocId.user.exercises;
  }

  @override
  Future<Exercise?> getExerciseByName(String name) async {
    final userDocId = await getUser();
    final exercisesByName = userDocId.user.exercises.where((element) => element.name == name);

    if(exercisesByName.isNotEmpty) {
      return exercisesByName.first;
    } else {
      throw Exception("Illegal state: exercise doesn't exist");
    }
  }

  Future<void> updateBase(Function(UserDocId) updateCommand) async {
    final userDocId = await getUser();

    await updateCommand(userDocId);

    await _usersCollection.doc(userDocId.docId).update(userDocId.user.toJson());
  }

  @override
  Future<void> addRecordToExercise(String exerciseName, Record record) async {
    await updateBase((userDocId) {
      userDocId.user.exercises
          .where((element) => element.name == exerciseName)
          .first
          .records
          .insert(0, record);
    });
  }

  @override
  Future<void> toggleTracked(String exerciseName, bool isTracked) async {
    await updateBase((userDocId) {
      userDocId.user.exercises
          .where((element) => element.name == exerciseName)
          .first
          .tracked = isTracked;
    });
  }

  @override
  Future<void> createExercise(String exerciseName, String type) async {
    await updateBase((userDocId) {
      final exerciseAlreadyExists = userDocId.user.exercises
          .where((element) => element.name == exerciseName)
          .isNotEmpty;

      if (!exerciseAlreadyExists) {
        userDocId.user.exercises.add(
            Exercise(name: exerciseName, tracked: true, type: type));
      }
    });
  }

  @override
  Future<void> deleteExercise(String exerciseName) async {
    await updateBase((userDocId) {
      int idx = userDocId.user.exercises.indexWhere((el) =>
      el.name == exerciseName);
      userDocId.user.exercises.removeAt(idx);
    });
  }

}