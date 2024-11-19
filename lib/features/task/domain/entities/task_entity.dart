class TaskEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isCompleted;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isCompleted = false,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}