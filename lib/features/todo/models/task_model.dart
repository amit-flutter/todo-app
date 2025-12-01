import 'package:uuid/uuid.dart';

enum Priority { high, medium, low }

class TaskModel {
  String id;
  String title;
  Priority priority;
  String category; // "Work", "Personal", "Health"
  int estimatedMinutes;
  bool completed;
  DateTime createdAt;

  TaskModel({
    String? id,
    required this.title,
    required this.priority,
    required this.category,
    required this.estimatedMinutes,
    this.completed = false,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'priority': priority.name,
        'category': category,
        'estimatedMinutes': estimatedMinutes,
        'completed': completed,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String?,
      title: map['title'] ?? '',
      priority: Priority.values.firstWhere(
        (p) => p.name == (map['priority'] ?? 'low'),
        orElse: () => Priority.low,
      ),
      category: map['category'] ?? 'Personal',
      estimatedMinutes: (map['estimatedMinutes'] ?? 0) as int,
      completed: map['completed'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}
