import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_firebase/controller/todo.controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      init: TodoController(),
      initState: (_) {},
      builder: (todoController) {
        todoController.getData();

        return Scaffold(
          body: Center(
            child: todoController.isLoading
                ? const SizedBox(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: todoController.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        child: ListTile(
                          title: Text(todoController.taskList[index].task),
                          tileColor: Colors.grey[300],
                          selectedTileColor: Colors.grey[400],
                          minVerticalPadding: 20,
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _addTaskDialog(
                                      todoController,
                                      'Update Task',
                                      todoController.taskList[index].id,
                                      todoController.taskList[index].task,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await _addTaskDialog(todoController, "Add Todo", '', '');
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Future<void> _addTaskDialog(TodoController todoController, String title,
      String id, String task) async {
    if (task.isNotEmpty) {
      _taskController.text = task;
    }

    Get.defaultDialog(
      titlePadding: EdgeInsets.all(20),
      title: title,
      contentPadding: EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 10,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _taskController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add the todo';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await todoController.addTodo(
                      _taskController.text.trim(), false, id);

                  _taskController.clear();
                  todoController.getData();
                },
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
