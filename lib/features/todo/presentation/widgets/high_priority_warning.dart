import 'package:demo/core/constants/label_const.dart';
import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HighPriorityWarning extends StatelessWidget {
  HighPriorityWarning({super.key});

  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!ctrl.highExcludedWarning) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Expanded(
              child: Text(LabelConst.highPriorityTaskWarningMessage),
            ),
          ],
        ),
      );
    });
  }
}
