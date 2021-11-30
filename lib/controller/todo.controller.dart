import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simple_todo_firebase/models/task_model.dart';

class TodoController extends GetxController {
  var isLoading = false;
  var taskList = <TaskModel>[];

  // adding todo
  Future<void> addTodo(String task, bool done) async {
    await FirebaseFirestore.instance.collection('todos').doc().set(
      {
        'task': task,
        'isDone': done,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }

  // getting the todos
  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('todos')
          .orderBy('task')
          .get();

      taskList.clear();

      for (var item in _taskSnap.docs) {
        taskList.add(
          TaskModel(
            task: item['task'],
            isDone: item['isDone'],
          ),
        );
      }
      isLoading = false;
    } catch (e) {
      print(e);
    }
  }
}
