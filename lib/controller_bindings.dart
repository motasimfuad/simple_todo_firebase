import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:simple_todo_firebase/controller/todo.controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<TodoController>(TodoController());
  }
}
