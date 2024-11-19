import 'package:dartz/dartz.dart';
import '../entities/task_entity.dart';
import '../../../../core/error/failures.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task);
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(String taskId);
}