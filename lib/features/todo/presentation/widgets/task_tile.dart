import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:demo/features/todo/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  const TaskTile({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TodoController>();
    return ListTile(
      leading: Checkbox(value: task.completed, onChanged: (_) => ctrl.toggleComplete(task.id)),
      title: Text(task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none,
          )),
      subtitle: Text('${task.category} • ${task.estimatedMinutes} min'),
      trailing: PopupMenuButton<String>(
        onSelected: (v) {
          if (v == 'delete') ctrl.deleteTask(task.id);
        },
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
