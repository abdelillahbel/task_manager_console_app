import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasks implements UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}

class NoParams {}