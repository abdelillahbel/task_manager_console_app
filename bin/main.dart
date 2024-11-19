import 'dart:io';
import 'package:uuid/uuid.dart';
import '../lib/features/task/domain/entities/task_entity.dart';
import '../lib/features/task/domain/usecases/create_task.dart';
import '../lib/features/task/domain/usecases/get_tasks.dart';
import '../lib/features/task/data/datasources/local_task_datasource.dart';
import '../lib/features/task/data/repositories/task_repository_impl.dart';

void main() async {
  final storageFile = File('tasks.json');
  final localDataSource = LocalTaskDataSource(storageFile);
  final repository = TaskRepositoryImpl(localDataSource);
  final createTask = CreateTask(repository);
  final getTasks = GetTasks(repository);

  while (true) {
    print('\nTask Manager');
    print('1. Add Task');
    print('2. List Tasks');
    print('3. Exit');
    print('Enter your choice: ');

    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        await _addTask(createTask);
        break;
      case '2':
        await _listTasks(getTasks);
        break;
      case '3':
        exit(0);
      default:
        print('Invalid choice');
    }
  }
}

Future<void> _addTask(CreateTask createTask) async {
  print('Enter task title: ');
  final title = stdin.readLineSync() ?? '';
  print('Enter task description: ');
  final description = stdin.readLineSync() ?? '';

  final task = TaskEntity(
    id: const Uuid().v4(),
    title: title,
    description: description,
    createdAt: DateTime.now(),
  );

  final result = await createTask(task);
  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (createdTask) => print('Task created successfully!'),
  );
}

Future<void> _listTasks(GetTasks getTasks) async {
  final result = await getTasks(NoParams());

  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (tasks) {
      if (tasks.isEmpty) {
        print('No tasks found.');
        return;
      }

      print('\nYour Tasks:');
      for (var (index, task) in tasks.indexed) {
        print('${index + 1}. ${task.title}');
        print('   Description: ${task.description}');
        print('   Created At: ${task.createdAt}');
        print('   Status: ${task.isCompleted ? 'Completed' : 'Pending'}');
        print('---');
      }
    },
  );
}