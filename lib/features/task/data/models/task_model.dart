import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    super.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  // Conversion from Entity to Model
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      isCompleted: entity.isCompleted,
    );
  }
}
