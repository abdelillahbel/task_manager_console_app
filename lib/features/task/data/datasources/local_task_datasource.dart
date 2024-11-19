import 'dart:convert';
import 'dart:io';
import '../models/task_model.dart';

class LocalTaskDataSource {
  final File _storageFile;

  LocalTaskDataSource(this._storageFile);

  Future<List<TaskModel>> getTasks() async {
    try {
      if (!await _storageFile.exists()) {
        await _storageFile.create(recursive: true);
        await _storageFile.writeAsString('[]');
        return [];
      }

      final contents = await _storageFile.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      print('Error reading tasks: $e');
      return [];
    }
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await _saveTasks(tasks);
    return task;
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      await _saveTasks(tasks);
    }
    return task;
  }

  Future<void> deleteTask(String taskId) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == taskId);
    await _saveTasks(tasks);
  }

  Future<void> _saveTasks(List<TaskModel> tasks) async {
    final jsonList = tasks.map((task) => task.toJson()).toList();
    await _storageFile.writeAsString(json.encode(jsonList));
  }
}