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
        todoController.getData;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: todoController.isLoading
                  ? const SizedBox(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: todoController.taskList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(todoController.taskList[index].task),
                        );
                      },
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                titlePadding: EdgeInsets.all(20),
                title: 'Add todo',
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
                          onPressed: () async => await todoController.addTodo(
                              _taskController.text.trim(), false),
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
}
