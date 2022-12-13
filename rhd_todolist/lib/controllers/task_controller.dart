import 'package:get/get.dart';
import 'package:rhd_todolist/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  void onRead() {
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  Future<void> addTask({required Task task}) async {
    await DBHelper.insert(task);
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
