import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class CreateTask implements UseCase<TaskEntity, TaskEntity> {
  final TaskRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(TaskEntity task) async {
    // Add validation logic
    if (task.title.isEmpty) {
      return Left(DatabaseFailure('Title cannot be empty'));
    }

    return await repository.createTask(task);
  }
}