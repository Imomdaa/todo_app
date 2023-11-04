import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/tasks_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task){
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id=docRef.id ;
   return docRef.set(task);
  }

  static Future<QuerySnapshot<TaskModel>> getTasks(){
   return getTasksCollection().get();
  }
  static  Future<void> deleteTasks(String id) {
    return getTasksCollection().doc(id).delete();
  }
}
