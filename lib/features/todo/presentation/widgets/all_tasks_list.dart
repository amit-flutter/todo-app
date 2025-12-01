import 'package:demo/core/constants/label_const.dart';
import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:demo/features/todo/presentation/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTasksList extends StatelessWidget {
  AllTasksList({super.key});

  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.tasks.isEmpty) {
        return const Center(child: Text(LabelConst.noTaskAdded));
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: ctrl.tasks.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) => TaskTile(task: ctrl.tasks[i]),
      );
    });
  }
}
