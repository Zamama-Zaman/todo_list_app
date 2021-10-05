import 'package:todo_list_app/features/domain/entities/task_entity.dart';
import 'package:todo_list_app/features/domain/repositories/local_repository.dart';

class GetAllTaskUseCase {
  final LocalRepository localRepository;

  GetAllTaskUseCase({required this.localRepository});

  Future<List<TaskEntity>> call() {
    return localRepository.getAllTasks();
  }
}
