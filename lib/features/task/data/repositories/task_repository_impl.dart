import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local_task_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalTaskDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final tasks = await localDataSource.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch tasks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final createdTask = await localDataSource.createTask(taskModel);
      return Right(createdTask);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTask = await localDataSource.updateTask(taskModel);
      return Right(updatedTask);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await localDataSource.deleteTask(taskId);
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete task: ${e.toString()}'));
    }
  }
}